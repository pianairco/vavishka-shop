<%@ page import="ir.piana.dev.strutser.util.JspUtil" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:include page="/module/bulma/pictorial-menu-item.jsp" />
<jsp:include page="/module/bulma/pictorial-menu-item-creator.jsp" />

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
                                :id="session['id']"
                                :image="session['iconSrc']"
                                :description="session['description']"
                                :title="session['title']"></pictorial-menu-item>
                    </li>
                </ul>
            </aside>
        </div>
        <div class="column is-full-mobile is-three-quarters-desktop">
            <div class="card">
                <div class="card-image">
                    <figure class="image is-4by3">
                        <img src="https://bulma.io/images/placeholders/1280x960.png" alt="Placeholder image">
                    </figure>
                </div>
                <div class="card-content">
                    <div class="media">
                        <div class="media-left">
                            <figure class="image is-48x48">
                                <img src="https://bulma.io/images/placeholders/96x96.png" alt="Placeholder image">
                            </figure>
                        </div>
                        <div class="media-content">
                            <p class="title is-4">John Smith</p>
                            <p class="subtitle is-6">@johnsmith</p>
                        </div>
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
                sessions: ${sessions},
                editedId: 0
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
            }
        },
        components: {
            pictorialMenuItem, pictorialMenuItemCreator
        },
    });
</script>
