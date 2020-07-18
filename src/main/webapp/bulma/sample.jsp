<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/pictorial-menu-item.jsp" />

<div class="container" id="bulma-sample-page">
    <div class="columns is-mobile is-multiline">
        <div class="column is-full-mobile is-one-quarter-desktop">
            <a class="button is-primary is-block is-alt is-large" href="#">New Post</a>
            <aside class="menu">
                <ul class="menu-list" <%--style=" overflow-y: auto; display: flex; flex-direction: column; max-height: 800px;"--%>>
                    <li><pictorial-menu-item></pictorial-menu-item></li>
                    <li><pictorial-menu-item></pictorial-menu-item></li>
                    <li><pictorial-menu-item></pictorial-menu-item></li>
                    <li><pictorial-menu-item></pictorial-menu-item></li>
                    <li><pictorial-menu-item></pictorial-menu-item></li>
                    <li><pictorial-menu-item></pictorial-menu-item></li>
                    <li><pictorial-menu-item></pictorial-menu-item></li>
                    <li><pictorial-menu-item></pictorial-menu-item></li>
                    <li><pictorial-menu-item></pictorial-menu-item></li>
                </ul>
            </aside>
        </div>
        <div class="column is-full-mobile is-three-quarters-desktop">
            <div class="card">
                <div class="card-image">
                    <figure class="image is-4by3">
                        <img src="https://bulma.io/images/placeholders/1280x960.png" alt="Placeholder image">
                    </figure>
                </div>
                <div class="card-content">
                    <div class="media">
                        <div class="media-left">
                            <figure class="image is-48x48">
                                <img src="https://bulma.io/images/placeholders/96x96.png" alt="Placeholder image">
                            </figure>
                        </div>
                        <div class="media-content">
                            <p class="title is-4">John Smith</p>
                            <p class="subtitle is-6">@johnsmith</p>
                        </div>
                    </div>

                    <div class="content">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                        Phasellus nec iaculis mauris. <a>@bulmaio</a>.
                        <a href="#">#css</a> <a href="#">#responsive</a>
                        <br>
                        <time datetime="2016-1-1">11:09 PM - 1 Jan 2016</time>
                    </div>
                </div>
                <footer class="card-footer">
                    <p class="card-footer-item">
                            <span>
                                <a href="#">Next SLIDE</a>
                            </span>
                    </p>
                    <p class="card-footer-item">
                            <span>
                                <a href="#">PREV SLIDE</a>
                            </span>
                    </p>
                </footer>
            </div>
        </div>
    </div>
</div>

<script>
    var app = new Vue({
        el: '#bulma-sample-page',
        data: function () {
            return {
            }
        },
        methods: {
        },
        components: {
            pictorialMenuItem
        },
    });
</script>
