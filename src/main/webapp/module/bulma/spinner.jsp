<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style scoped>
    .loader-container {
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        z-index: 100000000;
    }

    .loader {
        position: fixed;
        left: 50%;
        top: 50%;
        border: 16px solid #f3f3f3; /* Light grey */
        border-top: 16px solid #3498db; /* Blue */
        border-radius: 50%;
        width: 120px;
        height: 120px;
        z-index: 100000000;
        animation: spin 2s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
</style>

<script >
    var spinner = Vue.component('spinner', {
        template: `
<div v-bind:class="{'loader-container': waiterVal}">
<div class="loader"></div>
</div>
`,
        props: {
        },
        methods: {
        },
        computed: {
            waiterVal: function () {
                console.log("dddddddd")
                return store.getFromForm('waiter', 'wait');
            }
        },
        watch: {
            waiterVal: function () {
                console.log("ccccccccc")
                store.getFromForm('waiter', 'wait');
            }
        },
    });
</script>
