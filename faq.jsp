<!DOCTYPE html>
<html>
    <head>
        <title>FAQ's</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="jqueryui/jquery-ui.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <style>
            body{
                background-image: url(images/bg/7.jfif) ;
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
            .ui-accordion .ui-accordion-header {
                outline: 0 !important;
            }
        </style>
        <style>
            .ui-icon
            {
                float: right !important;
                margin-top: 5px;
                
            }
            .ui-accordion-header
            {
                font-size: 20px !important;
            }
        </style>
    </head>
    <body class=" user-select-none">
    <%@include file="header.jsp" %>
    <div class="container-fluid">
        <div class="row m-5 justify-content-center align-items-center">
            <div class="col-xl-10 col-lg-8 col-md-8 col-sm-12">
                <div id="accordion">
                    
                </div>
            </div>
        </div>
    </div>
    <%@include file="footer.html" %>
    <script src="javascript/js.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.bundle.js" type="text/javascript"></script>
    <script src="jqueryui/jquery-ui.js" type="text/javascript"></script>
    <script>
        function loadfaq() {
          $( "#accordion" ).accordion({
            animate: 400,
            collapsible: true,
            heightStyle: "content",
            active:"none",
            icons: { "header": "ui-icon-plusthick", "activeHeader": "ui-icon-minusthick" }
          });
        }
    </script>
    <script>
        $(document).ready(function (){
           $.ajax({
               url: "loadajax",
               data: "type=faqs",
               type: 'POST',
               dataType: 'json',
               success: function (data) 
                {
                    if(data.r)
                    {
                        var s = '';
                        $.each(data.r,function (k, value){
                            s = s + '<h2 class="mt-3">'+value.q+'</h2>';
                            s = s + '<div><p>'+value.a+'</p></div>';
                        });
                        $("#accordion").append(s);
                        loadfaq();
                    }
                }
           });
        });
    </script>
    </body>
</html>
