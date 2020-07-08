<h1>Hello <%=request.getAttribute("remoteUser")%>!</h1>
<form action="/logout" method="post">

    <h1>${user.name}</h1>
    <h1>${user.username}</h1>
    <h1>${user.getName()}</h1>
    <input type="submit" value="Sign Out"/>
</form>