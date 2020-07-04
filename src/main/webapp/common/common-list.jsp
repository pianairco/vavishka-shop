<%@ page import="ir.piana.dev.strutser.dynamic.sql.SQLParamDef" %>
<%@ page import="ir.piana.dev.strutser.dynamic.sql.SelectColumnDef" %>
<%@ page import="ir.piana.dev.strutser.dynamic.util.FormCommonUtil" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="ir.piana.dev.strutser.dynamic.form.*" %>
<%@ include file="/taglibs.jsp"%>

<html dir="rtl">
<head>
</head>
<body >

<script language="javascript">
    function resetSearchPanel()
    {
        <%="document.forms[0].elements['search.branch.branchCode'].value = '';"%>
    }
</script>

<%
//    String MESSGAE_KEY = "org.apache.struts.action.MESSAGE";
//    MessageResources messageResources = (MessageResources) request.getSession().getServletContext().getAttribute(MESSGAE_KEY);
    FormManager formManager = (FormManager) request.getAttribute("form-manager");
    String title = "";
    FormSelectDef formDef = (FormSelectDef) request.getAttribute("form-def");
    String activity = request.getParameter("activity");
    String tableSourceName = null;
    if(activity != null && !activity.isEmpty()) {
        if(!activity.contains(","))
            tableSourceName = formDef.getActivityMap().get(activity).getTableSourceName();
        else {
            String[] split = activity.split(",");
            String ac = split[split.length - 1];
            tableSourceName = formDef.getActivityMap().get(ac).getTableSourceName();
        }
    }
    String[] split = formDef.getName().split("@");
    String formActionUrl = split[0] + "?method=" + split[1] + "&persist=true";

    //>>edit start
    String sortPropertyParam = "";//formDef.getSortProperty();
    String sortOrderParam = "";//formDef.getSortOrder();
//    String sortHref = formDef.getActionURL().concat("?").concat("sort_mode=true&method=")
//            .concat(displayDef.getActionMethod()).concat("&");

    String[] splited = formDef.getName().split("@");
    String sortHref = split[0].concat(".do?")
            .concat("method=").concat(splited[1])
            .concat("&persist=true")
            .concat("&activity=")
            .concat(formDef.getTableActivity())
            .concat("&sort_mode=true&");
    if(sortHref.startsWith("/"))
        sortHref = sortHref.substring(1);
    //<<edit end
    //--dont edit-->>
    String sortOrder = "asc";
    String sortedStyleClass = "";
    String columnStyleClass = "";
    String sortableStyleClass = "sortable";
    if(session.getAttribute(sortOrderParam) != null) {
        sortOrder = (String) session.getAttribute(sortOrderParam);
        if(sortOrder == null)
            sortOrder = "asc";
        if(sortOrder.equals("asc")) {
            sortedStyleClass = "order1 sortable sorted";
        } else {
            sortedStyleClass = "order2 sortable sorted";
        }
    }
    String sortProperty = "";
    if (session.getAttribute(sortPropertyParam) != null)
        sortProperty=(String) session.getAttribute(sortPropertyParam);
    String href = "";
    String commonHref = "<a href='"+sortHref+sortPropertyParam+"=";
    //--dont edit--<<
    boolean showPageNumberControl = request.getAttribute("list-map") == null ? true : false;
%>

<script language="javascript">
    function resetSearchPanel()
    {
        <%
        for(SQLParamDef SQLParamDef : formDef.getSearchParams()) {
            String d = "document.forms[0].elements['" + SQLParamDef.getKey() + "'].value = '';";
        %>
        <%=d%>
        <%
        }
        %>
    }

    function print(activity) {
        if(checkForSubmit()) {
            document.getElementsByName("print-activity")[0].value = activity;
            document.forms[0].target = "_blank";
            document.forms[0].submit();
            document.forms[0].target = "";
            document.getElementsByName("print-activity")[0].value = "";
        }
    }
</script>

