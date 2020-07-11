<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<script src="/js/vue/vue.js"></script>

<div id="header" class="orbit" role="region" aria-label="Favorite Space Pictures" data-orbit data-options="animInFromLeft:fade-in; animInFromRight:fade-in; animOutToLeft:fade-out; animOutToRight:fade-out;">
    <ul class="orbit-container">
        <button class="orbit-next"><span class="show-for-sr">Previous Slide</span>&#9664;&#xFE0E;</button>
        <button class="orbit-previous"><span class="show-for-sr">Next Slide</span>&#9654;&#xFE0E;</button>
        <li class="is-active orbit-slide" v-for="img in images">
            <img class="orbit-image" v-bind:src="img['PATH']" alt="Space">
<%--            <figcaption class="orbit-caption">Space, the final frontier.</figcaption>--%>
        </li>
<%--        <li class="is-active orbit-slide" for="let img in images">--%>
<%--            <img class="orbit-image" src="https://placehold.it/2000x750&text=1st" alt="Space">--%>
<%--            <figcaption class="orbit-caption">Space, the final frontier.</figcaption>--%>
<%--        </li>--%>
<%--        <li class="orbit-slide">--%>
<%--            <img class="orbit-image" src="https://placehold.it/2000x750&text=2nd" alt="Space">--%>
<%--            <figcaption class="orbit-caption">Lets Rocket!</figcaption>--%>
<%--        </li>--%>
<%--        <li class="orbit-slide">--%>
<%--            <img class="orbit-image" src="https://placehold.it/2000x750&text=3nd" alt="Space">--%>
<%--            <figcaption class="orbit-caption">Encapsulating</figcaption>--%>
<%--        </li>--%>
<%--        <li class="orbit-slide">--%>
<%--            <img class="orbit-image" src="https://placehold.it/2000x750&text=4nd" alt="Space">--%>
<%--            <figcaption class="orbit-caption">Outta This World</figcaption>--%>
<%--        </li>--%>
    </ul>
    <nav class="orbit-bullets">
        <button class="is-active" data-slide="0"><span class="show-for-sr">First slide details.</span><span class="show-for-sr">Current Slide</span></button>
        <button data-slide="1"><span class="show-for-sr">Second slide details.</span></button>
        <button data-slide="2"><span class="show-for-sr">Third slide details.</span></button>
        <button data-slide="3"><span class="show-for-sr">Fourth slide details.</span></button>
    </nav>
    <button type="button" class="button" v-on:click="load">ok</button>
</div>

<script>
    var header = new Vue({
        el: '#header',
        data: function () {
            return {
                images: <%=request.getAttribute("images")%>,
                url: '/image-loader'
            }
        },
        methods: {
            load: function () {
                // console.log('clicked')
                // axios.get(this.url, {
                //     headers: {
                //         'image_loader_group': 'header'
                //     }
                // }).then(function(e){
                //     console.log('SUCCESS!!');
                //     // console.log(e);
                //     let images = e['data']['data'];
                //     console.log(images);
                //     this.images = images;
                //     console.log(this.images);
                //     console.log(this);
                //     console.log(self);
                //     images.forEach((item, index) => {
                //         console.log(item)
                //         console.log(index)
                //         Vue.set(this.images, index, item);
                //     });
                //     console.log(this.images[0]['PATH']);
                // }).catch(function(e){
                //     console.log(e)
                //     console.log('FAILURE!!');
                // });
            }
        },
    });
</script>
