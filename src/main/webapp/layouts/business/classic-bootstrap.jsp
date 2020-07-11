<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><tiles:getAsString name="title" /></title>

        <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="js/bootstrap-4/bootstrap.min.css">
        <link rel="stylesheet" href="js/leaflet/leaflet.css">
        <!--    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>-->
        <script src="https://apis.google.com/js/api:client.js"></script>
        <!--    <script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>-->
        <script src="js/vue/vue.js"></script>
        <script src="js/vue/vue-router.js"></script>
        <script src="js/leaflet/leaflet.js"></script>
        <script src="js/leaflet/vue2-leaflet.min.js"></script>
        <!--    <script src="js/vue-google-signin-button/vue-google-signin-button.min.js"></script>-->
        <script src="js/axios/axios.js"></script>
        <script src="js/bootstrap-4/jquery-3.2.1.slim.min.js"></script>
        <script src="js/bootstrap-4/popper.min.js"></script>
        <script src="js/bootstrap-4/bootstrap.min.js"></script>
        <link type="text/css" rel="stylesheet" href="style/tsidebar.css">
        <link type='text/css' href='js/kamadatepicker/kamadatepicker.min.css' rel='stylesheet' />
        <script language="javascript" src='js/kamadatepicker/kamadatepicker.min.js' type="text/javascript"></script>
    </head>

    <body >
    <table width="100%">
        <tr>
            <td colspan="2">
                <tiles:insertAttribute name="header" />
            </td>
        </tr>
        <tr>
            <td width="20%" nowrap="nowrap">
                <tiles:insertAttribute name="menu" />
            </td>
            <td width="80%">
                <tiles:insertAttribute name="body" />
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <tiles:insertAttribute name="footer" />
            </td>
        </tr>
    </table>
    </body>
</html>