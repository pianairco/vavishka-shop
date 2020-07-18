<%@ page language="java" contentType="text/html;charset=UTF-8" %>


<nav id="my-topbar" class="navbar is-white topNav">
    <div class="container">
        <div class="navbar-brand">
            <span class="navbar-item">
                <img src="/images/vavishka.png" width="112" height="28">
            </span>
            <div class="navbar-burger burger" data-target="topNav" v-bind:class="{ 'is-active': isActive }" v-on:click="menuClick">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
        <div id="topNav" class="navbar-menu" v-bind:class="{ 'is-active': isActive }">
            <div class="navbar-start">
                <a class="navbar-item" href="/bulma/home">صفحه اصلی</a>
                <a class="navbar-item" href="/bulma/sample-search">آموزش ها</a>
                <a class="navbar-item" href="/bulma/shop">فروشگاه</a>
                <a class="navbar-item" href="/bulma/gallery">گالری تصاویر</a>
            </div>
            <div class="navbar-end">
                <div class="navbar-item">
                    <div class="field is-grouped">
                        <p class="control">
                            <a class="button is-small">
										<span class="icon">
											<i class="fa fa-user-plus"></i>
										</span>
                                <span>
											Register
										</span>
                            </a>
                        </p>
                        <p class="control">
                            <a class="button is-small is-info is-outlined">
										<span class="icon">
											<i class="fa fa-user"></i>
										</span>
                                <span>Login</span>
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</nav>

<script>
    var myTopbar = new Vue({
        el: '#my-topbar',
        data: {
            isActive: false
        },
        methods: {
            menuClick: function () {
                this.isActive = !this.isActive;
            }
        }
    });
</script>
