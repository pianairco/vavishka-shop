<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/pictorial-sample-item.jsp" />

<%
    Boolean isAdmin = request.getAttribute("isAdmin") != null && request.getAttribute("isAdmin") instanceof Boolean ?
            (Boolean)request.getAttribute("isAdmin") : true;
%>

<div class="container" id="bulma-sample-search-page">
    <div class="columns is-mobile is-multiline">
        <%
            if(isAdmin) {
        %>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <div class="card">
                <picture-box></picture-box>
                <div class="card-content">
                    <div class="media" style="padding-top: 15px;">
                        <div class="media-content">
                            <div class="field">
                                <div class="control">
                                    <input class="input is-primary" type="text" placeholder="عنوان">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="content">
                        <textarea class="textarea" placeholder="توضیحات" rows="2"></textarea>
                    </div>
                </div>
                <footer class="card-footer">
                    <a class="card-footer-item button is-white" v-bind:href="link">
                        افزودن
                    </a>
                </footer>
            </div>
        </div>
        <%
            }
        %>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-sample-item :link="'/bulma/sample'" :images="images.slice(0, 1)"
                                   :description="'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.'"
                                   :title="'hello'"></pictorial-sample-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-sample-item :link="'/bulma/sample'" :images="images.slice(0, 1)"
                                   :description="'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.'"
                                   :title="'hello'"></pictorial-sample-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-sample-item :link="'/bulma/sample'" :images="images.slice(0, 1)"
                                   :description="'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.'"
                                   :title="'hello'"></pictorial-sample-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-sample-item :link="'/bulma/sample'" :images="images.slice(0, 1)"
                                   :description="'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.'"
                                   :title="'hello'"></pictorial-sample-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-sample-item :link="'/bulma/sample'" :images="images.slice(0, 1)"
                                   :description="'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.'"
                                   :title="'hello'"></pictorial-sample-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-sample-item :link="'/bulma/sample'" :images="images.slice(0, 1)"
                                   :description="'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.'"
                                   :title="'hello'"></pictorial-sample-item>
        </div>
    </div>
</div>

<script>
    var app = new Vue({
        el: '#bulma-sample-search-page',
        data: function () {
            return {
                addImage: [
                    '/img/add-document.png'
                ],
                images: [
                    '/img/480x480.png', '/img/480x480-2.png'
                ]
            }
        },
        methods: {
        },
        components: {
            pictorialSampleItem
        },
    });
</script>
