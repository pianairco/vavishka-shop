<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<html class="no-js" lang="fa" dir="rtl">
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><tiles:getAsString name="title" /></title>

<%--        <script src="https://apis.google.com/js/api:client.js"></script>--%>
        <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
        <link href="js/foundation-6.6.3/css/foundation.min.css" rel="stylesheet">
<%--        <script src="js/vue/vue.js"></script>--%>
<%--        <script src="js/vue/vue-router.js"></script>--%>
        <script src="js/axios/axios.js"></script>
    </head>

    <body >
    <tiles:insertAttribute name="header" />
    <tiles:insertAttribute name="menu" />
    <tiles:insertAttribute name="body" />
    <tiles:insertAttribute name="footer" />

    <script src="js/foundation-6.6.3/js/vendor/jquery.js"></script>
    <script src="js/foundation-6.6.3/js/vendor/foundation.min.js"></script>
    <script>
        $(document).foundation();
    </script>
    </body>
</html>
