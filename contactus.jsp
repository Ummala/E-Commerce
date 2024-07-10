<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
        <style>
            body{
                background-image: url(images/bg/8.png) ; 
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
        </style>
        <style>
            .w3-input
            {
                outline: none;
            }
            body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", sans-serif}
            .error{color:red;}
        </style>
    </head>
    <body class=" user-select-none">
        <%@include file="header.jsp" %>
        <div class="container-fluid">
            <div class="row justify-content-center m-5 align-items-center">
                <div class="col-xl-5 col-mg-8 col-sm-9">
                    <div class="w3-container w3-padding-large w3-black p-5 shadow" style="border-radius: 10px;">
                        <h4 id="contact"><b>Contact Us</b></h4>
                        <div class="w3-row-padding w3-center w3-padding-24 pt-3" style="margin:0 -16px">
                            <div class="w3-third w3-dark-grey">
                                <p><br><i class="fa fa-envelope w3-xxlarge w3-text-light-grey"></i></p>
                                <p>dressland@gmail.com</p>
                            </div>
                            <div class="w3-third w3-teal">
                                <p><br><i class="fal fa-map-marker-alt w3-xxlarge w3-text-light-grey"></i></p>
                                <p>Karnataka, INDIA</p>
                            </div>
                            <div class="w3-third w3-dark-grey">
                                <p><br><i class="fa fa-phone w3-xxlarge w3-text-light-grey"></i></p>
                                <p>8095616293</p>
                            </div>
                        </div>
                        <hr class="w3-opacity">
                        <form action="page?name=contact" method="post" id="form">

                            <div class="w3-row w3-section">
                                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
                                <div class="w3-rest">
                                    <input class="w3-input w3-border" name="fname" type="text" placeholder="First Name" required>
                                </div>
                            </div><br>


                            <div class="w3-row w3-section">
                                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
                                <div class="w3-rest">
                                    <input class="w3-input" name="lname" type="text" placeholder="Last Name" required>
                                </div>
                            </div><br>

                            <div class="w3-row w3-section">
                                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fas fa-envelope-open"></i></div>
                                <div class="w3-rest">
                                    <input class="w3-input w3-border" name="email" type="text" placeholder="Email" required>
                                </div>
                            </div><br>

                            <div class="w3-row w3-section">
                                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-phone"></i></div>
                                <div class="w3-rest">
                                    <input class="w3-input w3-border" name="phone" type="text" placeholder="Phone" required="">
                                </div>
                            </div><br>

                            <div class="w3-row w3-section">
                                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-pencil"></i></div>
                                <div class="w3-rest">
                                    <textarea class="w3-input w3-border" name="message" placeholder="Message" required rows="3"></textarea>
                                </div>
                            </div><br>

                            <button type="submit" class="w3-button ml-5 w3-dark-gray w3-margin-bottom- " name="contactus"><i class="fa fa-paper-plane w3-margin-right"></i>Send Message</button>
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
    <script src="validate/validate.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    <script>   
        <%
            if(request.getAttribute("success")!=null)
            {
                %>
                    showSwal('success-message');
                <%
            }
            if(request.getAttribute("error")!=null)
            {
                %>
                    showSwal('error-message');
                <%
            }
        %>
            function showSwal(type) 
            {
                'use strict';
                if (type === 'success-message') {
                swal({
                    title: 'Thank You',
                    text: 'Our team will contact you soon.',
                    type: 'success',
                    button: {
                        text: "Continue",
                        value: true,
                        visible: true,
                        className: "btn btn-primary"
                    }
                })
                }
                else 
                if(type === 'error-message')
                {
                    swal({
                        title: 'Sorry..!!!',
                        text: 'you already submitted the data before. We will contact you soon.',
                        type: 'error',
                        button: {
                            text: "Continue",
                            value: true,
                            visible: true,
                            className: "btn btn-primary"
                        }
                    })
                }
            }(jQuery);
    </script>
    <script>
        $(document).ready(function () {
            jQuery.validator.addMethod("email1", function (value, element) {
                return /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(value.trim());
            }, "Enter valid email id.");
            jQuery.validator.addMethod("number", function (value, element) {
                return /^[6789][0-9]{9}$/.test(value.trim());
            }, "Enter valid mobile number.");
            $("#form").validate({
                errorPlacement: function (error, element) 
                {
                    if (element.is(":radio"))
                    {
                        error.appendTo(element.parents("#radioset"));
                    } else
                    {
                        error.insertAfter(element);
                    }
                },
                ignore: [],
                rules:
                {
                    fname: {
                        required: true
                    },
                    lname: {
                        required: true
                    },
                    email: {
                        required: true,
                        email1:true
                    },
                    phone: {
                        required: true,
                        number: true
                    },
                    message: {
                        required: true
                    }
                },
                messages:
                {
                    fname: {
                        required: "First name is Required"
                    },
                    lname: {
                        required: "Last name is required"
                    },
                    email: {
                        required: "Enter yout E-mail",
                        email: "Please Enter valid E-mail"
                    },
                    phone: {
                        required: "Enter your Phone number"
                    },
                    message: {
                        required: "write something"
                    }

                }
            });
        });
    </script>            
</html>


