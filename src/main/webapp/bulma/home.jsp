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

<div id="app" class="columns">
    <div class="column is-three-fifths is-offset-one-fifth" >
        <div class="columns">
            <div class="column is-one-quarter" >
                <article class="media">
                    <figure class="media-right">
                        <p class="image is-64x64">
                            <img src="https://bulma.io/images/placeholders/128x128.png">
                        </p>
                    </figure>
                    <div class="media-content">
                        <div class="content">
                            <p>
                                <strong>John Smith</strong> <small>@johnsmith</small> <small>31m</small>
                                <br>
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ornare magna eros, eu pellentesque tortor vestibulum ut. Maecenas non massa sem. Etiam finibus odio quis feugiat facilisis.
                            </p>
                        </div>
                        <nav class="level is-mobile">
                            <div class="level-right">
                                <a class="level-item">
                                    <span class="icon is-small"><i class="fas fa-reply"></i></span>
                                </a>
                                <a class="level-item">
                                    <span class="icon is-small"><i class="fas fa-retweet"></i></span>
                                </a>
                                <a class="level-item">
                                    <span class="icon is-small"><i class="fas fa-heart"></i></span>
                                </a>
                            </div>
                        </nav>
                    </div>
                    <div class="media-left">
                        <span class="icon is-medium has-text-info">
                            <i class="fa fa-2x fa-chevron-left"></i>
                        </span>
                    </div>
                </article>
            </div>
            <div class="column is-three-quarter" >
                <figure class="image ">
                    <iframe width="640" height="360" src="/images/1.jpg" frameborder="0" allowfullscreen></iframe>
                </figure>
            </div>
        </div>
    </div>
</div>

<script>
    var app = new Vue({
        el: '#app',
        data: function () {
            return {
            }
        },
        methods: {
        },
        components: {
        },
    });
</script>