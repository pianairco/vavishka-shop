package ir.piana.dev.strutser.action.common;

import ir.piana.dev.strutser.data.manager.GenericManager;
import ir.piana.dev.strutser.dynamic.form.*;
import ir.piana.dev.strutser.dynamic.sql.*;
import org.apache.struts.action.*;
import org.apache.struts.actions.DispatchAction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.util.stream.Collectors;

@Component("common")
public class CommonDispatchAction extends DispatchAction {
    @Autowired
    protected GenericManager manager;
    protected SQLQueryManagerProvider sqlManagerProvider;
    protected SQLQueryManager sqlQueryManager;

    @Autowired
    private FormManagerProvider formManagerProvider;
    @Autowired
    private SQLQueryManagerProvider sqlQueryManagerProvider;

    public CommonDispatchAction() {
    }

    @Autowired
    public CommonDispatchAction(
            FormManagerProvider formManagerProvider,
            SQLQueryManagerProvider sqlQueryManagerProvider) {
        this.formManagerProvider = formManagerProvider;
        this.sqlQueryManagerProvider = sqlQueryManagerProvider;
        this.sqlQueryManager = this.sqlQueryManagerProvider.getSqlQueryManager();
    }

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        if(this.isCancelled(request)) {
            ActionForward af = this.cancelled(mapping, form, request, response);
            if(af != null) {
                return af;
            }
        }

