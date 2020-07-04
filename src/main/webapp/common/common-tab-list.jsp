<%@ page import="ir.piana.dev.strutser.dynamic.form.FormManager"%>
<%@ page import="ir.piana.dev.strutser.dynamic.form.FormSelectColumnDef"%>
<%@ page import="ir.piana.dev.strutser.dynamic.form.FormSelectDef" %>
<%@ page import="ir.piana.dev.strutser.dynamic.sql.SQLParamDef" %>
<%@ page import="org.apache.struts.util.MessageResources" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="ir.piana.dev.strutser.dynamic.sql.SelectColumnDef" %>
<%@ page import="ir.piana.dev.strutser.dynamic.util.FormCommonUtil" %>
<%--<%@ page import="org.broker.util.CommonUtils" %>--%>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="ir.piana.dev.strutser.dynamic.form.FooterDef" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ include file="/taglibs.jsp"%>

<html dir="rtl">
<head>
    <style>
        .tab {
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
            padding: 0px 45%;
        }

        /* Style the tab content */
        .tabcontent {
            display: none;
            padding: 0px 0px;
            border: 1px solid #ccc;
            border-top: none;
        }

        .tabcontent.active{
            display: block;
        }
    </style>
</head>
<body >

<%
//    String MESSGAE_KEY = "org.apache.struts.action.MESSAGE";
//    MessageResources messageResources = (MessageResources) request.getSession().getServletContext().getAttribute(MESSGAE_KEY);
    FormManager formManager = (FormManager) request.getAttribute("form-manager");
    String title = "";
    FormSelectDef formDef = (FormSelectDef) request.getAttribute("form-def");
    String activity = request.getParameter("activity");
    String tableSourceName = null;
    if(activity != null && !activity.isEmpty())
        tableSourceName = formDef.getActivityMap().get(activity).getTableSourceName();
    String[] split = formDef.getName().split("@");
//    String formActionUrl = split[0] + "?method=" + split[1] + "&persist=true";

    //>>edit start
    String sortPropertyParam = formDef.getSortProperty();
    String sortOrderParam = formDef.getSortOrder();
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
    String headerColumnStyleClass = "";
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
    String fundType = (String)request.getAttribute("fund-type");
%>

<script language="javascript">
    function openTab(evt, tabName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].className = tabcontent[i].className.replace(" active", "");
        }
        // for (i = 0; i < tabcontent.length; i++) {
        //     tabcontent[i].style.display = "none";
        // }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        // document.getElementById(tabName).style.display = "block";
        document.getElementById(tabName).className += " active";
        evt.currentTarget.className += " active";
    }

    $(document).ready(function() {
        $("td.show-title").each(function(){
            str = $(this).html();
            if(str.length > 30) {
                $(this).attr("title", str);
                $(this).html(str.substring(0, 30) + "...");
            }
        });
    });
</script>


<div class="tab">
    <button class="tablinks button" id="btn-search" onclick="openTab(event, 'search')"><%=formDef.getPropertyValue("button.search")%></button>
    <button class="tablinks button" id="btn-result" onclick="openTab(event, 'list')"><%=formDef.getPropertyValue("button.result")%></button>
</div>

<div id="search" class="tabcontent">
<table width="100%">
    <tr>
        <td>
            <jsp:include page="common-controls.jsp">
                <jsp:param name="forList" value="true"/>
                <jsp:param name="pageNumber" value="<%=showPageNumberControl%>"/>
            </jsp:include>
        </td>
    </tr>
