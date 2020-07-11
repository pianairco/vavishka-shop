<%
    String name = "All";
    Object attribute = request.getAttribute("name");
    if(attribute != null)
        name = (String)attribute;
%>

<jsp:include page="../module/image-loader.jsp" />

<div id="app">
    <div>
        <a href="/hello" >hello</a>
    </div>

    <image-loader :url="'/images/image-upload'" :action="'imageUploader'" :activity="'saveHeaderImage'"></image-loader>
<%--    <image-loader :restUrl="/images/image-upload" :action="imageUploader" :activity="saveHeaderImage"></image-loader>--%>
<%--    <image-loader :restUrl="/images/image-upload" :action="imageUploader" :activity="saveHeaderImage"></image-loader>--%>

    <div class="text-center">
        <h2>Hi <%=name%></h2>
        <hr>
    </div>


    <div class="text-center">
        <h3>${namy}</h3>
        <hr>
        <h1>This is Home Page</h1>
    </div>
</div>

<script>
    var app = new Vue({
       el: '#app',
       components: {
           imageLoader
       },
    });
</script>
