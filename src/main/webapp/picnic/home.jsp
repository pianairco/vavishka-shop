<%--
  Created by IntelliJ IDEA.
  User: tentwo
  Date: 7/8/2020
  Time: 9:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="/js/vue/vue.js"></script>

<script >
    var imageLoader = Vue.component('image-loader', {
        template: `

    <div class="grid-x" style="background-color: #9fcdff">&nbsp;
    </div>`,
        props: {
        },
        data: function() {
            return {
                message: '',
            }
        },
        components: {
            spinner
        },
        methods: {
        }
    });
</script>
