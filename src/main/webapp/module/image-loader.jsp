<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.stream.Collectors" %><%--
  Created by IntelliJ IDEA.
  User: tentwo
  Date: 7/8/2020
  Time: 9:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="js/vue/vue.js"></script>

<script >
    var imageLoader = Vue.component('image-loader', {
        template: `
        <div class="grid-x">
        <div class="cell small-12 text-center" >
            <button v-if="!item.image"
                    class="button success" v-bind:style="{ width: width }"
                    style="border-bottom-left-radius: 0px; border-bottom-right-radius: 0px; outline: none; box-shadow: none;"
                    type="button" v-on:click="selectImage">انتخاب</button>
            <button v-if="item.image"
                    class="button success" v-bind:style="{ width: width }"
                    style="border-bottom-left-radius: 0px; border-bottom-right-radius: 0px; outline: none; box-shadow: none;"
                    type="button" v-on:click="submitFile">ارسال</button>
        </div>
        <div class="cell small-12 text-center" >
            <img v-if="item.image" :src="item.image" style="border: 1px solid #28a745; margin-bottom: 10px;"
                 v-bind:style="{ width: width, height: height }"/>
            <img v-if="!item.image" :src="unknownURL" style="border: 1px solid #28a745; margin-bottom: 10px;"
                 v-bind:style="{ width: width, height: height }"/>
            <input type="file" id="file" ref="file" @change="handleFileUpload($event)" style="display: none"/>
        </div>
    </div>`,
        data: function() {
            return {
                unknownURL: '/images/no-image.png',
                width: 256,
                height: 256,
                message: '',
                item: {
                    image: false,
                },
                file: ''
            }
        },
        methods: {
            selectImage() {
                this.$refs.file.click()
            },
            createImage(file) {
                var image = new Image();
                var reader = new FileReader();

                reader.onload = (e) => {
                    this.item.image = e.target.result;
                };
                reader.readAsDataURL(file);
            },
            removeImage: function () {
                this.item.image = false;
            },
            handleFileUpload: function(event) {
                // console.log(event.target.files[0]);
                // console.log(this.$refs.file.files[0]);
                this.file = this.$refs.file.files[0];
                this.createImage(this.file);
                console.log(this.file)
            },
            submitFile: function() {
                console.log("this.file");
                console.log(this.file);
                let formData = new FormData();
                formData.append('file', this.file);
                let actn = this.action ? this.action : '$bean$';
                let actv = this.activity ? this.activity : 'x';
                axios.post('/action/servlet', formData, {
                    headers: {
                        "action": actn,
                        "activity": actv,
                        'Content-Type': 'multipart/form-data'
                    }
                }).then(function(){
                    console.log('SUCCESS!!');
                }).catch(function(){
                    console.log('FAILURE!!');
                });
            }
        }
    });
</script>
