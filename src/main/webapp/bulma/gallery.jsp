<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/picture-box.jsp" />

<div class="container" id="bulma-gallery-page">
    <div class="columns is-mobile is-multiline">
        <div class="column is-full-mobile is-one-third-desktop">
            <picture-box :images="['/img/480x480.png', '/img/480x480-2.png']"></picture-box>
        </div>
        <div class="column is-full-mobile is-one-third-desktop">
            <picture-box :images="['/img/480x480.png', '/img/480x480-2.png']"></picture-box>
        </div>
        <div class="column is-full-mobile is-one-third-desktop">
            <picture-box :images="['/img/480x480.png', '/img/480x480-2.png']"></picture-box>
        </div>
        <div class="column is-full-mobile is-one-third-desktop">
            <picture-box :images="['/img/480x480.png', '/img/480x480-2.png']"></picture-box>
        </div>
        <div class="column is-full-mobile is-one-third-desktop">
            <picture-box :images="['/img/480x480.png', '/img/480x480-2.png']"></picture-box>
        </div>
        <div class="column is-full-mobile is-one-third-desktop">
            <picture-box :images="['/img/480x480.png', '/img/480x480-2.png']"></picture-box>
        </div>
        <div class="column is-full-mobile is-one-third-desktop">
            <picture-box :images="['/img/480x480.png', '/img/480x480-2.png']"></picture-box>
        </div>
        <div class="column is-full-mobile is-one-third-desktop">
            <picture-box :images="['/img/480x480.png', '/img/480x480-2.png']"></picture-box>
        </div>
    </div>
</div>

<script>
    var app = new Vue({
        el: '#bulma-gallery-page',
        data: function () {
            return {
            }
        },
        methods: {
        },
        components: {
            pictureBox
        },
    });
</script>
