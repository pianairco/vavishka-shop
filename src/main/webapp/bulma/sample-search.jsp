<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/pictorial-item.jsp" />

<div class="container" id="bulma-sample-search-page">
    <div class="columns is-mobile is-multiline">
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-item></pictorial-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-item></pictorial-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-item></pictorial-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-item></pictorial-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-item></pictorial-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-item></pictorial-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-item></pictorial-item>
        </div>
    </div>
</div>

<script>
    var app = new Vue({
        el: '#bulma-sample-search-page',
        data: function () {
            return {
            }
        },
        methods: {
        },
        components: {
            pictorialItem
        },
    });
</script>
