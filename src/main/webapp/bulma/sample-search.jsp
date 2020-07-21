<%@ page import="ir.piana.dev.strutser.util.JspUtil" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/pictorial-sample-item.jsp" />
<jsp:include page="/module/bulma/pictorial-sample-item-creator.jsp" />

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
                <pictorial-sample-item-creator v-on:add-item="addItem" :form-name="'uploader1'" :property-name="'image'"></pictorial-sample-item-creator>
            </div>
        <%
            }
        %>
        <div v-for="d in samples" class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-sample-item :link="'/bulma/sample'" :image="d['IMAGESRC']"
                                   :description="d['DESCRIPTION']"
                                   :title="d['TITLE']"></pictorial-sample-item>
        </div>
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-sample-item :link="'/bulma/sample'" :images="images.slice(0, 1)"
                                   :description="'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nec iaculis mauris.'"
                                   :title="'hello'"></pictorial-sample-item>
        </div>
    </div>
</div>

<script>
    <%=JspUtil.getStore("store")%>

    var app = new Vue({
        el: '#bulma-sample-search-page',
        data: function () {
            return {
                formName: 'uploader1',
                propertyName: 'propertyName1',
                addImage: [
                    '/img/add-document.png'
                ],
                images: [
                    '/img/480x480.png', '/img/480x480-2.png'
                ],
                samples: ${sample},
                sharedState: store.state
            }
        },
        methods: {
            addItem(form) {
                console.log(JSON.stringify(form));
                axios.post('/sample/add', form, { headers: { 'file-group': 'sample' } })
                    .then((response) => {
                        console.log(response.data);
                        this.samples.push(response.data);
                    })
                    .catch((err) => { this.message = err; });
            }
        },
        components: {
            pictorialSampleItem,
            pictorialSampleItemCreator
        },
    });
</script>
