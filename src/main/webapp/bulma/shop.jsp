<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/pictorial-shop-item.jsp" />

<div class="container" id="bulma-shop-page">
    <div class="columns is-mobile is-multiline">
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-shop-item :images="['/img/480x480.png', '/img/480x480-2.png']"
                                 :title="'کالا'"
                                 :description="'خرید از فروشنده محصولات سالم و بهداشتی'">
            </pictorial-shop-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-shop-item :images="['/img/480x480.png', '/img/480x480-2.png']"
                                 :title="'کالا'"></pictorial-shop-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-shop-item :images="['/img/480x480.png', '/img/480x480-2.png']"
                                 :title="'کالا'"></pictorial-shop-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-shop-item :images="['/img/480x480.png']"
                                 :title="'کالا'"></pictorial-shop-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-shop-item :images="['/img/480x480.png', '/img/480x480-2.png']"
                                 :title="'کالا'"></pictorial-shop-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-shop-item :images="['/img/480x480.png', '/img/480x480-2.png']"
                                 :title="'کالا'"></pictorial-shop-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-shop-item :images="['/img/480x480.png', '/img/480x480-2.png']"
                                 :title="'کالا'"></pictorial-shop-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-shop-item :images="['/img/480x480.png', '/img/480x480-2.png']"
                                 :title="'کالا'"></pictorial-shop-item>
        </div>
    </div>
</div>

<script>
    var app = new Vue({
        el: '#bulma-shop-page',
        data: function () {
            return {
            }
        },
        methods: {
        },
        components: {
            pictorialShopItem
        },
    });
</script>
