<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reset Your Password</title>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
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
        .vh-90{
            height: 90vh;
        }
        .error
        {
            color: red;
        }
    </style>
</head>

<body class=" user-select-none">
    <%@include file="header.jsp" %>
    <div class="container-fluid">
        <div class="row d-flex vh-90 justify-content-center align-items-center">
            <div class="col-xl-4 col-lg-4 col-md-5 col-sm-12">
                <div class="card card-body p-3 shadow text-light p-4" style="background-color: black;">
                    <%
                        String success = (String) request.getAttribute("success");
                        String fail = (String) request.getAttribute("fail");
                        if(fail!=null)
                        {
                    %>
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <%=fail%>
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    <%
                        }
                        if(success!=null)
                        {
                    %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <%=success%>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <%
                        }
                    %>
                    <h1 class="d-flex justify-content-lg-end text-warning">Reset Your Password</h1>
                    <hr class="border border-warning">
                    <form action="page?name=reset" method="post">
                        <label for="password">Enter Password</label>
                        <input type="password" name="password" id="password" placeholder="Enter your password" class="form-control"><br>
                        <label for="cpassword">Confirm Password</label>
                        <input type="password" name="cpassword" id="cpassword" class="form-control" placeholder="Confirm your password"><br>
                        <input type="submit" name="changepassword" class="btn btn-info mt-2" value="Reset">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="footer.html" %>
    <script src="javascript/js.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <script src="validate/validate.js" type="text/javascript"></script>
    <script>
        $("form").validate({
            rules:{
                password:{
                    required:true,
                    minlength:6,
                    maxlength:25
                },
                cpassword:{
                    required:true,
                    minlength:6,
                    maxlength:25,
                    equalTo:"#password"
                }
            },
            messages:
            {
                password:{
                        required:"Please Enter your password.",
                        minlength:"Minimum length should be 6 Characters.",
                        maxlength:"Maximum length should be 25 Characters."
                    },
                cpassword:{
                    required:"Please Enter your password.",
                    minlength:"Minimum length should be 6 Characters.",
                    maxlength:"Maximum length should be 25 Characters.",
                    equalTo:"Miss Match Password."
                }
            }
        });
    </script>
</body>
</html>