<table bgcolor="#bbbbbb" border="0" cellpadding="1" cellspacing="0" width="100%">
    <tr >
        <td  >
            <table width="100%" class="content" border="0" style="border-collapse:collapse">
                <tr class="VNformheader" >
                    <td width="50%" style="padding: 0 6px">
                        <%
                            if(formDef.getTitle() != null) {
                                String pageTitle = formDef.getTitle();
                        %>
                        <h4 style="margin-top: 0px; padding: 8px 0px;">
                            <%=formDef.getPropertyValue(pageTitle)%>
                        </h4>
                        <%
                            }
                        %>
                    </td>
                    <td width="50%" style="direction: ltr; padding: 0 6px">
                        <%
                            if(formDef.getPrintButtons() != null && !formDef.getPrintButtons().isEmpty()) {
                                for (PrintButton pb : formDef.getPrintButtons()) {
                                    if(pb.getImageSrc() != null && !pb.getImageSrc().isEmpty()) {
                        %>
                                <img height="18" width="18" style="cursor:hand" src="<%=pb.getImageSrc()%>" border="0" onclick="print('<%=pb.getActivity()%>')" title="<%=pb.getTitle()%>">
                       <%
                                    } else {
                       %>
                                <button onclick="print('<%=pb.getActivity()%>')"><%=pb.getTitle()%></button>
                        <%
                                    }
                                }
                            }
                        %>