</table>
</div>
<div id="list" class="tabcontent">
<table width="100%">
    <tr>
        <td>
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
            %>

            <%
                if(request.getAttribute(tableQuery) != null && request.getAttribute(tableName) == null) {
            %>

<%--            <dtsource:jdbc pagesize="<%=new Long(pageSize)%>" id="<%=tableId%>" list="<%=tableName%>" sizelist="<%=tableSize%>" defaultsortName="" alias="" table="">--%>
<%--                <%=request.getAttribute(tableQuery)%>--%>
<%--            </dtsource:jdbc>--%>

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
                <table width="100%" style="background-color: #bbbbbb;">
                    <tr>
                        <td>
                                <%
                                        int colPrecentage = 100 / formDef.getFormSelectColumnDefs().size();
                                        if(formDef.getFormSelectColumnDefs() != null && !formDef.getFormSelectColumnDefs().isEmpty()) {
                                            int index = 0;
                                            Map<String, BigDecimal> totalFooterMap = new LinkedHashMap<>();
                                            for(String keyMap : listMap.keySet()) {
                                                String tableName2 = tableName.concat(String.valueOf(++index));
                                                request.setAttribute(tableName2, listMap.get(keyMap));
                                                String tableId2 = tableId.concat(String.valueOf(index));
                                                String pageSize2 = keyMap == null ? pageSize : String.valueOf(((List)listMap.get(keyMap)).size());
                                                String tableSize2 = tableSize.concat(String.valueOf(index));
                                                request.setAttribute(tableSize2, Integer.valueOf(pageSize2));
                                %>
                                        <%
                                            StringBuffer df = new StringBuffer();
                                            if(!formDef.getFooterDefs().isEmpty()) {
                                            Map<String, BigDecimal> footerMap = FormCommonUtil.evalFooter(request.getAttribute(tableName2), formDef.getFooterDefs().get(0));
                                            if(totalFooterMap.isEmpty()) {
                                                totalFooterMap.putAll(footerMap);
                                            } else {
                                                for(String key : totalFooterMap.keySet()) {
                                                    totalFooterMap.put(key, totalFooterMap.get(key).add(footerMap.get(key) != null ? footerMap.get(key) : new BigDecimal(0)));
                                                }
                                            }
                                            for (ir.fund.data.form.FooterDef footerDef : formDef.getFooterDefs()) {
                                                df.append("<tr>");
                                                Map<String, String> footer = FormCommonUtil.createFooter(formDef, footerDef, fundType);
                                                for (String span : footer.keySet()) {
                                                    String spanVal = span.substring(span.indexOf(":") + 1);
                                                    df.append("<td colspan=\"").append(spanVal).append("\" width=\"").append(Integer.valueOf(spanVal) * 8).append("%\">");
                                                    String key = footer.get(span);
                                                    if (key != null && key.startsWith("@"))
                                                        df.append(formDef.getPropertyValue(key.substring(1) == null ? "" : key.substring(1)));
                                                    else if (key == null)
                                                        df.append("");
                                                    else {
                                                        String temp = footerMap.get(key) == null ? "0" : CommonUtils.setThousandSeperator(footerMap.get(key).doubleValue());
                                                        df.append(temp);
                                                    }
                                                    df.append("</td>");
                                                }
                                                df.append("</tr>");
                                            }
                                            }
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
                                                headerColumnStyleClass = sortProperty.equals(displayColumnDef.getProperty()) ? sortedStyleClass : sortableStyleClass;

                                        %>

                                <display:column class="<%=columnClass%>" property="<%=displayColumnDef.getProperty()%>" headerClass="<%=headerColumnStyleClass%>" title="<%=href%>" />

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

                    <display:caption>
                    <tr style="background-color: #004a95">
                        <td colspan="<%=((FormSelectDef)formDef).getFormSelectColumnDefs().size()%>" style="color: white; text-align: center;"><%=keyMap != null ? keyMap : ""%></td>
                    </tr>
                    </display:caption>

                    <display:footer>
                        <%=df.toString()%>
                    </display:footer>

                    </display:table>

                    <%
                        }
                        if(!totalFooterMap.isEmpty()) {
                            StringBuffer df = new StringBuffer();
                            if(!formDef.getFooterDefs().isEmpty()) {
                                for (ir.fund.data.form.FooterDef footerDef : formDef.getFooterDefs()) {
                                    df.append("<tr>");
                                    Map<String, String> footer = FormCommonUtil.createFooter(formDef, footerDef, fundType);
                                    for (String span : footer.keySet()) {
                                        String spanString = span.substring(span.indexOf(":") + 1);
                                        Integer spanNumber = Integer.valueOf(spanString);
                                        df.append("<td width=\"").append(spanNumber * colPrecentage).append("%\"").append(" colspan=\"").append(span.substring(span.indexOf(":") + 1)).append("\">");
                                        String key = footer.get(span);
                                        if (key != null && key.startsWith("@"))
                                            df.append(formDef.getPropertyValue("footer.sum.total"));
                                        else if (key == null)
                                            df.append("");
                                        else {
                                            String temp = totalFooterMap.get(key) == null ? "" : CommonUtils.setThousandSeperator(totalFooterMap.get(key).doubleValue());
                                            df.append(temp);
                                        }
                                        df.append("</td>");
                                    }
                                    df.append("</tr>");
                                }
                            }
                    %>
                    <table width="100%" style="background-color:#c58099;">
                        <%=df%>
                    </table>
                    <%
                        }
                    %>

                    <%
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
                                headerColumnStyleClass = sortProperty.equals(displayColumnDef.getProperty()) ? sortedStyleClass : sortableStyleClass;

                        %>

                        <display:column property="<%=displayColumnDef.getProperty()%>" headerClass="<%=headerColumnStyleClass%>" title="<%=href%>" />

                        <%
                        } //#if displayColumnDef.isSortable()
                        else {//#if !displayColumnDef.isSortable()
                        %>

                        <display:column property="<%=displayColumnDef.getProperty()%>" title="<%=displayColumnDef.getTitle()%>" />

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

            <%
                }//#if formDef
            %>

        </td>
    </tr>
</table>
</div>

<script language="javascript">
    <%
    if(request.getSession().getAttribute(formDef.getName().concat("-").concat("activity")) != null) {
    %>
        tabcontent = document.getElementById("list");
        // tabcontent.style.display = "block";
        tabcontent.className += " active";
        tabcontent = document.getElementById("btn-result");
        tabcontent.className += " active";
    <%
    } else {
    %>
        tabcontent = document.getElementById("search");
        // tabcontent.style.display = "block";
        tabcontent.className += " active";
        tabcontent = document.getElementById("btn-search");
        tabcontent.className += " active";
    <%
        }
    %>
</script>

<%--<script language="javascript">--%>
<%--    <%--%>
<%--    if(!formDef.isSeparateTab()) {--%>
<%--    %>--%>
<%--        tabcontent = document.getElementsByClassName("tabcontent");--%>
<%--        for (i = 0; i < tabcontent.length; i++) {--%>
<%--            tabcontent[i].style.display = "block";--%>
<%--            tabcontent[i].className += " active";--%>
<%--        }--%>
<%--    <%--%>
<%--    }--%>
<%--    %>--%>
<%--</script>--%>

</body>
</html>
<%--<html:javascript formName="customerMessageForm" staticJavascript="false" cdata="false"/>--%>
<%--<script type="text/javascript" src="<c:url value="/scripts/validator.jsp"/>"></script>--%>