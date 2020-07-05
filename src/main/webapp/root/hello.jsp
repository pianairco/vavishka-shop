<h1>Hello <%=request.getAttribute("remoteUser")%>!</h1>
<form action="/logout" method="post">
    <input type="submit" value="Sign Out"/>
</form>