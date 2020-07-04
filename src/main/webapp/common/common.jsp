<%@ page import="org.apache.struts.util.MessageResources"%>
<%@ page import="ir.piana.dev.strutser.dynamic.form.FormPersistDef" %>
<%@ page import="ir.piana.dev.strutser.dynamic.form.FormSelectDef" %>
<%@ include file="/taglibs.jsp"%>

<html dir="rtl">
<head>
</head>
<body >

<script>
    var searchBoxName = '';
    function setSearchBoxName(name) {
        searchBoxName = name;
    }

    function setValueToInputByName(value , elementName) {
    }

    function setValueToInput(value , el) {
        $(el).value = value;
    }

    function setDetailLedgerId(value) {
    }

    function setDetailLedgerName(value) {
    }

    function setDetailLedgerNumber(value) {
        document.getElementsByName(searchBoxName)[0].value = value;
        $("input[name='" + searchBoxName + "']").trigger("blur");
    }

    function setSlId(value) {
    }

    function setSlNumber(value) {
        document.getElementsByName(searchBoxName)[0].value = value;
        $("input[name='" + searchBoxName + "']").trigger("blur");
    }

    function setSlName (value) {

    }

    function setGlId(value) {
        // document.getElementsByName(searchBoxName)[0].value = value;
    }
    function setGlNumber(value) {
        document.getElementsByName(searchBoxName)[0].value = value;
        $("input[name='" + searchBoxName + "']").trigger("blur");
    }

    function setGlName (value) {

    }

    function setDlId(value) {
        // document.getElementsByName(searchBoxName)[0].value = value;
    }

    function setDlNumber(value) {
        document.getElementsByName(searchBoxName)[0].value = value;
    }

    function setDlName (value) {
    }
</script>
<%
    String MESSGAE_KEY = "org.apache.struts.action.MESSAGE";
    String title = "";
    String fundType = (String)request.getAttribute("fund-type");
%>

<table bgcolor="#bbbbbb" border="0" cellpadding="1" cellspacing="0" width="100%">
<tr>
    <td>
        <%
            if(request.getAttribute("form-def") instanceof FormPersistDef) {
        %>

        <jsp:include page="common-edit.jsp" flush="true"/>
        <%--<%@include file="common-edit.jsp" %>--%>

        <%
            } else if(request.getAttribute("form-def") instanceof FormSelectDef) {
        %>

        <jsp:include page="common-list.jsp" flush="true"/>

        <%--<%@include file="common-list.jsp" %>--%>

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