<%
    String name = "All";
    Object attribute = request.getAttribute("name");
    if(attribute != null)
        name = (String)attribute;
%>

<div class="text-center">
    <h2>Hi <%=name%></h2>
    <hr>
</div>


<div class="text-center">
    <h3>${namy}</h3>
    <hr>
    <h1>This is Home Page</h1>
</div>
