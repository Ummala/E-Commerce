<%@page contentType="text/html" session="true" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="bootstrap/css/bootstrap-grid.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <link rel="stylesheet" href="animate/animate.css"/>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <style>
            .form-control-plaintext
            {
                color: wheat;
                font-size: 1.2rem;
                margin-bottom: 8px;
            }
            #form > .form-control:focus ,.edit:focus
            {
                box-shadow: 0 0 10px 0.1rem rgba(0, 123, 255, 0.25) !important;
            }
            .form-control-plaintext:focus
            {
                outline: none;
            }
            .errors
            {
                box-shadow: 0 0 3px 0.1rem rgba(255, 0, 0, 0.35) !important;
            }
            .height
            {
                height: 70px;
            }
            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
            input[type=number] {
                -moz-appearance: textfield;
            }
            .error
            {
                color: red;
                width: auto;
            }
            #successpmsg,#errorpmsg,#changesuccess,#changeerror
            {
                height: 55px; auto ; 
            }
        </style>
    </head>
    <body class=" user-select-none" style="background-image: url(images/bg/7.jfif) ;background-repeat: no-repeat;background-attachment: fixed;background-size: cover;">
        <%@include file="header.jsp" %>
        <form method="post" action="" name="formupload" id="profileform">
            <div class="container-fluid">
                <div class="row vh-100 justify-content-center align-items-center">
                    <div class="col-xl-5 col-lg-6 col-md-10 col-sm-12 p-0">
                        <div class="card card-body shadow text-light" style="margin-top: -100px;background-color: black;">
                            <h2 class="text-warning d-flex ">Your Profile</h2>
                            <hr class="border border-success">
                            <div class="alert alert-success " style="display: none;" role="alert" id="successpmsg">
                                <p><i class="fal fa-shield-check"></i> Updated Successfully</p>
                            </div>
                            <div class="alert alert-warning" style="display: none;" role="alert" id="errorpmsg">
                                <p><i class="far fa-exclamation-triangle"></i> Something wents wrong</p>
                            </div>
                                    <table class="m-lg-2 h5">
                                        <tbody>
                                            <tr class="height">
                                                <td style="width: 30%;"><label for="fname">First Name</label></td>
                                                <td style="width: 70%;"><input type="text" required disabled id="fname" class="edit form-control-plaintext disabled" name="fname" value="<%=session.getAttribute("ufname") %>"></td>
                                            </tr>
                                            <tr class="height">
                                                <td><label for="lname">Last Name</label></td>
                                                <td><input type="text" required disabled id="lname" class="edit form-control-plaintext disabled" name="lname" value="<%=session.getAttribute("ulname") %>"></td>
                                            </tr>
                                            <tr class="height">
                                                <td><label for="email">E-mail</label></td>
                                                <td><input type="email" required disabled id="email" class="form-control-plaintext disabled" name="email" autocomplete="off" value="<%=session.getAttribute("uemail") %>"></td>
                                            </tr>
                                            <tr class="height">
                                                <td><label for="phone">Phone Number</label></td>
                                                <td><input type="text" required disabled id="phone" class="edit form-control-plaintext disabled" name="phone" autocomplete="off" value="<%=session.getAttribute("uphone") %>"></td>
                                            </tr>
                                            <tr class="height">
                                                <td><a class="text-decoration-none text-primary h4" href="#" data-toggle="modal" data-target="#staticBackdrop">Change Password</a></td>
                                            </tr>
                                    </tbody>
                                </table>
                            <div class="d-block">
                                <p><a id="edit" class="btn btn-info float-right text-uppercase text-light m-2">Edit</a></p>
                                <p><a id="update" style="display: none;" class="btn btn-primary float-right  m-2 text-uppercase text-light">Update Profile</a></p>
                                <p><a id="cancel" style="display: none;" class="btn btn-secondary float-right  m-2 text-uppercase text-light">Cancel</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" style="background-image: url(images/bg/7.jfif) ;background-repeat: no-repeat;background-attachment: fixed;background-size: cover; z-index: 2222222" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg  modal-dialog-centered" >
                    <div class="modal-content rounded-0 text-light" style="background-color: rgba(0,0,0,1); box-shadow: 0 0 80px 0 rgba(255, 255, 255, 1) !important; ">
                        <div class="modal-header">
                            <h5 class="modal-title" id="staticBackdropLabel">Change Password</h5>
                            <button type="button" class="close text-light" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="alert alert-success" style="display: none;" role="alert" id="changesuccess">
                                <p><i class="fal fa-shield-check"></i>  Password changed Successfully.</p>
                            </div>
                            <div class="alert alert-warning" style="display: none;" role="alert" id="changeerror">
                                <p><i class="far fa-exclamation-triangle"></i><span id="warningmsg"> Something went's wrong.</span></p>
                            </div>
                            <div id="form">
                                <label for="opass" class="mt-3">Current Password</label>
                                <input tabindex="10" type="password" required class="form-control" name="opass" autocomplete="off" placeholder="Enter Current Password" id="opass"><br>
                                <label for="npass" class="mt-3">New Password</label>
                                <input tabindex="11" type="password" required class="form-control" name="npass" autocomplete="off" placeholder="Enter New Password" id="npass"><br>
                                <label for="cpass" class="mt-3">Confirm Password</label>
                                <input tabindex="12" type="password" required class="form-control" name="cpass" autocomplete="off" placeholder="Confirm Password" id="cpass"><br>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <p><a id="changepassword" tabindex="13" class="btn btn-info float-right text-uppercase text-light m-2">Change Password</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <%@include file="footer.html" %>
        <script src="javascript/js.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.bundle.js" type="text/javascript"></script>
        <script src="validate/validate.js" type="text/javascript"></script>
        <script>
            $(document).ready(function (){
                jQuery.validator.addMethod("emails", function (value, element) 
                {
                        return /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(value.trim());
                }, "&nbsp&nbspEnter valid email id.");

                jQuery.validator.addMethod("numbers", function (value, element) {
                    return /^[6789][0-9]{9}$/.test(value.trim());
                }, "&nbsp&nbspEnter valid mobile number.");
                var fname,lname,email,phone;
                $("#edit").click(function ()
                {
                    $(".edit").removeClass("form-control-plaintext disabled");
                    $(".edit").addClass("form-control");
                    $(".edit").removeAttr("disabled");
                    $("#edit").hide();
                    $("#update").show();
                    $("#cancel").show();
                    fname = $("#fname").val();
                    lname = $("#lname").val();
                    email = $("#email").val();
                    phone = $("#phone").val();
                });
                $("#update").click(function (){
                    
                    var r = validateform();
                    if(r === true)
                    {
                        var fn = $("#fname").val();
                        var ln = $("#lname").val();
                        var em = $("#email").val();
                        var ph = $("#phone").val();
                        if(fn===fname && ln === lname && em === email && ph == phone)
                        {
                            $(".edit").addClass("form-control-plaintext disabled");
                            $(".edit").removeClass("form-control");
                            $(".edit").attr("disabled",true);
                            $("#edit").show();
                            $("#update").hide();
                            $("#cancel").hide();
                        }
                        else
                        {
                            $.ajax({
                                url: "addressajax",
                                type: 'POST',
                                data: "editprofile=yes&fname="+fn+"&lname="+ln+"&email="+em+"&phone="+ph,
                                success: function (data) 
                                {
                                    if(data!="fail")
                                    {
                                        $(".edit").addClass("form-control-plaintext disabled");
                                        $(".edit").removeClass("form-control");
                                        $(".edit").attr("disabled",true);
                                        $("#edit").show();$("#update").hide();$("#cancel").hide();
                                        $("#successpmsg").slideDown()
                                        var s = setTimeout(hide,5000);
                                        function hide()
                                        {
                                            $("#successpmsg").slideUp();
                                            clearTimeout(s);
                                        }
                                        $("#fname").val(fn);
                                        $("#lname").val(ln);
                                        $("#email").val(em);
                                        $("#phone").val(ph);
                                    }
                                    else
                                    {
                                        $(".edit").addClass("form-control-plaintext disabled");
                                        $(".edit").removeClass("form-control");
                                        $(".edit").attr("disabled",true);
                                        $("#edit").show();$("#update").hide();$("#cancel").hide();
                                        $("#errorpmsg").slideDown();
                                        $("#fname").val(fname);
                                        $("#lname").val(lname);
                                        $("#email").val(email);
                                        $("#phone").val(phone);                                    
                                    }
                                }
                            });
                        }
                    }
                });
                $("#cancel").click(function ()
                {
                    $(".edit").addClass("form-control-plaintext disabled");
                    $(".edit").removeClass("form-control");
                    $(".edit").attr("disabled",true);
                    $(".form-control-plaintext").removeClass("errors");
                    $(".error").hide();
                    $("#edit").show();
                    $("#update").hide();
                    $("#cancel").hide();
                    $("#fname").val(fname);
                    $("#lname").val(lname);
                    $("#email").val(email);
                    $("#phone").val(phone);
                });  
                $("#changepassword").click(function (){
                    var r = validateform();
                    if(r === true)
                    {
                        $("#changepassword").attr("disabled",true);
                        $("#changepassword").html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Please wait');
                        var o = $("#opass").val();
                        var n = $("#npass").val();
                        var c = $("#cpass").val();
                        $.ajax({
                           url: "addressajax",
                           type: 'POST',
                           data: "changepasswords=yes&opass="+o+"&npass="+n+"&cpass="+c,
                           success: function (data1) 
                            {
                               if(data1=='{"status":"fail"}1')
                               {
                                   $("#changeerror").slideDown();
                                   $("#warningmsg").html(" Incorrect old password");
                                   var s = setTimeout(hide,5000);
                                    function hide()
                                    {
                                        $("#changeerror").slideUp();
                                        clearTimeout(s);
                                    }
                                    $("#opass").val("");
                                    $("#npass").val("");
                                    $("#cpass").val("");
                                    $("#changepassword").removeAttr("disabled");
                                    $("#changepassword").html("CHANGE PASSWORD");
                               }
                               else
                               if(data1=='{"status":"fail"}3')
                                {
                                    $("#changeerror").slideDown();
                                    $("#warningmsg").html(" Password not been Updated");
                                    var s = setTimeout(hide,5000);
                                    function hide()
                                    {
                                        $("#changeerror").slideUp();
                                        clearTimeout(s);
                                    }
                                    $("#opass").val("");
                                    $("#npass").val("");
                                    $("#cpass").val("");
                                    $("#changepassword").removeAttr("disabled");
                                    $("#changepassword").html("CHANGE PASSWORD");
                                }
                               else
                               if(data1=='{"status":"fail"}0')
                                {
                                    $("#changesuccess").slideDown();
                                    var s = setTimeout(hide,5000);
                                    function hide()
                                    {
                                        $("#changesuccess").slideUp();
                                        clearTimeout(s);
                                    }
                                    $("#opass").val("");
                                    $("#npass").val("");
                                    $("#cpass").val("");
                                    $("#changepassword").removeAttr("disabled");
                                    $("#changepassword").html("CHANGE PASSWORD");
                                }
                               else
                               if(data1=='{"status":"fail"}2')
                                {
                                    $("#changeerror").slideDown();
                                    $("#warningmsg").html(" Something wrong in new password");
                                    var s = setTimeout(hide,5000);
                                    function hide()
                                    {
                                        $("#changeerror").slideUp();
                                        clearTimeout(s);
                                    }
                                    $("#opass").val("");
                                    $("#npass").val("");
                                    $("#cpass").val("");
                                    $("#changepassword").removeAttr("disabled");
                                    $("#changepassword").html("CHANGE PASSWORD");
                                }
                            }
                        });
                    }
                });
            });
        </script>
        <script>
            function validateform()
            {
                var forms = $("#profileform");
                forms.validate({
                errorElement: 'span',
                errorClass: 'error',
                highlight: function (element, errorClass, validClass) {
                    $(element).closest('.form-control').addClass("errors");
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).closest('.form-control').removeClass("errors");
                },
                rules: {
                    fname: {
                        required: true,
                    },
                    lname: {
                        required: true,
                    },
                    email: {
                        required: true,
                        emails:true
                    },
                    phone: {
                        required: true,
                        numbers:true
                    },
                    opass:
                    {
                        required:true,
                        minlength:6,
                        maxlength:25
                    },
                    npass:{
                        required:true,
                        minlength:6,
                        maxlength:25
                    },
                    cpass:{
                        required:true,
                        minlength:6,
                        equalTo:"#npass",
                        maxlength:25
                    }
                },
                messages:
                {
                    fname: {
                            required: "Enter First Name",
                        },
                        lname: {
                            required: "Enter Last Name",
                        },
                        email: {
                            required: "Enter email ID",
                            emails:"Enter valid mail ID"
                        },
                        phone: {
                            required: "Enter phone number",
                            numbers:"Enter valid phone number"
                        },
                        opass:
                        {
                            required:"Enter your password",
                            minlength:"Enter correct password",
                            maxlength:"Enter correct password"
                        },
                        npass:{
                            required:"Enter new password",
                            minlength:"Password must be 6 characters Long",
                            maxlength:"Password Don't excides 25 characters"
                        },
                        cpass:{
                            required:"Enter Confirm password",
                            minlength:"Password must be 6 characters Long",
                            maxlength:"Password Don't excides 25 characters",
                            equalTo:"Missmatch password"
                        }
                }
            });
            return forms.valid();
            }
        </script>
    </body>
</html>
