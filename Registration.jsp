<%@page contentType="text/html" session="true" isThreadSafe="true" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
    <head>
        <title>Registration Form</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="jqueryui/jquery-ui.css">
        <link href="animate/animate.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <style>
            body{
                background-image: url(images/bg/7.jfif) ;
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
        </style>
        <style>
            .error,.msg
            {
                color:red;
            }
        </style>
    </head>
    <body class="bg-dark user-select-none">
        <%@include file="header.jsp" %>
        <div class="container  mt-5 mb-5">
            <div class="row d-flex justify-content-center">
                <div class=" text-light col-xl-8 col-md-10 col-sm-12">
                    <div class="card card-body" style="background-color: black;border-radius: 18px;box-shadow: 0 0 44px white;">
                    <div class="alert alert-warning alert-dismissible fade show" role="alert" style="display: none;">
                        <strong><i class="fas fa-exclamation-triangle"></i>Sorry</strong> Account is already created on the given email Id <a href="page?name=forgettenpassword" class="alert-link">Re-Set Password</a> or <a href="page?name=login" class="alert-link">Back to login</a>.
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="alert alert-success alert-dismissible fade show" role="alert" style="display: none;">
                        <strong><i class="far fa-check-circle"></i> Success</strong> Account created. <a href="page?name=login" class="alert-link">Back to LOGIN page</a>.
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>                      
                        <h2 class="text-uppercase d-flex justify-content-lg-end text-info mt-2 ">SIGN UP HERE</h2><hr class="mb-4 border border-warning">
                        <form action="validateregister" method="post" id="myform">
                            <div class="form-row">
                                <div class="form-group col-md-6 mb-4">
                                    <label for="fname">First Name</label>
                                    <input type="text"  class="form-control" name="fname" placeholder="First Name" id="fname" required autofocus autocomplete="off">
                                </div>
                                <div class="form-group col-md-6 mb-4">
                                    <label for="lname">Last Name</label>
                                    <input type="text"  autocomplete="off" name="lname" class="form-control" required placeholder="Last Name" id="lname">
                                </div>
                            </div>
                            <div>
                                <label for="email">Email</label>
                                <input type="email" onkeyup="check(this.value)" id="email" class="form-control" name="email" placeholder="Enter Your E-mail" required autocomplete="off">                                
                                <label class="msg" style="display: none;">E-mail already Exist.</label>
                            </div><br>
                            <div>
                                <label for="phone">Phone Number</label>
                                <input type="text" id="phone" name="phone" class="form-control" placeholder="Phone Number" required autocomplete="off">
                            </div><br>
                            <div>
                                <label class="d-flex">Select Gender</label>
                                <div id="radioset" class="d-block">
                                    <input type="radio" name="gender" value="male" id="male" ><label for="male" class="font-weight-bold">Male</label>
                                    <input type="radio" name="gender" value="female" id="female" ><label for="female"  class="font-weight-bold">Female</label>
                                    <input type="radio" name="gender" value="other" id="other" ><label for="other" class="font-weight-bold">Others</label>
                                </div>
                            </div><br>
                            <div>
                                <label for="Password">Password</label>
                                <input type="password" id="Password" name="password" class="form-control" placeholder="Enter your password" required autocomplete="off">
                            </div><p class="text-left"><small class="text-muted justify-content-start">Password is case sensitive</small></p>
                            <br>
                            <div>
                                <label for="Confirm Password">Confirm password</label>
                                <input type="password" id="Re-Password" name="rpassword" class="form-control" placeholder="Re enter password" required autocomplete="off">
                            </div><br>
                            <input type="submit" class="btn btn-primary mt-3 btn-block rounded-pill btn text-uppercase" name="submitform" value="Register">
                            <hr class="border border-warning mt-4 mb-4">
                            <p>
                                Alredy have account? &nbsp<a href="page?name=login" class="text-decoration-none text-info font-weight-bold">Click Here</a>
                            </p>
                        </form>
                    </div>

                </div>
            </div>
        </div>
        <%@include file="footer.html" %>
    </body>
    <script src="javascript/js.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.bundle.js" type="text/javascript"></script>
    <script src="jqueryui/jquery-ui.js" type="text/javascript"></script>
    <script src="validate/validate.js" type="text/javascript"></script>
    <script>
        function check(data)
        {
            if(data.trim() == "" || data == null)
            {
                $(".msg").css("display","none");
            }
            else
            $.ajax({
               url: "addressajax",
               type: 'POST',
               data: "checkemail="+data,
               dataType: 'json',
               success: function (data) 
                {
                    if(data.status=="success")
                    {
                        $(".msg").css("display","block");
                    }
                    else
                    {
                        $(".msg").css("display","none");
                    }
                }
            });
        }
    </script>
    <script>
        $("#radioset").buttonset();
    </script>
            <%
                try
                {
                    String error = (String) session.getAttribute("regerror");
                    String success = (String) session.getAttribute("regsuccess");
                    session.setAttribute("regerror", "no");
                    session.setAttribute("regsuccess", "no");
                    String s = "yes";
                    if(error==(s))
                    {
            %>
                    <script>
                        $(document).ready(function()
                        {
                            $(".alert-warning").css("display","block");
                        });
                    </script>
            <%
                    }
                    if(success==(s))
                    {
            %>
                    <script>
                        $(document).ready(function()
                        {
                            $(".alert-success").css("display","block");
                        });
                    </script>
            <%
                    }
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
            %>
    
    <script>
        $(document).ready(function(){
        jQuery.validator.addMethod("email", function (value, element) 
        {
            return /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(value.trim());
        }, "Enter valid email id.");
        jQuery.validator.addMethod("number", function (value, element) {
            return /^[6789][0-9]{9}$/.test(value.trim());
        }, "Enter valid mobile number.");
        $("#myform").validate({
            errorPlacement: function(error, element) 
            {
                if(element.is(":radio"))
                {
                    error.appendTo(element.parents("#radioset"));
                }
                else
                {
                    error.insertAfter(element);
                }
            },
            ignore: [],
            rules:
            {
                fname:{
                    required:true,
                    minlength:3
                },
                lname:{
                    required:true,
                    minlength:3
                },
                email:{
                    required:true
                },
                phone:{
                    required:true,
                    number:true
                },
                gender:{
                    required:true
                },
                address:{
                    required:true
                },
                password:{
                    required:true,
                    minlength:6,
                    maxlength:25
                },
                rpassword: {
                    required: true,
                    minlength:  function() 
                                {
                                    var p = $("#Password").val();
                                    var q = $("#Re-Password").val();
                                    if(p==q)
                                    {
                                        return (p.length);
                                    }
                                    else
                                    {
                                        return (200);
                                    }
                                },
                    maxlength:150
                    
                }
            },
            messages:
            {
                fname:{
                    required:"First name is required",
                    minlength:"minimum of 3 characters"
                },
                lname:{
                    required:"Last name is required",
                    minlength:"minimum of 3 characters"
                },
                email:{
                    required:"Enter yout E-mail",
                    email:"Please Enter valid E-mail"
                },
                phone:{
                    required:"Enter your Phone number"
                },
                gender:{
                    required:"&nbsp&nbspSelect your Gender"
                },
                address:{
                    required:"Enter yout Home address",
                    minlength:"minimum of 6 characters"
                },
                password:{
                    required:"Enter your password",
                    minlength:"Your password must be at least 6 characters long",
                    maxlength:"maximum characters should be 25 characters"
                },
                rpassword:{
                    required:"Re-Enter Your Password",
                    minlength:"Miss-Match Passsword"
                }
            }
        });
        });
    </script>
</html>
