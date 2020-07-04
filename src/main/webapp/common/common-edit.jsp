<%@ page import="ir.piana.dev.strutser.dynamic.form.ElementControl"%>
<%@ page import="ir.piana.dev.strutser.dynamic.form.FormManager"%>
<%@ page import="ir.piana.dev.strutser.dynamic.form.FormPersistDef"%>
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
    FormPersistDef formDef = (FormPersistDef) request.getAttribute("form-def");
    FormManager formManager = (FormManager) request.getAttribute("form-manager");
    String title = "";
    String[] split = formDef.getName().split("@");
    String formActionUrl = split[0] + "?method=" + split[1] + "&persist=true";
%>

<script language="javascript">
    function resetSearchPanel()
    {
        <%
        for(ElementControl SQLParamDef : formDef.getControls()) {
            String d = "document.forms[0].elements['" + SQLParamDef.getName() + "'].value = '';";
        %>
        <%=d%>
        <%
        }
        %>
    }
</script>

<table width="100%" class="content" border="0" style="border-collapse:collapse">
    <tr class="VNformheader">
        <td width="20%">
            <%
                if(formDef.getTitle() != null) {
                    String pageTitle = formDef.getTitle();
            %>
            <h4 ><%=pageTitle%></h4>
            <%
                }
            %>
        </td>
        <td width="80%" align=left >
            <%--<button type="button" name="newBranch" onclick="location =<%=formSelectDef.getActionURL().concat("?method=executeCommonInsert-edit")%>"><bean:message key="branch.newBranch"/></button>&nbsp;&nbsp;--%>
        </td>
    </tr>
    <tr>
        <td colspan="2" style="background-color: #fffff0;">&nbsp;</td>
    </tr>
</table>

<jsp:include page="common-controls.jsp">
    <jsp:param name="forList" value="false"/>
</jsp:include>

</body>
</html>
