<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<script src="js/vue/vue.js"></script>

<div id="app">
    <form action="/login" method="post">
    <h4 class="text-center">Log in with you email account</h4>
    <label>Email
        <input type="text" name="username" v-model="user.username" placeholder="somebody@example.com">
    </label>
    <label>Password
        <input v-if="!showPassword" name="password" type="password" v-model="user.password" placeholder="Username">
        <input v-if="showPassword" name="password" type="text" v-model="user.password" placeholder="Password">
    </label>
    <input v-model="showPassword" type="checkbox" id="show-password"><label for="show-password">Show password</label>
    <p><input type="submit" class="button expanded" value="Log in"></input></p>
<%--    <p><input type="button" v-on:click="onsubmit" class="button expanded" value="Log in"></input></p>--%>
    <p class="text-center"><a href="#">Forgot your password?</a></p>
    </form>
</div>

<script>
    var app = new Vue({
        el: '#app',
        data: {
            showPassword: false,
            user: {
                username: '',
                password: ''
            }
        },
        methods: {
            onsubmit: function() {
                console.log("32423")
                axios.post('/login', this.user, {headers: {}})
                    .then((response) => {
                        console.log(response.headers.Authorization);
                    }).catch((err) => {
                    console.log(err);
                });
            }
        }
    });
</script>
