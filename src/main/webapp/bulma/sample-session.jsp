<%@ page import="ir.piana.dev.strutser.util.JspUtil" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/pictorial-menu-item.jsp" />
<jsp:include page="/module/bulma/pictorial-menu-item-creator.jsp" />
<jsp:include page="/module/sample-session/sample-session-picture-manager.jsp" />
<jsp:include page="/module/bulma/spinner.jsp" />

<div class="container" id="bulma-sample-page">
    <spinner></spinner>
    <div class="columns is-mobile is-multiline">
        <div class="column is-full-mobile is-one-quarter-desktop">
            <pictorial-menu-item-creator v-on:add-item="addItem" :form-name="'uploader1'" :icon-property-name="'icon'">
            </pictorial-menu-item-creator>
            <aside class="menu">
                <ul class="menu-list" <%--style=" overflow-y: auto; display: flex; flex-direction: column; max-height: 800px;"--%>>
                    <li v-for="session in sessions">
                        <pictorial-menu-item
                                v-on:session-selected="sessionSelected"
                                v-if="session['id'] != editedId"
                                :active-id="activeId"
                                :id="session['id']"
                                :image="session['iconSrc']"
                                :description="session['description']"
                                :title="session['title']"></pictorial-menu-item>
                    </li>
                </ul>
            </aside>
        </div>
        <div class="column is-full-mobile is-three-quarters-desktop">
            <sample-session-picture-manager
                    v-on:delete-session-image="deleteSessionImage"
                    v-on:replace-session-image="replaceSessionImage"
                    v-on:add-session-image="addSessionImage"
                    v-on:select-session-image="selectSessionImage"
                    v-if="activeId"></sample-session-picture-manager>
        </div>
    </div>
</div>

<script>
    <%=JspUtil.getStore("store", "session", "uploader1")%>

    var app = new Vue({
        el: '#bulma-sample-page',
        data: function () {
            return {
                sample: ${sample},
                sessionMap: ${sessionsMap},
                sessionImageMap: {},
                sessions: ${sessions},
                editedId: 0,
                activeId: 0,
                imageUploadGroup: 'insert-sample-session-image',
                imageUploadUrl: '/images/image-upload',
            }
        },
        methods: {
            addItem: function (form) {
                console.log(JSON.stringify(form))
                form['samples_id'] = this.sample.id;
                form['orders'] = this.sessions.length + 1;
                axios.post('/sample/session/add', form, { headers: { 'file-group': 'sample-session' } })
                    .then((response) => {
                        console.log(response.data);
                        this.sessions.push(response.data);
                    })
                    .catch((err) => { this.message = err; });
            },
            sessionSelected: function (id) {
                console.log("session selected!", id);
                this.activeId = id;
                axios.post('/sample/session/images', { "id": this.activeId }, { headers: { 'file-group': 'sample-session' } })
                    .then((response) => {
                    console.log(response.data);
                    console.log(store.getFromForm('session', 'images'))
                    // if(!store.getFromForm('session', 'images'))
                        store.setToForm('session', 'images', response.data);
                    console.log(store.getFromForm('session', 'images'))
                    store.setToForm('session', 'activeId', 0);
                    // let obj = Object.assign({}, this.sharedState.forms['sessoin']);
                    // obj['images'] = response.data;
                    // this.sharedState.forms['session'] = obj;
                    //store.setToForm("sessoin", "images", response.data);
                    this.sessionImageMap = response.data;
                })
                .catch((err) => { console.log(err); });
            },
            selectSessionImage: function (id) {
                console.log(id)
                store.setToForm('session', 'activeId', id);
            },
            addSessionImage: function (image, rotate) {
                console.log("add new session image:", image, rotate);
                store.setToForm('waiter', 'wait', 1)
                let formData = new FormData();
                formData.append('file', image);
                let headers = {
                    'image_upload_group': this.imageUploadGroup,
                    'image-upload-rotation': rotate,
                    'sessionId': 'i:' + this.activeId,
                    'orders': 'i:' + (Object.keys(this.sessionImageMap).length + 1),
                    'Content-Type': 'multipart/form-data'
                };

                axios.post(this.imageUploadUrl, formData, {
                    headers: headers
                }).then((res) => {
                    store.setToFormProperty('session', 'images', res['data']['id'], res['data']);
                    store.setToForm('waiter', 'wait', 0)
                }).catch((e) => {
                    console.log('FAILURE!!');
                    console.log(e);
                    store.setToForm('waiter', 'wait', 0)
                });
            },
            replaceSessionImage: function (image, imageId) {
                console.log("replace new session image:", image, imageId);
                let formData = new FormData();
                formData.append('file', image);
                let headers = {
                    'image_upload_group': 'replace-sample-session-image',
                    'id': imageId,
                    'Content-Type': 'multipart/form-data'
                };

                axios.post(this.imageUploadUrl, formData, {
                    headers: headers
                }).then((res) => {
                    store.replaceToFormProperty('session', 'images', res['data']['id'], 'imageSrc', res['data']['imageSrc']);
                }).catch((e) => {
                    console.log('FAILURE!!');
                    console.log(e);
                });
            },
            deleteSessionImage: function (imageId) {
                console.log("delete new session image:", imageId);
                let headers = {
                    'business': 'delete-session-image',
                    'Content-Type': 'application/json'
                };

                axios.post('/sample/session/image/delete', {'id': imageId }, {
                    headers: headers
                }).then((res) => {
                    store.removeFromFormProperty('session', 'images', res['data']['id']);
                    store.setToForm('session', 'activeId', 0);
                }).catch((e) => {
                    console.log('FAILURE!!');
                    console.log(e);
                });
            }
        },
        mounted: function () {
            // console.log(Object.keys(this.sessionImages).length);
            // console.log(this.sessionImages);
            // console.log(this.sessionMap);
        },
        components: {
            spinner,
            pictorialMenuItem,
            pictorialMenuItemCreator,
            sampleSessionPictureManager
        },
    });
</script>
