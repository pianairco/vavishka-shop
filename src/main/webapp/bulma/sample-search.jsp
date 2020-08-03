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
                <pictorial-sample-item-creator v-on:add-item="addItem" :form-name="'uploader1'" :property-name="'image'">
                </pictorial-sample-item-creator>
            </div>
        <%
            }
        %>
        <div v-for="d in samples" class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-sample-item v-if="d['id'] != editedId"
                                   :link="'/bulma/sample?id=' + d['id']"
                                   v-on:edit-item="editItemClick"
                                   v-on:delete-item="deleteItemClick"
                                   :id="d['id']"
                                   :image="d['imageSrc']"
                                   :description="d['description']"
                                   :title="d['title']"></pictorial-sample-item>
            <pictorial-sample-item-creator v-if="d['id'] == editedId"
                                           v-on:add-item="addItem"
                                           v-on:edit-item="editItem"
                                           :edited-item="d"
                                           :form-name="'uploader1'"
                                           :property-name="'image'">
            </pictorial-sample-item-creator>
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
                sharedState: store.state,
                editedId: 0
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
            },
            editItem(form) {
                console.log(JSON.stringify(form));
                axios.post('/sample/edit', form, { headers: { 'file-group': 'sample' } })
                    .then((response) => {
                        console.log(response.data);
                        let index = this.samples.findIndex(item => item.id === response.data.id);
                console.log(index);
                        this.samples.splice(index, 1, response.data);
                        this.editedId = 0;
                })
                .catch((err) => { this.message = err; });
            },
            editItemClick(id) {
                console.log(id);
                this.editedId = id;
            },
            deleteItemClick(id) {
                console.log(id);
                axios.post('/sample/delete', { "id": id }, { headers: { 'file-group': 'sample' } })
                    .then((response) => {
                        console.log(response.data);
                        let index = this.samples.findIndex(item => item.id === id);
                        console.log(index);
                        console.log(this.samples);
                        this.samples.splice(index, 1);
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
