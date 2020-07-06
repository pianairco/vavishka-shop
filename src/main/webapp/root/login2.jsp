<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
<meta name="google-signin-client_id" content="290205995528-o268sq4cttuds0f44jnre5sb6rudfsb5.apps.googleusercontent.com">
<%--<meta name="google-signin-client_id" content="AIzaSyCJLxnzeCwrk_qKbIua-Okoydh4kIf_vGE.apps.googleusercontent.com">--%>

<style type="text/css">
    .log-in-form {
        border: 1px solid #cacaca;
        padding: 1rem;
        border-radius: 0;
    }
</style>

<script>
    function onsubmit() {
        axios.post('/login', {"id": id_token,"username": profile.getEmail(), "password": "1234" }, {headers: {}})
            .then((response) => {
                console.log(response.headers.Authorization);
            })
            .catch((err) => { console.log(err); });
    }

    function init() {
        gapi.load('auth2', function() {
            /* Ready. Make a call to gapi.auth2.init or some other API */
        });
    }

    function onSignIn(googleUser) {
        var id_token = googleUser.getAuthResponse().id_token;

        var profile = googleUser.getBasicProfile();
        console.log('googleUser.AuthResponse: ' + JSON.stringify(googleUser.getAuthResponse())); // Do not send to your backend! Use an ID token instead.
        console.log('id_token: ' + id_token); // Do not send to your backend! Use an ID token instead.
        console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
        console.log('Name: ' + profile.getName());
        console.log('Image URL: ' + profile.getImageUrl());
        console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.

        axios.post('/vavishka-shop/login', {"id": id_token,"username": profile.getEmail(), "password": "1234" }, {headers: {}})
            .then((response) => {
                console.log(response.headers.Authorization);
            })
            .catch((err) => { console.log(err); });
    }

    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
            console.log('User signed out.');
        });
    }

</script>

<form class="log-in-form">
    <h4 class="text-center">Log in with you email account</h4>
    <label>Email
        <input type="text" name="username" placeholder="somebody@example.com">
    </label>
    <label>Password
        <input type="password" name="password" placeholder="Password">
    </label>
    <input id="show-password" type="checkbox"><label for="show-password">Show password</label>
    <p><input type="button" onclick="onSubmit" class="button expanded" value="Log in"></input></p>
    <p><input type="button" data-onsuccess="onSignIn" class="g-signin2 button expanded" value="ورود با حساب گوگل"></input></p>
    <a href="#" onclick="signOut();">Sign out</a>
    <p class="text-center"><a href="#">Forgot your password?</a></p>
</form>
