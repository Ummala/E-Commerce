<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>About US</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="bootstrap/card.css">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body{
                background-image: url(images/bg.jpg) ; 
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
        </style>
    </head>
    <body class=" user-select-none">
        <%@include file="header.jsp" %>
        <header class="text-center py-5">
            <div class="container">
                <h1 class="font-weight-light">MEET THE TEAM</h1>
                <hr style="margin-top: -10px; width: 300px;border: 2px solid gold;" >
            </div>
        </header>
        <section class="team pb-5">
            <div class="container">
                <div class="row no-gutters">
                    <div class="col-md-4 col-sm-6 text-center">
                        <div class="box">
                            <div class="d-flex justify-content-center">
                                <div class="avtar">
                                    <img class="img-fluid" src="images/aboutus/shr.jpg">
                                </div>
                            </div>
                            <div class="box_content">
                                <h3 class="title">SHRUTI L G</h3>
                                <span class="post">CSE 7SEM</span>
                            </div>
                            <u1 class="icons">
                                <li><a href='#'><i class="fa fa-facebook"></i></a></li>
                                <li><a href='#'><i class="fa fa-twitter"></i></a></li>
                                <li><a href='#'><i class="fa fa-linkedin-square"></i></a></li>
                            </u1>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 text-center">
                        <div class="box">
                            <div class="d-flex justify-content-center">
                                <div class="avtar">
                                    <img class="img-fluid" src="images/aboutus/santu.jpg">
                                </div>
                            </div>
                            <div class="box_content">
                                <h3 class="title">K C Santosh</h3>
                                <span class="post">CSE 7SEM</span>
                            </div>
                            <u1 class="icons">
                                <li><a href='#'><i class="fa fa-facebook"></i></a></li>
                                <li><a href='#'><i class="fa fa-twitter"></i></a></li>
                                <li><a href='#'><i class="fa fa-linkedin-square"></i></a></li>
                            </u1>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 text-center">
                        <div class="box">
                            <div class="d-flex justify-content-center">
                                <div class="avtar">
                                    <img class="img-fluid" src="images/aboutus/pooja.jpeg">
                                </div>
                            </div>
                            <div class="box_content">
                                <h3 class="title">POOJA P D</h3>
                                <span class="post">CSE 7SEM</span>
                            </div>
                            <u1 class="icons">
                                <li><a href='#'><i class="fa fa-facebook"></i></a></li>
                                <li><a href='#'><i class="fa fa-twitter"></i></a></li>
                                <li><a href='#'><i class="fa fa-linkedin-square"></i></a></li>
                            </u1>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 text-center">
                        <div class="box">
                            <div class="d-flex justify-content-center">
                                <div class="avtar">
                                    <img class="img-fluid" src="images/aboutus/vani.jpeg">
                                </div>
                            </div>
                            <div class="box_content">
                                <h3 class="title">VANISHRI V L</h3>
                                <span class="post">CSE 7SEM</span>
                            </div>
                            <u1 class="icons">
                                <li><a href='#'><i class="fa fa-facebook"></i></a></li>
                                <li><a href='#'><i class="fa fa-twitter"></i></a></li>
                                <li><a href='#'><i class="fa fa-linkedin-square"></i></a></li>
                            </u1>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 text-center">
                        <div class="box">
                            <div class="d-flex justify-content-center">
                                <div class="avtar">
                                    <img class="img-fluid" src="images/aboutus/asha.jpeg">
                                </div>
                            </div>
                            <div class="box_content">
                                <h3 class="title">ASHA P M</h3>
                                <span class="post">CSE 7SEM</span>
                            </div>
                            <u1 class="icons">
                                <li><a href='#'><i class="fa fa-facebook"></i></a></li>
                                <li><a href='#'><i class="fa fa-twitter"></i></a></li>
                                <li><a href='#'><i class="fa fa-linkedin-square"></i></a></li>
                            </u1>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 text-center">
                        <div class="box">
                            <div class="d-flex justify-content-center">
                                <div class="avtar">
                                    <img class="img-fluid" src="images/aboutus/aishu.jpeg">
                                </div>
                            </div>
                            <div class="box_content">
                                <h3 class="title">AISHWARYA B S</h3>
                                <span class="post">CSE 7SEM</span>
                            </div>
                            <u1 class="icons">
                                <li><a href='#'><i class="fa fa-facebook"></i></a></li>
                                <li><a href='#'><i class="fa fa-twitter"></i></a></li>
                                <li><a href='#'><i class="fa fa-linkedin-square"></i></a></li>
                            </u1>
                        </div>
                    </div>
                </div>   
            </div>
        </section>
        <%@include file="footer.html" %>
    </body>
</html>
