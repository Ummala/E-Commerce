<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="comm.classes.filelocation"%>
<%@page import="comm.classes.connection"%>
<%@page import="java.util.concurrent.Phaser"%>
<%@page contentType="text/html" session="true" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home | Welcome</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="bootstrap/css/bootstrap-grid.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
        <link rel="stylesheet" href="corosel/dist/assets/owl.carousel.css" />
        <link rel="stylesheet" href="corosel/dist/assets/owl.theme.default.css" />
        <style>
            body{
                background-image: url(images/bg/8.png) ; 
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
                
            }
        </style>
        <style>
            
            .owl-next,.owl-next:hover ,owl-next:focus{
                width: 100px;
                font-size: 25px !important;
                border: none !important;
                color: black !important;
                background: lightblue !important;
            }

            .owl-prev,.owl-prev:hover 
            {
                width: 100px;
                font-size: 25px !important;
                color: black !important;
                background: lightblue !important;
            }
            .owl-item
            {
                cursor: pointer;
            }
            .card
            {
                border-radius: 0px;
                overflow: visible;
                transition: 0.5s;
                border: none;
                z-index: 22 !important;
            }
            .item .card:hover{
                transform: scale(1.12);
            }
            .owl-stage{
                padding: 20px;
            }
            .owl-stage-outer{
                height: auto !important;
            }
            .owl-nav{
                opacity: 0;
                transition: 1s;
            }
            .owl-theme .owl-nav .disabled{
                cursor: not-allowed !important;
            }
            .coroselbody{
                width: 90%; margin: auto; background-color: white;
            }
            .height
            {
                height: 90vh;
                width: auto;
            }
            img{
                z-index: 10000;
                overflow: visible;
                position: static;
            }
            @media screen and (min-width: 300px)
            {
                .height{
                    height:25vh !important;
                }
            }
            @media screen and (min-width: 400px)
            {
                .height{
                    height: 30vh !important;
                }
            }
            @media screen and (min-width: 500px)
            {
                .height{
                    height: 50vh !important;
                }
            }
            @media screen and (min-width: 800px)
            {
                .height{
                    height: 60vh!important;
                }
            }
            @media screen and (min-width: 900px)
            {
                .height{
                    height: 60vh!important;
                }
            }
            @media screen and (min-width: 1000px)
            {
                .height{
                    height: 60vh !important;
                }
            }
            @media screen and (min-width: 1100px)
            {
                .height{
                    height: 80vh !important;
                }
            }
            @media screen and (min-width: 1200px)
            {
                .height{
                    height: 90vh !important;
                }
            }
            .item{
                z-index: 1 !important;
            }
        </style>
    </head>
    <body class="bg-light user-select-none">
        <%@include file="header.jsp" %>
        <%                    
            connection con = new connection();
            String type = "main";
            int i = 1;
            ArrayList<filelocation> file = con.getloc(type, con);
            if (file!=null &&file.size() > 0) 
            {
        %>
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner height">
                <%
                        Iterator<filelocation> itr = file.iterator();
                        while (itr.hasNext()) {
                            filelocation f = itr.next();
                %>
                <div class="carousel-item <% if (i == 1) { %>active<% i = 0;}%>">
                    <img src="<%=f.getlocation()%>" class="d-block w-100" alt="...">
                </div>
                <%
                        }
                %>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <%
            }
        %>
        <div id="women" class="font-weight-700 font6"></div>
        <div id="men" class="font-weight-700 font6"></div>
        <div id="kidboy" class="font-weight-700 font6"></div>
        <div id="kidgirl" class="font-weight-700 font6"></div>

        <%@include file="footer.html" %>
    </body>
    <script src="javascript/js.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.bundle.js" type="text/javascript"></script>
    <script src="validate/validate.js" type="text/javascript"></script>
    <script src="corosel/dist/owl.carousel.js" type="text/javascript"></script>
    <script>
        function women() {

            $(".women").owlCarousel({
                margin: 5,
                stagePadding: 2,
                padding: 5,
                smartSpeed: 500,
                padding:5,
                        responsive: {
                            0: {
                                items: 2,
                                nav: false,
                                dots: true,
                                slideBy: 2
                            },
                            250: {
                                items: 2,
                                nav: false,
                                dots: true,
                                slideBy: 3
                            },
                            650: {
                                items: 4,
                                nav: true,
                                dots: false,
                                slideBy: 2
                            },
                            950: {
                                items: 6,
                                nav: true,
                                dots: false,
                                slideBy: 4
                            },
                            1200:
                                    {
                                        items: 8,
                                        nav: true,
                                        dots: false,
                                        slideBy: 6
                                    },
                            1500:
                                    {
                                        items: 8,
                                        nav: true,
                                        dots: false,
                                        slideBy: 8
                                    }
                        }
            });
            same();
        }
        function kidboy() {

            $(".kidboy").owlCarousel({
                margin: 5,
                stagePadding: 2,
                padding: 5,
                smartSpeed: 500,
                padding:5,
                        responsive: {
                            0: {
                                items: 2,
                                nav: false,
                                dots: true,
                                slideBy: 2
                            },
                            250: {
                                items: 2,
                                nav: false,
                                dots: true,
                                slideBy: 3
                            },
                            650: {
                                items: 4,
                                nav: true,
                                dots: false,
                                slideBy: 2
                            },
                            950: {
                                items: 6,
                                nav: true,
                                dots: false,
                                slideBy: 4
                            },
                            1200:
                                    {
                                        items: 8,
                                        nav: true,
                                        dots: false,
                                        slideBy: 6
                                    },
                            1500:
                                    {
                                        items: 8,
                                        nav: true,
                                        dots: false,
                                        slideBy: 8
                                    }
                        }
            });
            same();
        }
        function kidgirl() {

            $(".kidgirl").owlCarousel({
                margin: 5,
                stagePadding: 2,
                padding: 5,
                smartSpeed: 500,
                padding:5,
                        responsive: {
                            0: {
                                items: 2,
                                nav: false,
                                dots: true,
                                slideBy: 2
                            },
                            250: {
                                items: 2,
                                nav: false,
                                dots: true,
                                slideBy: 3
                            },
                            650: {
                                items: 4,
                                nav: true,
                                dots: false,
                                slideBy: 2
                            },
                            950: {
                                items: 6,
                                nav: true,
                                dots: false,
                                slideBy: 4
                            },
                            1200:
                                    {
                                        items: 8,
                                        nav: true,
                                        dots: false,
                                        slideBy: 6
                                    },
                            1500:
                                    {
                                        items: 8,
                                        nav: true,
                                        dots: false,
                                        slideBy: 8
                                    }
                        }
            });
            same();
        }
        function men() {

            $(".men").owlCarousel({
                margin: 5,
                stagePadding: 2,
                padding: 5,
                smartSpeed: 500,
                padding:5,
                        responsive: {
                            0: {
                                items: 2,
                                nav: false,
                                dots: true,
                                slideBy: 2
                            },
                            250: {
                                items: 2,
                                nav: false,
                                dots: true,
                                slideBy: 3
                            },
                            650: {
                                items: 4,
                                nav: true,
                                dots: false,
                                slideBy: 2
                            },
                            950: {
                                items: 6,
                                nav: true,
                                dots: false,
                                slideBy: 4
                            },
                            1200:
                                    {
                                        items: 8,
                                        nav: true,
                                        dots: false,
                                        slideBy: 6
                                    },
                            1500:
                                    {
                                        items: 8,
                                        nav: true,
                                        dots: false,
                                        slideBy: 8
                                    }
                        }
            });
            same();
        }
    </script>
    <script>
        function same()
        {
            $(".owl-carousel").hover(
                    function () {
                        var a = $(window).width();
                        if (a < 650)
                        {

                        } else
                        {
                            $(".owl-nav", this).css({
                                opacity: "1",
                                tranform: "1s",
                                animationduration: "1s"
                            });
                        }
                    },
                    function () {
                        var a = $(window).width();
                        if (a < 650)
                        {

                        } else
                        {
                            $(".owl-nav", this).css("opacity", "0");
                        }
                    }
            );
        }
    </script>
    <script>
        $(document).ready(function () {
            $.ajax({
                url: "curosel",
                type: 'POST',
                async: false,
                data: "enter=yes&type=women",
                dataType: 'json',
                success: function (data)
                {
                    if (data.jsondata)
                    {
                        var d = '<div class="coroselbody mt-5 card shadow">\n\
                                    <p class="h3 mt-5 ml-5 mt-5 mb-5 text-primary">TRENDING WOMEN DRESSES</p>\n\
                                        <div class="owl-carousel owl-theme position-relative women " >';
                        var s = '';
                        $.each(data.jsondata, function (key, value) {
                            s = s + '<div class="item position-relative">\n\
                                                 <div class="card card-body" style="height:auto;">\n\
                                                     <img height="230" width="auto" src="' + value.filename + '"><p class="text-center mt-3 font-weight-bold">&#x20b9;'+Math.floor(Math.random() * 1000) + 1+'</p>\n\
                                                 </div>\n\
                                             </div>';
                        });
                        var b = d + s + "</div>\n\
                                    </div>";
                        $("#women").html(b);
                        women();
                    }
                }
            });
        });
        $(document).ready(function () {
            $.ajax({
                url: "curosel",
                type: 'POST',
                async: false,
                data: "enter=yes&type=kidboy",
                dataType: 'json',
                success: function (data)
                {
                    if (data.jsondata)
                    {
                        var d = '<div class="coroselbody mt-5 card shadow">\n\
                                    <p class="h3 mt-5 ml-5 mt-5 mb-5 text-primary">TRENDING KID DRESSES (BOY)</p>\n\
                                        <div class="owl-carousel owl-theme position-relative kidboy">';
                        var s = '';
                        $.each(data.jsondata, function (key, value) {
                            s = s + '<div class="item">\n\
                                                 <div class="card">\n\
                                                     <img height="230" width="auto" src="' + value.filename + '"><p class="text-center mt-3 font-weight-bold">&#x20b9;'+Math.floor(Math.random() * 1000) + 1+'</p>\n\
                                                 </div>\n\
                                             </div>';
                        });
                        var b = d + s + "</div>\n\
                                    </div>";
                        $("#kidboy").html(b);
                        kidboy();
                    }
                }
            });
        });
        $(document).ready(function () {
            $.ajax({
                url: "curosel",
                type: 'POST',
                async: false,
                data: "enter=yes&type=kidgirl",
                dataType: 'json',
                success: function (data)
                {
                    if (data.jsondata)
                    {
                        var d = '<div class="coroselbody mt-5 card shadow">\n\
                                    <p class="h3 mt-5 ml-5 mt-5 mb-5 text-primary">TRENDING KID DRESSES (GIRL)</p>\n\
                                        <div class="owl-carousel owl-theme position-relative kidgirl">';
                        var s = '';
                        $.each(data.jsondata, function (key, value) {
                            s = s + '<div class="item">\n\
                                                 <div class="card">\n\
                                                     <img height="230" width="auto" src="' + value.filename + '"><p class="text-center mt-3 font-weight-bold">&#x20b9;'+Math.floor(Math.random() * 2000) + 1+'</p>\n\
                                                 </div>\n\
                                             </div>';
                        });
                        var b = d + s + "</div>\n\
                                    </div>";
                        $("#kidgirl").html(b);
                        kidgirl();
                    }
                }
            });
        });
        $(document).ready(function () {
            $.ajax({
                url: "curosel",
                type: 'POST',
                async: false,
                data: "enter=yes&type=men",
                dataType: 'json',
                success: function (data)
                {
                    if (data.jsondata)
                    {
                        var d = '<div class="coroselbody mt-5  card shadow">\n\
                                    <p class="h3 mt-5 ml-5 mt-5 mb-5 text-primary">TRENDING MEN DRESSES</p>\n\
                                        <div class="owl-carousel owl-theme position-relative men">';
                        var s = '';
                        $.each(data.jsondata, function (key, value) {
                            s = s + '<div class="item">\n\
                                                 <div class="card">\n\
                                                     <img height="230" width="auto" src="' + value.filename + '"><p class="text-center mt-3 font-weight-bold">&#x20b9;'+Math.floor(Math.random() * 2000) + 1+'</p>\n\
                                                 </div>\n\
                                             </div>';
                        });
                        var b = d + s + "</div>\n\
                                    </div>";
                        $("#men").html(b);
                        men();
                    }
                }
            });
        });
    </script>

    <script>
        $(document).ready(function () {
            var t = setTimeout(fun, 5000);
            function fun() {
                $(".animate__animated").addClass("animate__zoomOutDown animate__slow");
            }
        });
    </script>
    <script>
        var i = 0;
        function ss() {
            console.log(i);
            i++;
        }
    </script>

</html>

