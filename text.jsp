<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
    <head>
        <title>ajax file upload</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="bootstrap/css/bootstrap-grid.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    </head>
    <body>
        <div class="container">
            <div style="display: none;" id="imgcontainer">
                <img class="img-fluid" id="ajaximg">
            </div>
            <input class="mt-5 m-5 form-control" onchange="fileupload()" type="file" name="files" id="files">
            <button class="btn btn-primary" type="button" onclick="fileupload()">Upload a file</button>
        </div>
        <script src="javascript/js.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.bundle.js" type="text/javascript"></script>
        <script>
            function fileupload()
            {
                var fd = new FormData();
                var files = $('#files')[0].files;
                if(files.length > 0 )
                {
                   fd.append('file',files[0]);
                   $.ajax(
                    {
                        url: 'test',
                        type: 'post',
                        data: fd,
                        contentType: false,
                        processData: false,
                        success: function(response)
                        {
                            if(response!="fail")
                            {
                                $('#ajaximg').attr('src', response);
                                var checkstatus = true;
                                while(checkstatus)
                                {
                                    var ss = imageExists("http://localhost:8084/itemdelivery/"+response);
                                    console.log(ss);
                                    if(ss==true)
                                    {
                                        checkstatus = false;
                                    }
                                    else
                                    {
                                        checkstatus = true;
                                    }
                                    console.clear();
                                }
                                $("#imgcontainer").slideDown();
                            }
                        }
                    });
                }
                else
                {
                   alert("Please select a file.");
                }
            }
            function imageExists(image_url)
            {
                var http = new XMLHttpRequest();
                http.open('HEAD', image_url, false);
                http.send();
                return  http.status != 404;
            }
        </script>
    </body>
</html>