<%@ page import="ir.piana.dev.strutser.util.JspUtil" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/pictorial-menu-item.jsp" />
<jsp:include page="/module/bulma/pictorial-menu-item-creator.jsp" />
<jsp:include page="/module/sample-session/sample-session-picture-manager.jsp" />

<div class="container" id="bulma-sample-page">
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
        <div v-if="sharedState['forms']['session']">
            <h1  v-for="sessionImage in sharedState['forms']['session']['images']">{{sessionImage['imageSrc']}}</h1>
        </div>
        <div class="column is-full-mobile is-three-quarters-desktop">
            <sample-session-picture-manager :session-images="sessionImages"
                    v-on:select-image="addSessionImage"
                    v-if="activeId"></sample-session-picture-manager>
        </div>
    </div>
</div>

<script>
    <%=JspUtil.getStore("store")%>

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
                imageUploadGroup: 'sample-session-image',
                imageUploadUrl: '/images/image-upload',
                sessionImages: {
                },
                sharedState: store.state,
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
                        this.sessionImageMap = response.data;
                    })
                    .catch((err) => { this.message = err; });
            },
            sessionSelected: function (id) {
                console.log("session selected!", id);
                this.activeId = id;
                axios.post('/sample/session/images', { "id": this.activeId }, { headers: { 'file-group': 'sample-session' } })
                    .then((response) => {
                    console.log(response.data);
                let obj = Object.assign({}, this.sharedState.forms['sessoin']);
                console.log(JSON.stringify(obj));
                obj['images'] = response.data;
                console.log(JSON.stringify(obj));
                this.sharedState.forms['session'] = obj;
                    //store.setToForms("sessoin", "images", response.data);
                    console.log("xx", JSON.stringify(this.sharedState))
                    this.sessionImageMap = response.data;
            })
            .catch((err) => { console.log(err); });
            },
            addSessionImage: function (image) {
                console.log("add new session image:", image);
                let formData = new FormData();
                formData.append('file', image);
                let headers = {
                    'image_upload_group': this.imageUploadGroup,
                    'sessionId': 'i:' + this.activeId,
                    'orders': 'i:' + (Object.keys(this.sessionImageMap).length + 1),
                    'Content-Type': 'multipart/form-data'
                };

                console.log(JSON.stringify(headers));
                console.log(this.imageUploadUrl);

                axios.post(this.imageUploadUrl, formData, {
                    headers: headers
                }).then((res) => {
                    console.log('SUCCESS!!');
                    console.log(res);
                    console.log(res['data']['data']['path']);
                    console.log(this.order);
                    console.log("add-session-image", res['data']['data']['path']);
                    // self.state.isSend = true;
                    // self.state.isSpin = false;
                }).catch(() => {
                    console.log('FAILURE!!');
                // self.state.isSpin = false;
                });

                // this.sessionImages[order + ''] = path;
                // console.log(this.sessionImages);
                // if(Object.keys(this.sessionImages).length > 0) {
                //     console.log('own')
                // } else {
                //     console.log('no own')
                // }
            }
        },
        mounted: function () {
            console.log(Object.keys(this.sessionImages).length);
            console.log(this.sessionImages);
            console.log(this.sessionMap);
        },
        components: {
            pictorialMenuItem,
            pictorialMenuItemCreator,
            sampleSessionPictureManager
        },
    });
</script>
