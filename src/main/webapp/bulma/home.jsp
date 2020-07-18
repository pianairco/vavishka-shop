<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/pictorial-menu-item.jsp" />

<section class="section" id="bulma-home-page">
    <div class="container has-text-centered">
        <h2 class="title">The Band</h2>
        <p>We have created a fictional band website. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
            aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est
            laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>

        <div class="columns is-centered" style="padding: 2rem">
            <div class="column">
                <div class="card">
                    <div class="card-image">
                        <figure class="image is-2by1">
                            <img src="/img/lake.jpg" alt="Placeholder image">
                        </figure>
                    </div>
                    <div class="card-content">
                        <div class="media">
                            <div class="media-content">
                                <p class="title is-4">John Smith</p>
                                <p class="subtitle is-6">@johnsmith</p>
                            </div>
                        </div>

                        <div class="content">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.
                            <a>@bulmaio</a>.
                            <a href="#">#css</a>
                            <a href="#">#responsive</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="column">
                <div class="card">
                    <div class="card-image">
                        <figure class="image is-2by1">
                            <img src="/img/halong.jpg" alt="Placeholder image">
                        </figure>
                    </div>
                    <div class="card-content">
                        <div class="media">
                            <div class="media-content">
                                <p class="title is-4">John Smith</p>
                                <p class="subtitle is-6">@johnsmith</p>
                            </div>
                        </div>

                        <div class="content">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.
                            <a>@bulmaio</a>.
                            <a href="#">#css</a>
                            <a href="#">#responsive</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="column">
                <div class="card">
                    <div class="card-image">
                        <figure class="image is-2by1">
                            <img src="/img/forest.jpg" alt="Placeholder image">
                        </figure>
                    </div>
                    <div class="card-content">
                        <div class="media">
                            <div class="media-content">
                                <p class="title is-4">John Smith</p>
                                <p class="subtitle is-6">@johnsmith</p>
                            </div>
                        </div>

                        <div class="content">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.
                            <a>@bulmaio</a>.
                            <a href="#">#css</a>
                            <a href="#">#responsive</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</section>

<script>
    var app = new Vue({
        el: '#bulma-home-page',
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
