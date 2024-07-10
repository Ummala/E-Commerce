<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="bootstrap/css/bootstrap-grid.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="jqueryui/jquery-ui.css"/>
        
    </head>
    <body class="">
        <div class="container">
            <div class="row justify-content-center align-items-center">
                <div class="col-xl-10 col-lg-9 col-md-8 cox-sm-12 p-0">
                    <div class="card card-body shadow-lg" id="login">
                        <form action="kc" enctype="multipart/form-data" method="post">
                            <input type="file" name="file1" >
                            <input type="file" name="file2" >
                            <input type="file" name="file3" >
                            <input type="submit" name="fileupload">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <img class="img_01" src="images/ 1.jpg" />

        <div id="gallery_01">

            <a href="#" data-image="images/ 2.jpg" data-zoom-image="images/ 2.jpg">
                <img class="img_01" src="images/ 2.jpg"/>
            </a>

            <a href="#" data-image="images/ 3.jpg" data-zoom-image="images/ 3.jpg">
                <img class="img_01" src="images/ 3.jpg"/>
            </a>
        </div>
        
        
        <script src="javascript/js.js" type="text/javascript"></script>
        <script src="validate/validate.js" type="text/javascript"></script>
        <script src="jqueryui/jquery-ui.js"></script>
        <script src="zoom/zoom.js" type="text/javascript"></script>
        <script>
            $('.img_01').bind('click', function (e) {
                var ez = $('.img_01').data('ezPlus');
                $.fancyboxPlus(ez.getGalleryList());
                return false;
            });
            
            $(".img_01").ezPlus({
                zoomWindowHeight:800,
                mantainZoomAspectRatio: true,
                maxZoomLevel: 10,
                gallery: 'gallery_01',
                zoomWindowWidth:400,
                borderSize:1,
                scrollZoom:true,
                responsive:true,
                loadingIcon:true,
                easing:true,
                lensShape:"round",
                lenszoom:true,
                tint:true,
                tintOpacity:0.2
            });
        </script>
    </body>
</html>