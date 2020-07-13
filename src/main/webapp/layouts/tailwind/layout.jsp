    <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
    <%@ page language="java" contentType="text/html;charset=UTF-8" %>

    <html class="no-js" lang="fa" dir="rtl">
        <head>
            <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title><tiles:getAsString name="title" /></title>

            <link rel="stylesheet" href="/css/tailwind/tailwind.min.css">
            <link rel="icon" type="image/png" sizes="16x16" href="/favicon-tailwind.png">
            <script src="/js/main.js"></script>
<%--            <link href="/js/tailwind/tailwind.min.css" rel="stylesheet">--%>

    <%--        <script src="js/vue/vue.js"></script>--%>
    <%--        <script src="js/vue/vue-router.js"></script>--%>
    <%--        <script src="/js/axios/axios.js"></script>--%>
        </head>

        <body class="bg-body text-body font-body">
        <div class="container mx-auto px-4">

            <nav class="flex flex-wrap items-center justify-between p-4"><div class="lg:order-2 w-auto lg:w-1/5 lg:text-center"><a class="text-xl text-indigo-500 font-semibold" href="#">Vavishka Shop</a></div>
                <div class="block lg:hidden">
                    <button class="navbar-burger flex items-center py-2 px-3 text-indigo-500 rounded border border-indigo-500">
                        <svg class="fill-current h-3 w-3" viewbox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Menu</title><path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"></path></svg></button>
                </div>
                <div class="navbar-menu hidden lg:order-1 lg:block w-full lg:w-2/5"><a class="block lg:inline-block mt-4 lg:mt-0 mr-10 text-blue-900 hover:text-blue-700" href="#">Products</a><a class="block lg:inline-block mt-4 lg:mt-0 mr-10 text-blue-900 hover:text-blue-700" href="#">Team</a><a class="block lg:inline-block mt-4 lg:mt-0 text-blue-900 hover:text-blue-700" href="#">Customers</a></div>
                <div class="navbar-menu hidden lg:order-3 lg:block w-full lg:w-2/5 lg:text-right"><a class="block lg:inline-block mt-4 lg:mt-0 mr-10 text-blue-900 hover:text-blue-700" href="#">Blog</a><a class="block lg:inline-block mt-4 lg:mt-0 mr-10 text-blue-900 hover:text-blue-700" href="#">FAQ</a><a class="block lg:inline-block mt-4 lg:mt-0 text-blue-900 hover:text-blue-700" href="#">Contact</a></div>
            </nav>

            <section class="py-12 px-4 text-center">
                <div class="w-full max-w-2xl mx-auto">
                    <span class="text-sm font-semibold">TAGLINE</span>
                    <h2 class="text-5xl mt-2 mb-6 leading-tight font-heading">No paper plane can be made without paper</h2>
                    <a class="text-blue-700 hover:underline" href="#">Learn more &raquo;</a>
                </div>
            </section>

            <section class="py-8 px-4">
                <div class="flex flex-wrap -mx-2">
                    <div class="lg:w-2/5 px-2 lg:pr-16 mb-6 lg:mb-0">
                        <h2 class="text-3xl">The real business is done on paper</h2>
                    </div>
                    <div class="lg:w-3/5 px-2">
                        <p>Dunder Mifflin is the way to provide your company an extraordinary paper, sold by extraordinary people. Professional, dedicated, local. Dunder Mifflin is on its best patch to change the way you think about paper. That’s us - people who sell sell limitless paper in the paperless world.</p>
                    </div>
                </div>
            </section>

            <section class="py-12 px-4">
                <h2 class="text-3xl mb-8 text-center font-heading">Contact the Scranton team</h2>
                <div class="w-full max-w-2xl mx-auto mb-12">
                    <form>
                        <div class="flex mb-4 -mx-2">
                            <div class="w-1/2 px-2">
                                <input class="appearance-none block w-full py-3 px-4 leading-tight text-gray-700 bg-gray-200 focus:bg-white border border-gray-200 focus:border-gray-500 rounded focus:outline-none" type="email" placeholder="Email">
                            </div>
                            <div class="w-1/2 px-2">
                                <select class="appearance-none block w-full py-3 px-4 leading-tight text-gray-700 bg-gray-200 focus:bg-white border border-gray-200 focus:border-gray-500 rounded focus:outline-none">
                                    <option>-- Select product --</option>
                                    <option>Product 1</option>
                                    <option>Product 2</option>
                                    <option>Product 3</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-4"><textarea class="appearance-none block w-full py-3 px-4 leading-tight text-gray-700 bg-gray-200 focus:bg-white border border-gray-200 focus:border-gray-500 rounded focus:outline-none" placeholder="Write something..." rows="5"></textarea></div>
                        <div>
                            <button class="inline-block w-full py-4 px-8 leading-none text-white bg-indigo-500 hover:bg-indigo-600 rounded shadow">Submit</button>
                        </div>
                    </form>
                </div>
                <div class="flex flex-col lg:flex-row lg:justify-center -mx-4">
                    <div class="px-4"><img class="inline-block w-8 h-8 pr-2" src="/placeholders/icons/home.svg" alt=""><span>1725 Slough Avenue, Scranton</span></div>
                    <div class="px-4"><img class="inline-block w-8 h-8 pr-2" src="/placeholders/icons/mobile.svg" alt=""><span>555-111-555</span></div>
                    <div class="px-4"><img class="inline-block w-8 h-8 pr-2" src="/placeholders/icons/message.svg" alt=""><span>scranton@dundermifflin.com</span></div>
                </div>
            </section>

            <section class="py-12 px-4 text-center">
                <h2 class="text-4xl mb-8 font-heading">Portfolio</h2>
                <div class="max-w-2xl mx-auto">
                    <img class="rounded shadow-md" src="/placeholders/pictures/office.jpg" alt="">
                    <div class="text-center mt-8 mb-6">
                        <button class="inline-flex items-center justify-center h-3 w-3 mr-2 bg-gray-800 rounded-full"></button>
                        <button class="inline-flex items-center justify-center h-3 w-3 mr-2 bg-gray-600 rounded-full"></button>
                        <button class="inline-flex items-center justify-center h-3 w-3 mr-2 bg-gray-600 rounded-full"></button>
                    </div>
                    <div>
                        <h3 class="text-2xl mb-4 font-heading">Client: Realweb</h3>
                        <p class="text-gray-500 leading-relaxed">Great offer, competitive prices, professional service. That’s how I’d remember the Dunder Mifflin. Although I had to switch paper provider, sometimes I really miss Dunder family. I also got gift basket from the team!</p>
                    </div>
                </div>
            </section>

            <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="">Label for text</label>
                <input class="appearance-none block w-full py-3 px-4 leading-tight text-gray-700 bg-gray-200 focus:bg-white border border-gray-200 focus:border-gray-500 rounded focus:outline-none" type="text" name="field-name" placeholder="Write a text">
            </div>