        String parameter = this.getParameter(mapping, form, request, response);
        String name = this.getMethodName(mapping, form, request, response, parameter);
        if(!"execute".equals(name) && !"perform".equals(name)) {
            return this.dispatchMethod(mapping, form, request, response, name);
        } else {
            String message = messages.getMessage("dispatch.recursive", mapping.getPath());
            log.error(message);
            throw new ServletException(message);
        }
    }

    public ActionForward dispatchMethod(
            ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response,
            String name)
            throws Exception {
        if (name == null)
            return this.unspecified(mapping, form, request, response);

        Method method = null;
        String message = null;
        try {
            method = this.getMethod(name);
        } catch (NoSuchMethodException var13) {
            ActionForward common = common(mapping, form, request, response, mapping.getPath() + "@" + name);
            return common;
        }
        try {
            Object[] args = new Object[]{mapping, form, request, response};
            ActionForward forward = null;
            if(method != null)
                forward = (ActionForward) method.invoke(this, args);
            else
                forward = common(mapping, form, request, response, mapping.getPath() + "@" + name);
            return forward;
        } catch (ClassCastException var14) {
            message = messages.getMessage("dispatch.return", mapping.getPath(), name);
            log.error(message, var14);
            throw var14;
        } catch (IllegalAccessException var15) {
            message = messages.getMessage("dispatch.error", mapping.getPath(), name);
            log.error(message, var15);
            throw var15;
        } catch (InvocationTargetException var16) {
            Throwable t = var16.getTargetException();
            if (t instanceof Exception) {
                throw (Exception) t;
            } else {
                message = messages.getMessage("dispatch.error", mapping.getPath(), name);
                log.error(message, var16);
                throw new ServletException(t);
            }
        }
    }

    public ActionForward common(ActionMapping mapping, ActionForm form,
                                HttpServletRequest request,
                                HttpServletResponse response, String formName) throws SQLException, RayanSQLException {
        FormDef formDef = formManagerProvider.getFormManager().getFormDef(formName);

//        boolean hasAccess = formDef.getPermissions().isEmpty() ? true : false;
//        for (String perm : formDef.getPermissions()) {
//            if(CommonUtils.hasAccessTo(request.getSession(), perm)) {
//                hasAccess = true;
//                break;
//            }
//        }
//        if(!hasAccess) {
//            return mapping.findForward("accessDenied");
//        }

        request.setAttribute("form-def", formDef);
        request.setAttribute("form-manager", formManagerProvider.getFormManager());

        if(!formDef.getInitialSelects().isEmpty()) {
            for(ElementInitialSelect elementInitialSelect : formDef.getInitialSelects()) {
                try {
                    sqlQueryManager.query(elementInitialSelect.getQueryName(),
                            manager.getGenericJdbcDAO().getDataSource(), request,
                            new StrutsParameterProvider(request, new LinkedHashMap<>()), elementInitialSelect.getName());
                    if(elementInitialSelect.getMapper() != null && !elementInitialSelect.getMapper().isEmpty()) {
                        Object attribute = request.getAttribute(elementInitialSelect.getName());
                        if(attribute != null && attribute instanceof List && ((List)attribute).size() == 1) {
                            Map map = (Map)((List) attribute).get(0);
                            for(String mapped : elementInitialSelect.getMapper()) {
                                String[] split = mapped.split(":");
                                request.getSession().setAttribute(split[1], map.get(split[0]));
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        manageActivity(form, request, formDef);

//        if(formDef instanceof FormPersistDef) {
//            executeCommonPersist(request, response, (FormPersistDef) formDef, messages);
//        } else if(formDef instanceof FormSelectDef)
//            executeCommonSelect(request, response, (FormSelectDef) formDef);

        String printActivityName = request.getParameter("print-activity");
        if(printActivityName != null && !printActivityName.isEmpty()) {
            Connection connection = null;
            Statement statement = null;
            try {
                Field declaredField = this.getClass().getField(printActivityName);
                if(declaredField.getType().equals(PrintActivity.class)) {
                    PrintActivity fieldValue = (PrintActivity) declaredField.get(this);
                    SQLExecuter sqlExecuter = SQLExecuter.getInstance();
                    Queue<ActionActivity> actionActivities = new LinkedList<>();
                    DataSource dataSource = manager.getGenericJdbcDAO().getDataSource();
                    connection = dataSource.getConnection();
                    connection.setAutoCommit(false);
                    statement = connection.createStatement();
                    String fileName = fieldValue.print(sqlExecuter, statement, request);
                    return new ActionForward("/forward.jsp?forward=show.image&___filename=" + fileName == null ? "" : fileName);
                }
            } catch (Exception e) {
                log.error(e.getMessage());
            } finally {
                if(statement != null)
                    statement.close();
                if(connection != null) {
                    connection.setAutoCommit(true);
                    connection.close();
                }
            }
        }

        return mapping.findForward("common");
//        return mapping.findForward("common-jsp");
    }

    public ActionForward custom(ActionMapping mapping, ActionForm form,
                                HttpServletRequest request,
                                HttpServletResponse response, String formName) {
//         FormPersistDef formInsertDef = formManagerProvider.getFormManager().getFormPersistDef(formName);

        FormDef formDef = formManagerProvider.getFormManager().getFormDef(formName);

        request.setAttribute("form-def", formDef);
        request.setAttribute("form-manager", formManagerProvider.getFormManager());

//        manageActivity(form, request, formDef);

        if(!formDef.getInitialSelects().isEmpty()) {
            for(ElementInitialSelect elementInitialSelect : formDef.getInitialSelects()) {
                try {
                    sqlQueryManager.query(elementInitialSelect.getQueryName(),
                            manager.getGenericJdbcDAO().getDataSource(), request,
                            new StrutsParameterProvider(request, new LinkedHashMap<>()), elementInitialSelect.getName());
                    if(elementInitialSelect.getMapper() != null && !elementInitialSelect.getMapper().isEmpty()) {
                        Object attribute = request.getAttribute(elementInitialSelect.getName());
                        if(attribute != null && attribute instanceof List && ((List)attribute).size() == 1) {
                            Map map = (Map)((List) attribute).get(0);
                            for(String mapped : elementInitialSelect.getMapper()) {
                                String[] split = mapped.split(":");
                                request.getSession().setAttribute(split[1], map.get(split[0]));
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

//        if(formDef instanceof FormPersistDef) {
//            executeCommonPersist(request, response, (FormPersistDef) formDef, messages);
//        } else if(formDef instanceof FormSelectDef)
//            executeCommonSelect(request, response, (FormSelectDef) formDef);

        return mapping.findForward("common");
//        return mapping.findForward("common-jsp");
    }

    protected String getValue(HttpServletRequest request, String key) {
        return getValue(request, key, false);
    }

    protected String getValue(HttpServletRequest request, String key, boolean saveToSession) {
        Object obj = null;
        if(request != null) {
            obj = request.getParameter(key);
            if (obj == null)
                obj = request.getAttribute(key);
            if (obj == null)
                obj = request.getSession().getAttribute(key);
            if(saveToSession)
                request.getSession().setAttribute(key, obj);
        }
        return (String)obj;
    }

    public void executeCommonSelect(HttpServletRequest request, HttpServletResponse response, FormSelectDef formSelectDef)
            throws SQLException {
        String pageSize = getValue(request, "common.search.pageSize", true);
        String firstLoad = getValue(request, "new_search", false);
        request.setAttribute("include", "list");
        if(firstLoad == null || firstLoad.isEmpty() || firstLoad.equals("false")) {
            String query = sqlQueryManager.createQuery(formSelectDef.getQueryName(), request, new StrutsParameterProvider(request, new LinkedHashMap<>()));
            request.setAttribute(formSelectDef.getQueryName(), query);
        }
//        sqlQueryManager.query(formSelectDef.getQueryName(), getManager().getGenericJdbcDAO().getDataSource(), request, null);

//        if(!formSelectDef.getInitialSelects().isEmpty()) {
//            for(ElementInitialSelect elementSelect : formSelectDef.getInitialSelects()) {
//                try {
//                    sqlQueryManager.query(elementSelect.getQueryName(),
//                            getManager().getGenericJdbcDAO().getDataSource(),
//                            request, new LinkedHashMap<>(), elementSelect.getName());
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//        }
    }

    private void manageActivity(ActionForm form, HttpServletRequest request, FormDef formDef)
            throws SQLException, RayanSQLException {
        String activities = request.getParameter("activity");
        if(activities == null || activities.isEmpty()) {
            Object obj = request.getSession().getAttribute(formDef.getName().concat("-").concat("activity"));
            if(obj != null)
                activities = (String) obj;
            else {
                activities = request.getParameter("activity");
                if(activities == null)
                    return;
            }

        }
        request.getSession().setAttribute(formDef.getName().concat("-").concat("activity"), activities);
        for(String activity : activities.split(",")) {
            if (activity != null && formDef.getActivityMap().containsKey(activity)) {
                ElementActivity elementActivity = formDef.getActivityMap().get(activity);
//                for (String permission : elementActivity.getPermissions()) {
//                    if (!CommonUtils.hasPermission(request.getSession(), permission)) {
//                        ActionMessages messages = new ActionMessages();
//                        messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("general.not-permission"));
//                        saveErrors(request.getSession(), messages);
//                        return;
//                    }
//                }

                SQLExecuter sqlExecuter = SQLExecuter.getInstance();
                List<ElementActivity.Operation> operations = elementActivity.getOperations();
                Connection connection = null;
                Statement statement = null;
                Queue<ActionActivity> actionActivities = new LinkedList<>();
                try {
                    DataSource dataSource = manager.getGenericJdbcDAO().getDataSource();
                    connection = dataSource.getConnection();
                    connection.setAutoCommit(false);
                    statement = connection.createStatement();
                    for (ElementActivity.Operation operation : operations) {
                        if (operation.getOperationType() == OperationType.QUERY) {
                            SQLType sqlType = sqlQueryManager.getSQLType(operation.getName());
                            String query = sqlQueryManager.createQuery(operation.getName(), request,
                                    new StrutsParameterProvider(request, new LinkedHashMap<>()), formDef.getParameterPrefix());
                            sqlExecuter.query(query, sqlType, statement, request,
                                    new StrutsParameterProvider(request, new LinkedHashMap<>()), operation.getResultAttributeName());
                        } else if (operation.getOperationType() == OperationType.QUERY_STRING) {
                            getValue(request, "common.search.pageSize", true);
                            SQLType sqlType = sqlQueryManager.getSQLType(operation.getName());
                            String query = sqlQueryManager.createQuery(operation.getName(), request,
                                    new StrutsParameterProvider(request, new LinkedHashMap<>()), formDef.getParameterPrefix());
                            request.setAttribute(operation.getResultAttributeName(), query);
                        } else if (operation.getOperationType() == OperationType.FUNCTION) {
                            Field declaredField = this.getClass().getField(operation.getName());
                            if(declaredField.getType().equals(ActionActivity.class)) {
                                ActionActivity fieldValue = (ActionActivity)declaredField.get(this);
                                fieldValue.commit(sqlExecuter, statement, request);
                                actionActivities.add(fieldValue);
                            }
                        }
                    }
                    connection.commit();
                    if (elementActivity.getSuccessMessage().getMessageKey() != null && !elementActivity.getSuccessMessage().getMessageKey().isEmpty()) {
                        ActionMessages messages = new ActionMessages();
                        List<String> parameters = elementActivity.getSuccessMessage().getParameters();
                        Object[] params = parameters.stream().map(key -> getValue(request, key)).collect(Collectors.toList()).toArray(new Object[0]);
                        messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage(
                                elementActivity.getSuccessMessage().getMessageKey(), params));
                        saveMessages(request.getSession(), messages);
                    }
                } catch (Exception ex) {
                    connection.rollback();
                    ActionActivity fieldValueEntry = null;
                    while ((fieldValueEntry = actionActivities.poll()) != null) {
                        try {
                            fieldValueEntry.rollback(sqlExecuter, statement, request);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    if (elementActivity.getFailureMessage().getMessageKey() != null && !elementActivity.getFailureMessage().getMessageKey().isEmpty()) {
                        ActionMessages messages = new ActionMessages();
                        List<String> parameters = elementActivity.getFailureMessage().getParameters();
                        Object[] params = parameters.stream().map(key -> getValue(request, key)).collect(Collectors.toList()).toArray(new Object[0]);
                        messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage(
                                elementActivity.getFailureMessage().getMessageKey(), params));
                        saveMessages(request.getSession(), messages);
                    }
                } finally {
                    statement.close();
                    connection.setAutoCommit(true);
                    connection.close();
                }
            }
        }
    }
}
