<%@page contentType="text/html" pageEncoding="UTF-8" %> 
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Login Page</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="jqueryui/jquery-ui.css">
        <link href="animate/animate.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <style>
            body
            {
                background-image: url(images/bg/7.jfif) ; 
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
            .error
            {
                color: red;
            }
            .login
            {
                margin-top: -80px !important;
            }
            .card1
            {
                background-color: black !important;
            }
            .dangers
            {
                background-color: #dc3545 !important;
            }
            .green
            {
                background-color: #28a745 !important;
            }
            @media (max-width: 766px) 
            {
                .santosh
                {
                    width: 50%;
                    height: auto;
                }
                .ss
                {
                    margin-top: -100px;
                    margin-bottom: 50px;
                }
            }
        </style>
    </head>
    <body class=" user-select-none">
        <%@include file="header.jsp" %>
        <div class="container-fluid vh-100">
            <div class="row vh-100 d-flex text-center justify-content-center align-items-center">
                <div class="col-xl-4 col-md-5 col-sm-12 login ss">  
                    <div class="alert text-left alert-success mb-5 alert-dismissible text-light p-4 m-2" style="display: none;" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="alert-heading"><i class="fas fa-exclamation-triangle"></i> Alert !!!</h4>
                        Invalid Login Id and Password
                    </div>
                    <div class="card card-body"  id="color" style="background-color: black; border-radius: 15px; box-shadow: 0 0 44px white; ">    
                        <h1 class="d-flex justify-content-lg-end mb-4 text-uppercase text-warning">Login</h1>           
                        <form id="kc" method="post" action="login">
                            <label for="name" class="text-light d-flex  justify-content-start">Email</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-dark text-white border-right-0" title="See yout password"><i class="fal fa-user"></i></span>   
                                </div>
                                <input type="email" tabindex="1" id="name" minlength="2" name="name" class="form-control d bg-dark text-white border-left-0" autocomplete="off"  required placeholder="Enter Your name">
                            </div><br>
                            <label for="pass" class="text-light d-flex  justify-content-start">Password</label>
                            <div class="input-group">
                                <div class="input-group-prepend pass" style="cursor: pointer;">
                                    <span class="input-group-text bg-dark text-white border-right-0"><i class="fal fa-eye"></i></span>    
                                </div>
                                <input type="password" tabindex="2" id="pass" name="password"  class="form-control d bg-dark text-white border-left-0" required placeholder="Enter Your Password">
                            </div>
                            <%! String s = null;%>
                            <%
                                try 
                                {
                                    s = (String) request.getAttribute("error");
                                } catch (Exception e) 
                                {
                                    e.printStackTrace();
                                }
                                if (s == "y") {
                            %>
                            <p class="text-light mt-3">
                                <a href="page?name=forgettenpassword" class="d-flex  justify-content-start text-uppercase text-danger text-decoration-none">forgot Password?</a>
                            </p>
                            <% } %>
                            <input type="submit" tabindex="3" class="btn btn-lg btn-primary btn mt-5 btn-block mb-2 text-uppercase text-center" name="submitlogin" value="Login">
                            <hr class="mt-5 border border-warning">
                        </form>
                        <div class="text-light text-center mt-1 no-text-decoration" id="color1">

                            <p class="float-left">
                                New User? <a href="page?name=register" class="text-uppercase font-weight-bold text-info text-decoration-none">Register Here</a>
                            </p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.html" %>
    <script src="javascript/js.js"></script>
    <script src="bootstrap/js/bootstrap.bundle.js"></script>
    <script src="bootstrap/js/bootstrap.js"></script>
    <script src="jqueryui/jquery-ui.js"></script>
    <script src="validate/validate.js"></script>
    <%
        try 
        {
            request.setAttribute("error", "no");
            String check = "y";
            if (s == check) 
            {
    %>
                <script>
                    $(document).ready(function ()
                    {
                        $(".alert").slideDown("slow");
                        $('.alert').addClass("dangers");
                        var alert = setTimeout(alertmethod, 25000);
                        function alertmethod()
                        {
                            $(".alert").slideUp();
                        }
                    });
                </script>
    <%      }
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        }
    %>
    <script>
        var a = true;
        var b = true;
        $(".pass").click(function () 
        {
            if (a == true)
            {
                $('#pass').attr('type', 'text');
                $(".pass i ").removeClass("fa-eye");
                $(".pass i ").addClass("fa-eye-slash");

                a = false;
            } 
            else
            {
                $('#pass').attr('type', 'password');
                $(".pass i ").removeClass("fa-eye-slash");
                $(".pass i ").addClass("fa-eye");
                a = true;
            }
        });
        $(".d").focus(function () 
        {
            $(this).animate({height: "50px"}, 200);
        });
        if($("#pass").val().trim()!="")
        {
            $("#pass").animate({height: "50px"}, 200);
        }
        if($("#name").val().trim()!="")
        {
            $("#name").animate({height: "50px"}, 200);
        }
        $(".form-control").blur(function () 
        {
            var b = $(this).val().trim();
            if (b === "")
            {
                $(this).animate({height: "38px"}, 200);
            }
        });
//        check();
//            function check()
//            {
//                var u=$("#name").val();
//                var p=$("#pass").val();
//                if(u.trim()=="" || p.trim()=="")
//                {
//                    $(".btn").prop( "disabled", true ).css("cursor","not-allowed");
//                }
//                else
//                {
//                    $(".btn").prop( "disabled", false ).css("cursor","pointer");  
//                }
//            } 
    </script>
    <script>

        $(document).ready(function () 
        {
            jQuery.validator.addMethod("email", function (value, element) 
            {
                return /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(value.trim());
            }, "&nbsp&nbspEnter valid email id.");

            var validator = $("#kc").validate({
                errorPlacement: function (error, element)
                {
                    $(element).closest("form").find("label[for='" + element.attr("id") + "']").append(error);
                },
                errorElement: "span",
                ignore: [],
                rules:
                {
                    name: 
                    {
                        required: true
                    },
                    password: 
                    {
                        required: true,
                        minlength: 6,
                        maxlength: 25
                    }
                },
                messages:
                {
                    name:
                    {
                        required: " &nbsp&nbsp(required)"
                    },
                    password:
                    {
                        required: " &nbsp&nbsp(required)",
                        minlength: " &nbsp&nbsp(Enter at least 6 Character)",
                        maxlength: "&nbsp&nbsp(maximum lenght is 25 characters)"
                    }
                }
            });
        });
    </script>
    </body>
</html>