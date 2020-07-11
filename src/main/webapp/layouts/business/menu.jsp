<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<div class="top-bar">
        <div class="top-bar-left">
                <ul class="dropdown menu" data-dropdown-menu>
                        <li class="menu-text">واویشکا</li>
                        <li class="has-submenu">
                                <a href="#">One</a>
                                <ul class="submenu menu vertical" data-submenu>
                                        <li><a href="#">One</a></li>
                                        <li><a href="#">Two</a></li>
                                        <li><a href="#">Three</a></li>
                                </ul>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/home.do">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/contactus.do">Contact Us</a></li>
                </ul>
        </div>
        <div class="top-bar-right">
                <ul class="menu">
                        <li><input type="search" placeholder="Search"></li>
                        <li><button type="button" class="button">Search</button></li>
                </ul>
        </div>
</div>