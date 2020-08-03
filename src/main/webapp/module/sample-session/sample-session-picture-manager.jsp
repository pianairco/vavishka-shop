<%--
  Created by IntelliJ IDEA.
  User: tentwo
  Date: 7/8/2020
  Time: 9:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/module/sample-session/session-picture-upload.jsp" />
<jsp:include page="/module/sample-session/session-picture-select.jsp" />

<style type="text/css">
    .picture-upload-center-control-container {
        margin-top: 0px;
        margin-bottom: 0px;
        height: 100%;
    }
    .picture-upload-plus {
        cursor: pointer;
        color: green;
        opacity: 0.8;
    }
    .picture-upload-plus:hover {
        background-color: #f1eaff;
        padding: 4px;
        border-radius: 6px;
        cursor: pointer !important;
    }
</style>


<script >
    var sampleSessionPictureManager = Vue.component('sample-session-picture-manager', {
        template: `
<div class="card">
    <div class="card-image">
        <figure class="image is-4by3">
            <img v-if="activeId == 0" :src="unknownURL">
            <img v-if="activeId != 0" :src="images[activeId]['imageSrc']">
        </figure>
        <div class="columns is-mobile is-vcentered is-overlay is-multiline" style="margin: 0px;">
            <div class="column is-full" style="height: 20%;"></div>
                <div class="column is-full is-info" style="height: 60%;">
                    <div class="columns is-mobile is-vcentered is-multiline picture-box-center-control-container"
                        v-if="images && images.length > 1" style="margin-top: auto; margin-bottom: auto;">
                        <div class="column is-narrow">
                            <button v-on:click="next" class="button is-white fa fa-angle-right" style="opacity: 0.4;"></button>
                        </div>
                    <div class="column">&nbsp;</div>
                    <div class="column is-narrow">
                        <button v-on:click="prev" class="button is-white is-transparent fa fa-angle-left" style="opacity: 0.4;"></button>
                    </div>
                </div>
            </div>
            <div class="column is-full is-info " style="height: 20%;"></div>
        </div>
    </div>
    <div class="card-content">
        <div class="columns is-mobile is-multiline" style="margin: 0px;">
            <session-picture-upload v-on:select-image="addSessionImage"></session-picture-upload>
            <session-picture-select
                v-for="image in images"
                :session-image="image"
                v-bind:active-id="activeId"
                v-on:select-session-image="selectSessionImage"></session-picture-select>
        </div>
    </div>
</div>
`,
        props: {
            formName: String,
            propertyName: String,
            isUpload: true,
            isActive: false,
            sessionId: {
                type: Number
            },
            url: String,
            imageUploadGroup: {
                type: String
            },
            order: {
                type: String
            },
            editedImageSrc: {
              type: String
            },
            title: {
                type: String
            },
            unknownURL: {
                default: '/images/no-image.png',
                type: String
            }
        },
        data: function() {
            return {
                idx: 0,
                item: {
                    image: false,
                },
                file: '',
                sharedState: store.state,
                images: {},
                activeId: 0
            }
        },
        components: {
            sessionPictureUpload,
            sessionPictureSelect
        },
        computed: {
            imagesVal: function () {
                return store.getFromForm('session', 'images');
            },
            activeIdVal: function () {
                return store.getFromForm('session', 'activeId');
            }
        },
        watch: {
            imagesVal: function () {
                console.log("+")
                this.images = store.getFromForm('session', 'images');
            },
            activeIdVal: function () {
                this.activeId = store.getFromForm('session', 'activeId');
            }
        },
        mounted: function () {
        },
        methods: {
            reset: function () {
                this.item.image = false;
            },
            selectSessionImage: function(id) {
                this.$emit("select-session-image", id);
            },
            addSessionImage: function (image) {
                this.$emit("add-session-image", image);

                // this.sessionImages[order + ''] = path;
                // console.log(this.sessionImages);
                // if(Object.keys(this.sessionImages).length > 0) {
                //     console.log('own')
                // } else {
                //     console.log('no own')
                // }
            },
            deleteImage() {
                this.item.image = false;
            },
            selectImage() {
                if(!this.isActive)
                    this. isActive = true;
                else
                    this.$refs.file.click();
            },
            handleFileUpload: function(event) {
                // console.log(event.target.files[0]);
                // console.log(this.$refs.file.files[0]);
                this.file = this.$refs.file.files[0];
                this.createImage(this.file);
            },
            createImage(file) {
                var image = new Image();
                var reader = new FileReader();

                reader.onload = (e) => {
                    this.item.image = e.target.result;
                    this.submitFile();
                    // if(this.formName) {
                        // store.setToForm(this.formName, this.propertyName, this.item.image);
                    // }
                };
                reader.readAsDataURL(file);
            },
            submitFile: function() {
                // console.log(this.file);
                // console.log(this.url);
                // console.log(this.activity);
                // console.log(this.action);
                let formData = new FormData();
                formData.append('file', this.file);
                let headers = {
                    'image_upload_group': this.imageUploadGroup,
                    'image_upload_sql_param_1': 'i:' + this.sessionId,
                    'image_upload_sql_param_2': 'i:' + this.images.length + 1,
                    'Content-Type': 'multipart/form-data'
                };

                // headers["action"] = this.action;
                // headers["activity"] = this.activity;

                let self = this;
                // this.state.isSpin = true;
                axios.post(this.url, formData, {
                    headers: headers
                }).then((res) => {
                    console.log('SUCCESS!!');
                    console.log(res);
                    console.log(res['data']['data']['path']);
                    console.log(this.order);
                    this.$emit("add-session-image", res['data']['data']['path'], this.order);
                    // self.state.isSend = true;
                    // self.state.isSpin = false;
                }).catch(() => {
                    console.log('FAILURE!!');
                    // self.state.isSpin = false;
                });
            },
            next: function () {
                this.idx++;
                if(this.idx >= this.images.length)
                    this.idx = 0;
            },
            prev: function () {
                this.idx--;
                if(this.idx < 0)
                    this.idx = this.images.length - 1;
            }
        }
    });
</script>
