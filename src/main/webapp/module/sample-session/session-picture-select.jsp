<%--
  Created by IntelliJ IDEA.
  User: tentwo
  Date: 7/8/2020
  Time: 9:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    var sessionPictureSelect = Vue.component('session-picture-select', {
        template: `
<div class="card picture-upload-plus">
    <div class="card-image">
        <div class="card-image">
            <figure class="image is-64x64">
                <img :src="sessionImage['imageSrc']" v-on:click="selectImage"/>
            </figure>
        </div>
    </div>
</div>
`,
        props: {
            formName: String,
            propertyName: String,
            sessionImage: {},
            unknownURL: {
                default: '/img/plus.png',
                type: String
            }
        },
        data: function() {
            return {
                item: {
                    image: false,
                },
                sharedState: store.state
            }
        },
        components: {
        },
        mounted: function () {
        },
        methods: {
            reset: function () {
                this.item.image = false;
            },
            deleteImage() {
                this.item.image = false;
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
                    this.$emit("select-image", this.file);
                    // this.submitFile();
                    // if(this.formName) {
                        // store.setToForms(this.formName, this.propertyName, this.item.image);
                    // }
                };
                reader.readAsDataURL(file);
            },
            submitFile: function() {
                let formData = new FormData();
                formData.append('file', this.file);
                let headers = {
                    'image_upload_group': this.imageUploadGroup,
                    'image_upload_sql_param_1': 'i:' + this.sessionId,
                    '$image_src$': 'image_src' + this.order,
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
