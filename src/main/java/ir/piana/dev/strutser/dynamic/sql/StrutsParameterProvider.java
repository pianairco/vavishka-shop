package ir.piana.dev.strutser.dynamic.sql;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by mj.rahmati on 1/5/2020.
 */
public class StrutsParameterProvider implements ParameterProvider {
    private HttpServletRequest request;
    private Map<String, Object> paramMap;
    private boolean preferredParamMap;

    public StrutsParameterProvider(HttpServletRequest request, Map<String, Object> paramMap) {
        this(request, paramMap, false);
    }

    public StrutsParameterProvider(HttpServletRequest request, Map<String, Object> paramMap, boolean preferredParamMap) {
        this.request = request;
        this.paramMap = paramMap;
        this.preferredParamMap = preferredParamMap;
    }

    @Override
    public <T> T get(String paramName) {
        if(preferredParamMap)
            return getPreferredParamMap(paramName);
        else
            return getPreferredRequest(paramName);
    }

    public <T> T getPreferredParamMap(String paramName) {
        Object obj = null;
        if(paramMap != null)
            obj = paramMap.get(paramName);
        if(obj == null && request != null) {
            obj = request.getParameter(paramName);
            if (obj == null)
                obj = request.getAttribute(paramName);
            if (obj == null)
                obj = request.getSession().getAttribute(paramName);
            request.getSession().setAttribute(paramName, obj);
        }
        return (T)obj;
    }

    public <T> T getPreferredRequest(String paramName) {
        Object obj = null;
        if(request != null) {
            obj = request.getParameter(paramName);
            if (obj == null)
                obj = request.getAttribute(paramName);
            if (obj == null)
                obj = request.getSession().getAttribute(paramName);
            request.getSession().setAttribute(paramName, obj);
        }
        if(obj == null && paramMap != null)
            obj = paramMap.get(paramName);
//        if(obj == null)
//            return "";
        return (T)obj;
    }

    @Override
    public <T> T getValue(String key, String type) {
        if(preferredParamMap)
            return getValuePreferredParamMap(key, type);
        else
            return getValuePreferredRequest(key, type);
    }

    public <T> T getValuePreferredParamMap(String key, String type) {
        Object obj = null;
        if(paramMap != null)
            obj = paramMap.get(key);
        if(obj == null && request != null) {
            obj = request.getParameter(key);
            if (obj == null)
                obj = request.getAttribute(key);
            if (obj == null)
                obj = request.getSession().getAttribute(key);
            request.getSession().setAttribute(key, obj);
        }
        if(obj == null) {
            if(type.equals("string"))
                return (T) "";
            else
                return null;
        }
        return (T) obj;
    }

    public <T> T getValuePreferredRequest(String key, String type) {
        Object obj = null;
        if(request != null) {
            obj = request.getParameter(key);
            if (obj == null)
                obj = request.getAttribute(key);
            if (obj == null)
                obj = request.getSession().getAttribute(key);
            request.getSession().setAttribute(key, obj);
        }
        if(obj == null && paramMap != null)
            obj = paramMap.get(key);
        if(obj == null) {
            if(type.equals("string"))
                return (T) "";
            else
                return null;
        }
        return (T) obj;
    }
}
