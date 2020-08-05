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
<jsp:include page="/module/bulma/spinner.jsp" />

<style type="text/css">
    .sample-item-overlay-button {
        color: #c69500;
        cursor: pointer;
    }
    .sample-item-overlay-button:hover {
        background-color: #c2e0f5;
        padding: 4px;
        border-radius: 3px;
    }
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
        <figure class="image is-4by3" style="overflow: hidden;">
            <img v-if="activeId == 0" :src="unknownURL">
            <img v-if="activeId != 0" :src="images[activeId]['imageSrc']" v-bind:style="{ transform: rotateVal }">
        </figure>
        <div class="columns is-mobile is-vcentered is-overlay is-multiline" style="margin: 0px;">
            <div class="column is-full" style="height: 20%;">
                <div v-if="activeId" class="columns" style="padding: 0px; margin: 0px;">
                    <input type="file" id="file" ref="file" @change="handleFileUpload($event)"
                        class="is-white fa fa-angle-right" style="display: none" />
                    <div class="column" style="padding: 0px; margin: 0px;">
                        <span><i class="fa fa-image sample-item-overlay-button" v-on:click="selectImage" aria-hidden="true"></i></span>
                        <span><i class="fa fa-trash sample-item-overlay-button" v-on:click="deleteClick" aria-hidden="true"></i></span>
                        <span><i class="fa fa-angle-right sample-item-overlay-button" v-on:click="rotateRightClick" aria-hidden="true"></i></span>
                        <span><i class="fa fa-angle-left sample-item-overlay-button" v-on:click="rotateLeftClick" aria-hidden="true"></i></span>
                    </div>
                </div>
            </div>
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
            <div class="column is-full is-info " style="height: 20%;">
            </div>
        </div>
    </div>
    <div class="card-content">
        <div class="columns is-mobile is-multiline" style="margin: 0px;">
            <session-picture-upload v-on:add-session-image="addSessionImage"></session-picture-upload>
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
                activeId: 0,
                rotate: 0
            }
        },
        components: {
            sessionPictureUpload,
            sessionPictureSelect
        },
        computed: {
            waiterVal: function () {
                return store.getFromForm('waiter', 'wait');
            },
            imagesVal: function () {
                return store.getFromForm('session', 'images');
            },
            activeIdVal: function () {
                return store.getFromForm('session', 'activeId');
            },
            rotateVal: function () {
                return 'rotate(' + this.rotate + 'deg)';
            }
        },
        watch: {
            waiterVal: function () {
                store.getFromForm('waiter', 'wait');
            },
            imagesVal: function () {
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
            addSessionImage: function (image, rotate) {
                console.log("click")
                this.$emit("add-session-image", image, rotate);
            },
            deleteClick: function () {
                this.$emit("delete-session-image", this.activeId);
            },
            rotateLeftClick: function () {
                this.rotate -= 90;
                console.log("rotate left", this.rotate)
            },
            rotateRightClick: function () {
                this.rotate += 90;
                console.log("rotate right", this.rotate)
            },
            selectImage() {
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
                    this.$emit("replace-session-image", this.file, this.activeId);
                };
                reader.readAsDataURL(file);
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
