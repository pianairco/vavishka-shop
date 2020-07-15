    <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
    <%@ page language="java" contentType="text/html;charset=UTF-8" %>

    <html class="no-js" lang="fa" dir="rtl">
        <head>
            <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title><tiles:getAsString name="title" /></title>

            <link href="/js/bulma/bulma-rtl.min.css" rel="stylesheet">
    <%--        <script src="js/vue/vue.js"></script>--%>
    <%--        <script src="js/vue/vue-router.js"></script>--%>
    <%--        <script src="/js/axios/axios.js"></script>--%>

            <link href="/style/bulma/style.css" rel="stylesheet">
        </head>

        <body class="has-navbar-fixed-top">
        <tiles:insertAttribute name="menu" />
        <tiles:insertAttribute name="header" />

        <div id="home" class="documentation">
            <section class="flex five">
                <aside class="full fifth-1000">
                    <h2>Contents</h2>
                    <div class="links flex two three-500 five-800 one-1000">
                        <div><a class="pseudo button" href="#buttons">Buttons</a></div>
                        <div><a class="pseudo button" href="#card">Card</a></div>
                        <div><a class="pseudo button" href="#checkbox">Checkbox</a></div>
                        <div><a class="pseudo button" href="#dropimage">Drop image</a></div>
                        <div><a class="pseudo button" href="#grids">Grids</a></div>
                        <div><a class="pseudo button" href="#input">Input</a></div>
                        <div><a class="pseudo button" href="#label">Label</a></div>
                        <div><a class="pseudo button" href="#modal">Modal</a></div>
                        <div><a class="pseudo button" href="#nav">Nav</a></div>
                        <div><a class="pseudo button" href="#radiobutton">Radio button</a></div>
                        <div><a class="pseudo button" href="#select">Select</a></div>
                        <div><a class="pseudo button" href="#stack">Stack</a></div>
                        <div><a class="pseudo button" href="#table">Table</a></div>
                        <div><a class="pseudo button" href="#tabs">Tabs</a></div>
                        <div><a class="pseudo button" href="#tooltip">Tooltip</a></div>
                    </div>
                    <a href="#home" tabindex="-1" class="top pseudo button">▲ Up you go ▲</a>
                </aside>
                <article class="full four-fifth-1000">
                    <h1 id="picnic-css">Picnic CSS</h1>
                    <p>Picnic CSS is a lightweight and beautiful CSS library</p>
                    <h2 id="buttons">Buttons</h2>
                    <p>They can be of different colors and types:</p>
                    <div><button>Button</button>
                        <button class="success">Success</button>
                        <button class="warning">Warning</button>
                        <button class="error">Error</button>
                        <button disabled="">Disabled</button>
                    </div>

                    <div class="tabs four">
                        <input id="tabC-1" type='radio' name='tabGroupC' checked >
                        <input id="tabC-2" type='radio' name='tabGroupC'>
                        <input id="tabC-3" type='radio' name='tabGroupC'>
                        <input id="tabC-4" type='radio' name='tabGroupC'>
                        <div class='row'>
                            <div>
                                <img src="/img/forest.jpg">
                            </div>
                            <div>
                                <img src="/img/lake.jpg">
                            </div>
                            <div>
                                <img src="/img/halong.jpg">
                            </div>
                            <div>
                                <img src="/img/balloon.jpg">
                            </div>
                        </div>
                        <label for="tabC-1"><img src="/img/forest.jpg"></label>
                        <label for="tabC-2"><img src="/img/lake.jpg"></label>
                        <label for="tabC-3"><img src="/img/halong.jpg"></label>
                        <label for="tabC-4"><img src="/img/balloon.jpg"></label>
                    </div>

                    <tiles:insertAttribute name="body" />
                </article>
            </section>
        </div>
        <div style="height: 800px;">&nbsp;</div>
        <tiles:insertAttribute name="footer" />
        </body>
    </html>

    <script>

    u([window]).on('scroll', function(){
        var top = this.scrollY || document.documentElement.scrollTop;
        u('.top').toggleClass('visible', top > 1000);
    }).trigger('scroll');</script><script>window.onload = function(){

        // Dropimage handler
        [].forEach.call(document.querySelectorAll('.dropimage'), function(img){
            img.onchange = function(e){
                var inputfile = this, reader = new FileReader();
                reader.onloadend = function(){
                    inputfile.style['background-image'] = 'url('+reader.result+')';
                }
                reader.readAsDataURL(e.target.files[0]);
            }
        });
    };
    </script>
