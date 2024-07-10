<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
    <head>
        <title>Forgetton Password</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="jqueryui/jquery-ui.css">
        <link href="animate/animate.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <style>
            body
            {
                background-image: url(images/bg/8.png) ;
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
        </style>
        <style>
            .black
            {
                background-color: black !important;
                box-shadow: 0 0 48px white;
            }
            .error
            {
                color: red;
            }
        </style>
    </head>
    <body class=" user-select-none">
        <%@include file="header.jsp" %>
        <div class="vh-100">
            <div class="container-fluid">
                <div class="d-flex row vh-100 justify-content-center align-items-center" style="margin-top: -70px">
                    <div class="col-xl-4 col-md-5 col-sm-12">
                        <div class="card card-body bg-light black rounded-lg">
                            <div class="alert alert-success alert-dismissible fade show" role="alert" style="display: none;">
                                Reset link as been sent to your email... <a href="page?name=login" class="alert-link">Back to Login</a>.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="alert alert-warning alert-dismissible fade show" role="alert" style="display: none;">
                                You don't have an account on this email please try again !!! <a href="page?name=login" class="alert-link"> Back to Login</a>.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <h1 class="d-flex text-info p-2 h2 justify-content-lg-end">Reset Your password</h1><hr class="border border-warning">
                            <form id="myform" method="post">
                                <label for="email" class="text-light mt-3">E-Mail</label>
                                <input type="email" name="email" id="email" placeholder="Enter your Email" autocomplete="off" autofocus class="form-control form-control-lg" required><br>
                                <button type="submit" name="submit" value="Reset Password" class="btn btn-lg btn-info btn-block mt-4 mb-5 text-uppercase submitbtn">Reset Password</button><hr class="border border-warning">
                            </form>
                            <p class="text-light">Back to Login <a href="page?name=login" class="text-decoration-none text-secondary font-weight-bold">Click here</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.html" %>
    </body>
    <script src="javascript/js.js"></script>
    <script src="bootstrap/js/bootstrap.bundle.js"></script>
    <script src="bootstrap/js/bootstrap.js"></script>
    <script src="jqueryui/jquery-ui.js"></script>
    <script src="validate/validate.js"></script>
    <script>
        var form = $("#myform");
        $(document).ready(function (){
        jQuery.validator.addMethod("email", function (value, element) 
        {
            return /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(value.trim());
        }, "Enter valid email id.");
            form.validate({
                rules: {
                    email: {
                        required: true
                    }
                },
                messages: {
                    email: {
                        required: "Enter your email"
                    }
                }
            });
        });
        $(".submitbtn").on('click',function (){
           if(form.valid()==true)
           {
               $(".submitbtn").html('<span class="spinner-border spinner-border-lg" role="status" aria-hidden="true"></span> Please wait');
           }
        });
    </script>
    <%
        String invalidemail = null;
        String validemail = null;
        try {
            invalidemail = (String) request.getAttribute("erroremail");
            validemail = (String) request.getAttribute("validemail");
            if (validemail ==("yes")) {
    %>
    <script>
        $(document).ready(function () {
            var times = setTimeout(kc1, 25000);
            $(".alert-success").slideDown();
            function kc1()
            {
                $(".alert-success").slideUp();
                clearTimeout(times);
            }
        });
    </script>
    <%
        }
        if (invalidemail ==("yes")) {
    %>


    <script>
        $(document).ready(function () {
            var time = setTimeout(kc, 25000);
            $(".alert-warning").slideDown();
            function kc()
            {
                $(".alert-warning").slideUp();
                clearTimeout(time);
            }
        });
    </script>


    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</html>
