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
            <figure class="image is-64x64" :style="[activeId == sessionImage['id'] ? {'background-color': 'red'} : {'background-color': '#FFF'}]">
                <img :src="sessionImage['imageSrc']"/>
            </figure>
        </div>
        <div class="columns is-overlay is-vcentered is-multiline is-mobile" style="margin: 0px;">
            <div v-if="activeId != sessionImage['id']" class="column is-full" style="margin: 0px; padding: 0px;">
                <span class="image is-64x64">
                    <img src="/img/select.png" style="opacity: 0.08;" v-on:click="selectImage">
                </span>
            </div>
            <div v-if="activeId == sessionImage['id']" class="column is-full" style="margin: 0px; padding: 0px;">
                <span class="image is-64x32">
                    <img src="/img/edit.png" style="opacity: 0.4;" v-on:click="selectImage">
                </span>
            </div>
        </div>
    </div>
</div>
`,
        props: {
            formName: String,
            propertyName: String,
            sessionImage: {},
            activeId: 0,
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
            },
            deleteImage() {
            },
            selectImage() {
                this.$emit("select-session-image", this.sessionImage['id']);
            }
        }
    });
</script>
