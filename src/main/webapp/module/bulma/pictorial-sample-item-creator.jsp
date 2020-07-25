<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/module/bulma/picture-upload.jsp" />

<%--<script src="/js/vue/vue.js"></script>--%>

<script >
    var pictorialSampleItemCreator = Vue.component('pictorial-sample-item-creator', {
        template: `
            <div class="card">
                <picture-upload v-if="!editedItem"
                    :form-name="formName" :propertyName="propertyName" ></picture-upload>
                <picture-upload v-if="editedItem"
                    :form-name="formName" :editedImageSrc="editedItem.IMAGESRC" :propertyName="propertyName" ></picture-upload>
                <div class="card-content">
                    <div class="media" style="padding-top: 15px;">
                        <div class="media-content">
                            <div class="field">
                                <div class="control">
                                    <input class="input is-primary" type="text" v-model="title" placeholder="عنوان">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="content">
                        <textarea class="textarea" placeholder="توضیحات" v-model="description" rows="2"></textarea>
                    </div>
                </div>
                <footer class="card-footer">
                    <button v-if="!editedItem" class="card-footer-item button is-white" v-on:click="addClick">
                        افزودن
                    </button>
                    <button v-if="editedItem" class="card-footer-item button is-white" v-on:click="editClick">
                        تغییر
                    </button>
                </footer>
            </div>
`,
        props: {
            editedItem: {
                type: Object
            },
            formName: {
                type: String
            },
            propertyName: {
                type: String
            },
            link: {
                type: String
            },
            images: {
                type: Array
            },
            caption: {
                type: String
            }
        },
        data: function() {
            return {
                title: '',
                description: '',
                imageSrc: '',
                sharedState: store.state
            }
        },
        components: {
            pictureUpload
        },
        methods: {
            addClick: function () {
                // console.log(JSON.stringify(this.sharedState.forms[this.formName]))
                console.log(this.title)
                console.log(this.description)
                store.setToForms(this.formName, "title", this.title);
                store.setToForms(this.formName, "description", this.description);
                this.$emit("add-item", this.sharedState.forms[this.formName]);
            },
            editClick: function () {
                store.setToForms(this.formName, "id", this.editedItem.ID);
                store.setToForms(this.formName, "title", this.title);
                store.setToForms(this.formName, "description", this.description);
                store.setToForms(this.formName, "imageSrc", this.imageSrc);
                this.$emit("edit-item", this.sharedState.forms[this.formName]);
            }
        },
        mounted: function() {
            console.log(JSON.stringify(this.editedItem))
            if (this.editedItem) {
                this.imageSrc = this.editedItem.IMAGESRC;
                this.title = this.editedItem.TITLE;
                this.description = this.editedItem.DESCRIPTION;
            } else {
                this.title = '';
                this.description = '';
            }
        },
        computed: {
            defaultCaption() {
                if (!this.caption)
                    return 'مشاهده';
                return this.caption;
            }
        }
    });
</script>
