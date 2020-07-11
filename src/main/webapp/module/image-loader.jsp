<jsp:include page="./spinner.jsp" />

<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.stream.Collectors" %>
<%--
  Created by IntelliJ IDEA.
  User: tentwo
  Date: 7/8/2020
  Time: 9:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="/js/vue/vue.js"></script>

<style >
</style>

<script >
    var imageLoader = Vue.component('image-loader', {
        template: `

        <div class="grid-x" >
        <spinner v-if="state.isSpin"></spinner>
        <div class="cell small-12 text-center" >
            <button v-if="!item.image"
                    class="button primary" v-bind:style="{ width: width }"
                    style="border-bottom-left-radius: 0px; border-bottom-right-radius: 0px; outline: none; box-shadow: none;"
                    type="button" v-on:click="selectImage">انتخاب</button>
            <button v-if="item.image && state.isSend"
                    class="button success" v-bind:style="{ width: width }"
                    style="border-bottom-left-radius: 0px; border-bottom-right-radius: 0px; outline: none; box-shadow: none;"
                    type="button" v-on:click="reset">انتخاب دوباره</button>
            <button v-if="item.image && !state.isSend"
                    class="button warning" v-bind:style="{ width: width }"
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
        props: {
            params: {
              type: Object
            },
            width: {
                default: '300px',
                type: String
            },
            height: {
                default: '300px',
                type: String
            },
            unknownURL: {
                default: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAYAAACtWK6eAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAADOhJREFUeJzt3XvMHUUdxvHvS1+gLaUtImCbcm0QEMGEoIhyE5EqIBirKCAVFDHI3RhREqMx/uEFuaioiahoQIlCoqCNWgigxpiAIBW02JY7FqGUQgstb2/+8TsH377s7Oz2nZ2Z3fN8kk3aPefszu45z7uXmZ0BERERERERERERERERERERERERERERERERERERERERERERERERERERERGRcZsETExdCJEcTQYWAL9FIRHZTD8cm3qTQiLSMzYcColIzySKw6GQSCts1fDyNwEjJa8fB9yEQiIDbCJ2pHAdRXQkkYGnkIh4KCQiHgqJiIdCIuKhkIh4KCQiHgqJiIdCIuKhkIh4KCSSnaHUBRhjItY267iS98wH5gJro5So2B7AuxOuf0vMBx5LXQgZv9yPJK8DlnrKl+P0b2CnBvaHJJBrSKYB93rKlfN0N7B98L0iSeQWkonAHZ7ytGG6Ddg27K6RVHIJyQTgV55ytGm6keafBZJIcgjJDz3rb+P0/aB7qKNyu4vlkvLu1leBS0peXwA8FHidocwGjil5/SvAFyKVRRqW4kjyac/6cj9VqXJqeEGy0klwMUMyD9hYsp62XOxOBO7EvR0bgVOTlU6CixGS44F1Jctv2+1S3+3pEdpX8SklmgzJ24GXSpb7IO2scNsFWIJ7u14E3pqsdBJcEyF5I7CiZHlPAruHKX4Ss4FluLfvWeANyUonwYUOyVkly1kB7B+w7Km8CViJezsfB3ZLVjoJLnRIzi/4/IvA24KWOq0jgDW499ci4LXJSpeRNtSDTAMOBl4P7Axsx6tvrQ4DJwJ7liynTj3JBcBVvX+vB07qfb5LTsLqliY4Xr8PuDXwOjdh+/+/2LXcXdjRTGqaBpwH/AX7gZYdHepMdY4kFwIbgI+E2KBMnUm4fbsl0wbsOz4PmNrwtnbCZODLwPM096XUCcmBAbYpd5eQNiT96Xngi9hvQAocBjxCnC9DTyZu7jLSB6Q/PYT9FmSUcwl7KqWQ1DMEXEv6cPSndcA5TW5wm1xKui9CIfm/YeAW0odj9FTWSDSK1HexzgJ+UOF9TwB/xmqCX8B2XhXDwEeBfUvek8Mz7rmYBHwS229N2R7YGzuN2rXC+8/Ejm4D5yDsR1n2F+Rmxn8+msPzJFLscPxHrbVY5eZAGQYW4t4pT2MNBkNRSPJ2AvAM7u/mHtz1NZ10Du6d8TCwVwPrVEjyNht4FPd38/F0RYtrGPft3JXY+WlTFJK87YO7DmwpeT+cFszxuH+cMWqtFZK8ldXuz0lYrmh+SvHG3xWxDApJvoZwP9x1TcJyRfMk6Y4eoykk+TqD4u/j0YRlimIXijd8HWkeYVVI8jQda8hY9H1EbYYfu6LwMOBPBfMXku5ed6ouhSZjFZh7ATOAHXplWQ+s6k1PYX3qLsGeGx8kD1D8dOOhwF8jlyWaEyn+q3BzykIR50gyCdv+q7FnLeq0PVvf+8yVvWVsN45ytMV8ivfFCSkL1bQPUbzRN6QsVE9TITkSuA5Y7Vl2nWkV8BPgaNI3F2rKjRRv+9yUhWrah8k3IBA+JHM9ywox3Yf94elaHYErIB+IWYiu7dTxWov9qMserz0Ou2apEpKbgIsDlKvMgdgfmIXAUQ2va+AoIK8WOiRXAhcFKJfP/sDt2OncjhHWNxCabNbcZv2QlN3d6oekyt2tq7DTg6vGzF8G3I+1P3sa67Bua2AKdldrNtb8YmaNsp+GXfecgj0iIC2S+zXIWKGvSc4DfgmcDsyqUY5ZWF/BN1De6+PoaR3Nn941KYtrkNjaFhDIrzJxKnA2Vj9SJSjfoJ13uhQQ2hEQyC8kYM9HnIr1hOgLyTW0LyQKCO0JCOQZErDrlctwN83oT1+PXK7xUkBoV0DAfvz/JL+QALwL67GwrGwXJijXlsoiILrNW8+hWBeoZercAg5pAdZF679K3nMZ3epjuHEKSHU7AtdT7dnoVCF5HGsQ6nq2Zhg7Wr8mWolaTgGp7mqs1W1VqUKyAhstynUk2RW4PF5x2k0BqWYO1t6pyMsln0sZkjlYTyFF5mFd7oiHAuI3Afdf3I34h0ZIebp1OnZhO9YQ8B3ad+u389p4F2se5ZVwkO8tYIArSsr0/gTlqSqLu1ixtS0gQ9iTbUVlfgR7CKov15Bsj7sfgL9FLksdWQREp1jl3ol7UMvPY8OY9YVuBRzKKqysRQ7ChmMTBwWk3Ccc8xdRfNTLNSTXY+NuFJkXsRyto4C4TQHe63jtcoovfiHPkGwAvul47YNsfqoooyggbsdS/MNZDfzM89kcQ/Jzim9JT8WeH5ECCojbsY75t2DDQvvkFpLngN84Xjs6wvpbSQFxc41LckuNZeQWkt855isgDgpIscnAfo7X7qi5rJxCcptj/gEM2PgbVSkgxfaleN88gT1HXlcuIXkYWF4wfxtgzwbX21oKSDHXAD4PjGOZuYTkQcf8fRpcZ2spIMVcrXYfGedycwjJEsf8XRpaX6spIMWmO+YXnZ7UlTokKx3zU/Sunz0FpJjrh7nGMb+ulCFZ5Zg/NfB6OkEBqSfknZ5UIVnnmK9OBAsoIMVcD0FNCbyeFCFxDZ0Q6ujYKQpIsecc83doYF2xQ7KzY75rmweaAlLMVdcxu6H1xQyJq77jP+NcbicpIMVcTcObrCuIFRLX8y1Lx7HMzlJAii3Cnjcfayb1Op2uq+mQ7AXsVDB/BFi8BcvrPAWk2Eu4u81pumFfkyFxlX0h7rtbA00BcXONrVE2Gm4oTYXE9QDYH2ssY6AoIG5/cMw/kTiVak2EZIFjvqsZvETWpl5NpuAerObsiOUI3VvK+WM++xw2qlVu1KtJ5lbjfjjqM8R7fiL0keTbbN7L+43o+iMbbTqCgA0p4PqrfWrksoQ+klzY+8xbgpc0jCyOILG1LSBlHcc9TvimJz6hQ3JSA2UMJYuA6BSr3Cbga47XZgFfilcUIPzp1q9DFKrLFBC/63HXiVyMnYbFlPp5koGigPhtwD2c8lbAddiYGzEpJJEoINX8HviF47Wde6/HHrVJIYlAAanuXOApx2v7YZVtCknHKCDVLccGpNngeP3NWPMUnW51iAJSz63A50pe3w8bc2NOnOK8Yi1wDeUVfgpJC7StHsTlasrrIjZiIzvF6ClkKvC93jrLypRyEJ8tkUU9SGxdCcgQ8GP8P8YnsfE3mmiWMoyNX7KsQjnaGBIFhPYGBCwk36LaD3Ip8CnCPNM+HWtwuLTiutsaEgVk1NTGgPRdDKyn2o9yLfbFn0W9vnB3B87AriHWVFzXCPAPz3tyDkkWAVFfSON3BfB3rMJwpue922J3nOb2/r8c6yt3Cdbj4SrsQns7rH5ld2B/3D2RuDyG/TG6FwuV6yGv/oX7XCy8klgXjyB9O2LNUsZz2hNi+hEwbVS5ch191yeLI4hu84bzLHAacAx2ahPbPdhQah8Dnh81X/UkLdLlI8hoWwGnAPfR/BHjXuyv6pCnTG07kmRxBIltUAIy2juwU6/VhAvFC8C1wOE1y9KmkCggo6YuB6RvEnACdmv4HuwuU9VAjGA19FcA78Eu9rdUW0KSRUB0FyueNdgos/2RZrcB9sY6c5uBNXSciJ0qrcE6U1iG1XcsxkISQv+aRHe3MjTIR5Dc5H4kyeIIortYg0t3typQQAabQuIROyBFHUKD/xalNKdtIdkUc2WxA/KSY37s7nNkczmGxPWoQKdHwjqE4guvRSkLJa/I6cLd1Vr54AjrTmYHijd6I8XjVkh8OYRkRsm6Oz8a72KKN/zclIWSzaQOyUWOdbr6J+uU71K88YtRxWVOUoVkG2wIvKL1XRl4XVk6HPcOvyRhueTVUoTk0pJ1HRJwPVlztXIdoX4DPGlWzJAcibuN2t0Blt8ac3Hv7JXAYemKJgVihOQIrJWya/mu4eM661bcO+Nl4g5SI35NhWQY+Cz2nbuWW1Y/01m7ASso3+GLsK5tpicqo2wudEhmYt9x2fKewf+sf2NSN/E4Fmv+7RsjbwNwP9a5wQu4m6xI8yYA76S8i9X5VG8qfxH2nEuREew3cmedAnbNydR7eEhTO6YtGQ5u9PQy8L6Kn++8OfhPtzS1b6oTkgtGfW45cFTFzw2MPYDbSf+lakoXkvOxsVZmVXz/QDoZu95I/cVqShMSqWAIOBrr0v9R0n/BmgY0JKnvYlU1A9gHa/E7BdWP5Ghr4BzggJL31Lm7JdI5qVsBi2RPIRHxUEhEPBQSEQ+FRMRDIRHxUEhEPBQSEQ+FRMRDIRHxUEhEPBQSEQ+FRMRDIRHxUEhEPBQSEQ+FRMRDIRHxUEhEPLIIiYaBllxVGVhUZOC5jiQ6xRLpGRsShUNkjH5IFA4Rh4koHCIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiMf0PUWtWcapWKpwAAAAASUVORK5CYII=',
                type: String
            },
            url: String,
            action: String,
            activity: String
        },
        data: function() {
            return {
                // unknownURL: '/images/no-image.png',
                // width: 256,
                // height: 256,
                message: '',
                state: {
                    isSend: false,
                    isSpin: false
                },
                item: {
                    image: false,
                },
                file: ''
            }
        },
        components: {
            spinner
        },
        methods: {
            reset() {
                this.state.isSend = false;
                this.item.image = false;
                this.removeImage();
            },
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
                // console.log(this.file);
                // console.log(this.url);
                // console.log(this.activity);
                // console.log(this.action);
                let formData = new FormData();
                formData.append('file', this.file);
                let headers = {};
                if(this.params) {
                    headers = Object.assign({}, this.params);
                }

                headers["action"] = this.action;
                headers["activity"] = this.activity;
                headers["Content-Type"] = "multipart/form-data";

                let self = this;
                this.state.isSpin = true;
                axios.post(this.url, formData, {
                    headers: headers
                }).then(function(){
                    console.log('SUCCESS!!');
                    self.state.isSend = true;
                    self.state.isSpin = false;
                }).catch(function(){
                    console.log('FAILURE!!');
                    self.state.isSpin = false;
                });
            }
        }
    });
</script>
