<%@ page import="ir.piana.dev.strutser.util.JspUtil" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<html class="no-js" lang="fa" dir="rtl">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>test</title>

    <link href="/js/bulma/bulma-rtl.min.css" rel="stylesheet">
    <script src="/js/vue/vue.js"></script>
    <script src="/js/axios/axios.js"></script>
</head>
<body >

<div class="container" id="testApp">
    <first-comp></first-comp>
    <second-comp></second-comp>
</div>

<script>
    <%=JspUtil.getStore("store", "comp")%>
    // var store = {
    //     state: {
    //         forms: {comp: {}}
    //     }
    // }

    var firstComp = Vue.component('first-comp', {
        template: `<div><div v-if="name">{{name}}</div><div v-if="lname">{{lname}}</div></div>`,
        data: function () {
            return {
                name: '',
                lname: '',
                sharedState: store.state
            }
        },
        computed: {
            lnameVal: function() {
                return store.state.forms['comp']['lname'];
            },
            nameVal: function() {
                return store.state.forms['comp']['name'];
            }
        },
        watch: {
            lnameVal: function () {
                this.lname = store.state.forms['comp']['lname'];
            },
            nameVal: function() {
                this.name = store.state.forms['comp']['name'];
            }
        },
        methods: {
        }
    });

    var secondComp = Vue.component('second-comp', {
        template: `<div><button v-on:click="onClick">click</button><button v-on:click="onLClick">lclick</button></div>`,
        data: function () {
            return {
                storeState: store.state
            }
        },
        methods: {
            onClick: function() {
                console.log("sdd");
                store.setToForms("comp", "name", "ali");

                // let obj = Object.assign({}, this.storeState.forms['comp']);
                // obj['name'] = 'sdfs';
                // this.storeState.forms['comp'] = obj;
                console.log(JSON.stringify(this.storeState))
            },
            onLClick: function() {
                store.setToForms("comp", "lname", "sasa");

                console.log(JSON.stringify(this.storeState))
            }
        }
    });

    var app = new Vue({
        el: '#testApp',
        data: function () {
            return {
                sharedState: store.state
            }
        },
        compoent: {
            firstComp, secondComp
        },
        methods: {

        }
    });
</script>
</body>
</html>
