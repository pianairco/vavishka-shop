<jsp:include page="../module/image-loader.jsp" />

<div id="app">
    <div class="grid-x">
        <div class="cell small-12 large-3">
            <image-loader :params="params1" :url="'/images/image-upload'" :action="'imageUploader'" :activity="'saveHeaderImage'"></image-loader>
        </div>
        <div class="cell small-12 large-3">
            <image-loader :params="params2" :url="'/images/image-upload'" :action="'imageUploader'" :activity="'saveHeaderImage'"></image-loader>
        </div>
        <div class="cell small-12 large-3">
            <image-loader :params="params3" :url="'/images/image-upload'" :action="'imageUploader'" :activity="'saveHeaderImage'"></image-loader>
        </div>
        <div class="cell small-12 large-3">
            <image-loader :params="params4" :url="'/images/image-upload'" :action="'imageUploader'" :activity="'saveHeaderImage'"></image-loader>
        </div>
    </div>

    <div class="text-center">
        <h1>Select Four Image</h1>
        <hr>
    </div>
</div>

<script>
    var app = new Vue({
        el: '#app',
        data: function () {
            return {
                params1: {
                    "image_upload_group": "header",
                    "image_upload_sql_param_1": 'i:1',
                    "image_upload_force_width": 2000,
                    "image_upload_force_height": 750
                },
                params2: {
                    "image_upload_group": "header",
                    "image_upload_sql_param_1": 'i:2',
                    "image_upload_force_width": 2000,
                    "image_upload_force_height": 750
                },
                params3: {
                    "image_upload_group": "header",
                    "image_upload_sql_param_1": 'i:3',
                    "image_upload_force_width": 2000,
                    "image_upload_force_height": 750
                },
                params4: {
                    "image_upload_group": "header",
                    "image_upload_sql_param_1": 'i:4',
                    "image_upload_force_width": 2000,
                    "image_upload_force_height": 750
                }
            }
        },
        methods: {
        },
        components: {
            imageLoader
        },
    });
</script>
