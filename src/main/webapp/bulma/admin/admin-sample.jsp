<%@ page import="ir.piana.dev.strutser.util.JspUtil" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/picture-box.jsp" />
<jsp:include page="/module/bulma/pictorial-menu-item.jsp" />
<jsp:include page="/module/bulma/pictorial-menu-item-creator.jsp" />
<jsp:include page="/module/bulma/column-picture-upload.jsp" />

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
        <div v-if="activeId" class="column is-full-mobile is-three-quarters-desktop">
            <div class="card">
                <div class="card-image">
                    <figure class="image is-4by3">
                        <img v-if="Object.keys(sessionMap).length == 0" src="https://bulma.io/images/placeholders/1280x960.png" alt="Placeholder image">
                        <img v-if="Object.keys(sessionMap).length > 0" :src="sessionMap['2']['imageSrc1']" alt="Placeholder image">
                    </figure>
                </div>
                <div class="card-content">
                    <div class="columns is-mobile is-multiline" style="margin: 0px;">
                        <column-picture-upload v-on:add-session-image="addSessionImage"
                                               :url="'/images/image-upload'"
                                               :image-upload-group="'sample-session'"
                                               :order="'1'"
                                               :session-id="activeId"></column-picture-upload>
                        <column-picture-upload :url="'/images/image-upload'"
                                               v-on:add-session-image="addSessionImage"
                                               :image-upload-group="'sample-session'"
                                               :order="'1'"
                                               :session-id="activeId"></column-picture-upload>
                        <column-picture-upload :url="'/images/image-upload'"
                                               v-on:add-session-image="addSessionImage"
                                               :image-upload-group="'sample-session'"
                                               :order="'1'"
                                               :session-id="activeId"></column-picture-upload>
                        <column-picture-upload :url="'/images/image-upload'"
                                               v-on:add-session-image="addSessionImage"
                                               :image-upload-group="'sample-session'"
                                               :order="'1'"
                                               :session-id="activeId"></column-picture-upload>
                        <column-picture-upload :url="'/images/image-upload'"
                                               v-on:add-session-image="addSessionImage"
                                               :image-upload-group="'sample-session'"
                                               :order="'1'"
                                               :session-id="activeId"></column-picture-upload>
                        <column-picture-upload :url="'/images/image-upload'"
                                               v-on:add-session-image="addSessionImage"
                                               :image-upload-group="'sample-session'"
                                               :order="'1'"
                                               :session-id="activeId"></column-picture-upload>
                        <column-picture-upload :url="'/images/image-upload'"
                                               v-on:add-session-image="addSessionImage"
                                               :image-upload-group="'sample-session'"
                                               :order="'1'"
                                               :session-id="activeId"></column-picture-upload>
                        <column-picture-upload :url="'/images/image-upload'"
                                               v-on:add-session-image="addSessionImage"
                                               :image-upload-group="'sample-session'"
                                               :order="'1'"
                                               :session-id="activeId"></column-picture-upload>
                    </div>

                    <div class="content">
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                        Phasellus nec iaculis mauris. <a>@bulmaio</a>.
                        <a href="#">#css</a> <a href="#">#responsive</a>
                        <br>
                        <time datetime="2016-1-1">11:09 PM - 1 Jan 2016</time>
                    </div>
                </div>
                <footer class="card-footer">
                    <p class="card-footer-item">
                            <span>
                                <a href="#">Next SLIDE</a>
                            </span>
                    </p>
                    <p class="card-footer-item">
                            <span>
                                <a href="#">PREV SLIDE</a>
                            </span>
                    </p>
                </footer>
            </div>
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
                sessions: ${sessions},
                editedId: 0,
                activeId: 0,
                sessionImages: {
                }
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
            },
            addSessionImage: function (path, order) {
                console.log("add new session image", path, order);
                this.sessionImages[order + ''] = path;
                console.log(this.sessionImages);
                if(Object.keys(this.sessionImages).length > 0) {
                    console.log('own')
                } else {
                    console.log('no own')
                }
            }
        },
        mounted: function () {
            console.log(Object.keys(this.sessionImages).length);
            console.log(this.sessionImages);
            console.log(this.sessionMap);
            console.log(this.sessionMap['2']['imageSrc1']);
        },
        components: {
            columnPictureUpload, pictureBox, pictorialMenuItem, pictorialMenuItemCreator
        },
    });
</script>