<%--            <tiles:insertAttribute name="header" />--%>
<%--            <tiles:insertAttribute name="menu" />--%>
            <tiles:insertAttribute name="body" />
<%--            <tiles:insertAttribute name="footer" />--%>
            <section class="py-12 px-4">
                <div class="flex flex-wrap -mx-4">
                    <div class="w-full lg:w-1/2 px-4 mb-8 lg:mb-0">
                        <div class="flex flex-col h-full p-8 bg-gray-200 rounded">
                            <h2 class="text-3xl font-heading">Dunder Friends, a.k.a Companies Who Work With Us</h2>
                            <p class="max-w-sm mt-auto mb-8 text-gray-500 leading-relaxed">We don’t believe in paperless future - so do our Customers.</p>
                            <a class="text-right text-blue-700 hover:underline" href="#">View all Dunder Mifflin customers</a>
                        </div>
                    </div>
                    <div class="lg:w-1/2 px-4">
                        <div class="flex flex-wrap -m-2">
                            <div class="w-1/2 p-2"><img class="rounded shadow-md" src="/placeholders/pictures/office.jpg" alt=""></div>
                            <div class="w-1/2 p-2"><img class="rounded shadow-md" src="/placeholders/pictures/work.jpg" alt=""></div>
                            <div class="w-1/2 p-2"><img class="rounded shadow-md" src="/placeholders/pictures/work.jpg" alt=""></div>
                            <div class="w-1/2 p-2"><img class="rounded shadow-md" src="/placeholders/pictures/office.jpg" alt=""></div>
                        </div>
                    </div>
                </div>
            </section>

            <footer class="flex flex-wrap items-center justify-between p-4">
                <div class="w-full lg:w-auto lg:mr-6 mb-4 lg:mb-0 text-center">&copy; 2020 Dunder Mifflin</div>
                <div class="flex flex-col lg:flex-row items-center w-full lg:w-auto">
                    <div class="mx-auto lg:mx-0 lg:ml-auto"><a class="inline-block mt-0 text-blue-900 hover:text-blue-700" href="#">Products</a><a class="inline-block mt-0 ml-8 text-blue-900 hover:text-blue-700" href="#">Team</a><a class="inline-block mt-0 ml-8 text-blue-900 hover:text-blue-700" href="#">Customers</a></div>
                    <div class="flex justify-center mt-4 lg:mt-0 lg:ml-8"><img class="w-6 h-6 mr-6" src="/placeholders/icons/message.svg" alt=""><img class="w-6 h-6" src="/placeholders/icons/share.svg" alt=""></div>
                </div>
            </footer>
        </div>
        </body>
    </html>