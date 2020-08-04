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
    var sessionPictureUpload = Vue.component('session-picture-upload', {
        template: `
<div class="card picture-upload-plus">
    <div class="card-image">
        <div class="card-image">
            <figure class="image is-64x64">
                <img :src="unknownURL" v-on:click="selectImage"/>
                <input type="file" id="file" ref="file" @change="handleFileUpload($event)"
                        class="is-white fa fa-angle-right" style="display: none" />
            </figure>
        </div>
    </div>
</div>
`,
        props: {
            formName: String,
            propertyName: String,
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
                        // store.setToForm(this.formName, this.propertyName, this.item.image);
                    // }
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