<%--                        <button onclick="print('createPdf')">PDF</button>--%>
<%--                        <button onclick="print('createExcel')">Excel</button>--%>
                    </td>
                </tr>
            </table>

            <%
                if(formDef.isSeparateTab()) {
            %>
            <jsp:include page="common-tab-list.jsp">
                <jsp:param name="title" value="1"/>
            </jsp:include>
            <%
                } else {
            %>

            <table id="xxxxxxxx" width="100%" class="content" border="0" style="border-collapse:collapse; background-color: white;">
                <tr class=caption valign=top align=center>
                    <td width="20%" style="background-color: #f0f0f0; border: 2px solid #bbbbbb;">
                        <div id="search" class="">
                            <table width="100%">
                                <tr >&nbsp;</tr>
                                <tr>
                                    <td>
                                        <jsp:include page="common-controls.jsp">
                                            <jsp:param name="forList" value="true"/>
                                            <jsp:param name="pageNumber" value="<%=showPageNumberControl%>"/>
                                        </jsp:include>
                                    </td>
                                </tr>
                                <tr >&nbsp;</tr>
                            </table>
                        </div>
                    </td>
                    <td width="80%" colspan=4 valign=top>
                        <%
                            if(formDef != null) { //#if formDef
                                Object pageSizeObject = request.getSession().getAttribute("common.search.pageSize");
                                String pageSize = "30";
                                if(pageSizeObject != null)
                                    pageSize = (String) pageSizeObject;
                                String tableQueryName = tableSourceName != null ? tableSourceName : formDef.getQueryName();
                                String tableName = (tableQueryName + "_List").replaceAll("-", "_");
                                String tableQuery = tableQueryName;
//                                String tableQuery = formDef.getQueryName() + "Query";
                                String tableSize = (tableQueryName + "_Size").replaceAll("-", "_");
                                String tableId = (tableQueryName + "_table").replaceAll("-", "_");
                                String decorator = formDef.getDecorator();
                                String fundType = (String)request.getAttribute("fund-type");
                        %>

                        <%
                            if(request.getAttribute(tableQuery) != null && request.getAttribute(tableName) == null) {
                        %>

<%--                        <dtsource:jdbc pagesize="<%=new Long(pageSize)%>" id="<%=tableId%>" list="<%=tableName%>" sizelist="<%=tableSize%>" defaultsortName="" alias="" table="">--%>
<%--                            <%=request.getAttribute(tableQuery)%>--%>
<%--                        </dtsource:jdbc>--%>

                        <%
                            }
                            Map<String, Object> listMap = null;
                            Object attribute = null;
                            if(request.getAttribute(tableQuery) != null) {
                                listMap = new LinkedHashMap<>();
                                listMap.put(null, request.getAttribute(tableName));
                            } else if((attribute = request.getAttribute("list-map")) != null) {
                                listMap = (Map<String, Object>) attribute;
                            } else {
                                listMap = new LinkedHashMap<>();
                                listMap.put(null, new ArrayList<>());
                            }
//                                Object attribute = request.getAttribute(tableQuery);
//                                if (attribute == null) {
//                                    request.setAttribute(tableSize, 0);
//                                    request.setAttribute(tableName, new ArrayList<>());
//                                }

                        %>

                        <div id="list" class="">
                            <table width="100%" style="background-color: #bbbbbb;">
                                <tr>
                                    <td>
                                            <%
                                        if(formDef.getFormSelectColumnDefs() != null && !formDef.getFormSelectColumnDefs().isEmpty()) {
                                            int index = 0;
                                            for(String keyMap : listMap.keySet()) {
                                                String tableName2 = tableName.concat(String.valueOf(++index));
                                                request.setAttribute(tableName2, listMap.get(keyMap));
                                                String tableId2 = tableId.concat(String.valueOf(index));
                                                String pageSize2 = keyMap == null ? pageSize : String.valueOf(((List)listMap.get(keyMap)).size());
                                                String tableSize2 = tableSize.concat(String.valueOf(index));
                                                request.setAttribute(tableSize2, Integer.valueOf(pageSize2));
                                    %>

                                        <display:table name="<%=tableName2%>" requestURI="" class="list" id="<%=tableId2%>" export="false"
                                                       pagesize="<%=new Integer(pageSize2)%>" decorator="<%=decorator%>"
                                                       partialList="true" size="<%=tableSize2%>"
                                                       cellspacing="1"  offset="0" cellpadding="2">

                                                <%
                                            for(FormSelectColumnDef displayColumnDef : formDef.getFormSelectColumnDefs())  { //#for displayColumnDef
                                                if(displayColumnDef.getForFundType() != null && !displayColumnDef.getForFundType().isEmpty() &&
                                                    !displayColumnDef.getForFundType().equalsIgnoreCase(fundType))
                                                        continue;

                                        %>

                                                <%
                                                String columnClass = "";
                                            if(displayColumnDef.isTooltip())
                                                columnClass = "show-title";
                                            if(displayColumnDef.isSortable()) {//#if displayColumnDef.isSortable()
                                                String newOrder = sortOrder == null ? "asc" : sortOrder.equalsIgnoreCase("asc") ? "desc" : "asc";
                                                href = commonHref + displayColumnDef.getProperty() + "&" + sortOrderParam + "=" + newOrder +  "'>" + formDef.getPropertyValue(displayColumnDef.getTitle()) + "</a>";
//                                    href = commonHref + displayColumnDef.getProperty() + "&" + sortOrderParam + "=" + newOrder +  "'>" + messageResources.getMessage(displayColumnDef.getTitleKey()) + "</a>";
                                                columnStyleClass = sortProperty.equals(displayColumnDef.getProperty()) ? sortedStyleClass : sortableStyleClass;

                                        %>

                                            <display:column class="<%=columnClass%>" property="<%=displayColumnDef.getProperty()%>" headerClass="<%=columnStyleClass%>" title="<%=href%>" />

                                                <%
                                        } //#if displayColumnDef.isSortable()
                                        else {//#if !displayColumnDef.isSortable()
                                        %>

                                            <display:column class="<%=columnClass%>" property="<%=displayColumnDef.getProperty()%>" title="<%=formDef.getPropertyValue(displayColumnDef.getTitle())%>" />

                                                <%
                                            }//#if !displayColumnDef.isSortable()
                                        %>

                                                <%
                                            }//#for displayColumnDef
                                        %>

                                                <%
                                            StringBuffer df = new StringBuffer();
                                            if(!formDef.getFooterDefs().isEmpty()) {
                                                Map<String, BigDecimal> footerMap = FormCommonUtil.evalFooter(request.getAttribute(tableName2), formDef.getFooterDefs().get(0));
                                            for (FooterDef footerDef : formDef.getFooterDefs()) {
                                                df.append("<tr>");
                                                Map<String, String> footer = FormCommonUtil.createFooter(formDef, footerDef, fundType);
                                                for (String span : footer.keySet()) {
                                                    df.append("<td colspan=\"").append(span.substring(span.indexOf(":") + 1)).append("\">");
                                                    String key = footer.get(span);
                                                    if (key != null && key.startsWith("@"))
                                                        df.append(formDef.getPropertyValue(key.substring(1) == null ? "" : key.substring(1)));
                                                    else if (key == null)
                                                        df.append("");
                                                    else
                                                        df.append(footerMap.get(key) == null ? "" : footerMap.get(key));
                                                    df.append("</td>");
                                                }
                                                df.append("</tr>");
                                            }
                                            }
                                        %>

                                        <display:caption>
                                <tr style="background-color: #004a95">
                                    <td colspan="<%=((FormSelectDef)formDef).getFormSelectColumnDefs().size()%>" style="color:white; text-align: center;"><%=keyMap != null ? keyMap : ""%></td>
                                </tr>
                                </display:caption>

                                <display:footer>
                                    <%=df.toString()%>
                                </display:footer>

                                </display:table>

                                <%
                                    }
                                } else {
                                %>
                                <display:table name="<%=tableName%>" requestURI="" class="list" id="<%=tableId%>" export="false"
                                               pagesize="<%=new Integer(pageSize)%>" decorator="<%=decorator%>"
                                               partialList="true" size="<%=tableSize%>"
                                               cellspacing="1"  offset="0" cellpadding="2">

                                    <%
                                        for(SelectColumnDef displayColumnDef : formManager.getSelectColumns(tableQueryName))  { //#for displayColumnDef
                                            if(displayColumnDef.isShow()) {
                                    %>

                                    <%
                                        if(displayColumnDef.isSortable()) {//#if displayColumnDef.isSortable()
                                            String newOrder = sortOrder == null ? "asc" : sortOrder.equalsIgnoreCase("asc") ? "desc" : "asc";
                                            href = commonHref + displayColumnDef.getProperty() + "&" + sortOrderParam + "=" + newOrder +  "'>" + formDef.getPropertyValue(displayColumnDef.getTitle()) + "</a>";
//                                    href = commonHref + displayColumnDef.getProperty() + "&" + sortOrderParam + "=" + newOrder +  "'>" + messageResources.getMessage(displayColumnDef.getTitleKey()) + "</a>";
                                            columnStyleClass = sortProperty.equals(displayColumnDef.getProperty()) ? sortedStyleClass : sortableStyleClass;

                                    %>

                                    <display:column style="width:8%" property="<%=displayColumnDef.getProperty()%>" headerClass="<%=columnStyleClass%>" title="<%=href%>" />

                                    <%
                                    } //#if displayColumnDef.isSortable()
                                    else {//#if !displayColumnDef.isSortable()
                                    %>

                                    <display:column style="width:8%" property="<%=displayColumnDef.getProperty()%>" title="<%=displayColumnDef.getTitle()%>" />

                                    <%
                                        }//#if !displayColumnDef.isSortable()
                                    %>

                                    <%
                                            }
                                        }//#for displayColumnDef
                                    %>

                                </display:table>
                                <%
                                    }
                                %>
                                </td>
                                </tr>
                            </table>
                        </div>

                        <%
                            }//#if formDef
                        %>
                    </td>
                </tr>
            </table>

            <%
                }
            %>
        </td>
    </tr>
</table>

</body>
</html>
<%--<html:javascript formName="customerMessageForm" staticJavascript="false" cdata="false"/>--%>
<%--<script type="text/javascript" src="<c:url value="/scripts/validator.jsp"/>"></script>--%>