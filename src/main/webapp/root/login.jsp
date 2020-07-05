<style type="text/css">
    .log-in-form {
        border: 1px solid #cacaca;
        padding: 1rem;
        border-radius: 0;
    }
</style>
<form action="/login" method="post" class="log-in-form">
    <h4 class="text-center">Log in with you email account</h4>
    <label>Email
        <input type="text" name="username" placeholder="somebody@example.com">
    </label>
    <label>Password
        <input type="password" name="password" placeholder="Password">
    </label>
    <input id="show-password" type="checkbox"><label for="show-password">Show password</label>
    <p><input type="submit" class="button expanded" value="Log in"></input></p>
    <p class="text-center"><a href="#">Forgot your password?</a></p>
</form>