<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%> 
<%@page import="java.sql.ResultSet"%>
<%@page import="comm.classes.connection"%>
<%@page contentType="text/html" session="true" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dress View</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/css/bootstrap-grid.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="jqueryui/jquery-ui.css" />
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <style>
        body
        {
            background-image: url(images/bg/7.jfif) ; 
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
        }
        .addtocartorbuy 
        {
            height: 70px;
            width: 300px;
            margin: 3px;
            border-radius: 0px;
            font-size: 25px;
        }
        .addtocartorbuy:focus 
        {
            border-color: transparent;
            box-shadow: none;
        }
        input[name="choosecolor"] 
        {
            display: none;
        }
        input[type="radio"]:checked+label 
        {
            border: 2px solid gold;
            padding: 2px;
            margin: 2px;
            overflow: visible;
        }
        input[type="radio"]:checked+label img
        {
            opacity: 1;
        }
        .highlight {
            background: black;
            color: white;
        }
        .form-control:focus {
            box-shadow: 0 0 9px 0.2rem rgb(0 123 255 / 36%);
        }
        .subimages
        {
            opacity: 0.8;
        }
    </style>
</head>

<body class=" user-select-none">
    <%@include file="header.jsp" %>
    <%!ResultSet images;%>
    <%
        String k=null;
        int itemid =0;
        connection con = new connection();
        String currentcolor = null;
        try
        {
            k = request.getParameter("itemid");
            if( k.trim().equals("") || k == null)
            {
                response.sendRedirect("index.jsp");
            }
            itemid = Integer.parseInt(k);
            try
            {
                session.setAttribute("buynowlogin", null);
                if( k != null || k =="" )
                {
                    itemid = Integer.parseInt(k);
                    session.setAttribute("itemids", itemid);
                }
                else
                {
                    if(session.getAttribute("itemids")!=null)
                    {
                        itemid =Integer.parseInt((String) session.getAttribute("itemids"));
                    }
                    else
                    {
                        request.getRequestDispatcher("/itemdelivery/").forward(request, response);
                    }
                }
            }
            catch(Exception e)
            {
                request.getRequestDispatcher("/itemdelivery/").forward(request, response);
            }

            
            currentcolor = request.getParameter("currentcolorcode");
            if(currentcolor == null)
            {
                currentcolor = "0";
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
            request.getRequestDispatcher("/itemdelivery/").forward(request, response);
        }
    %>
    <div class="container-fluid">
        <div class="row m-lg-5">
            <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12">
                <div class="row">
                    <%
                        String main_imgage = null;
                        if(currentcolor !="0")
                        {
                            ResultSet idcolor = con.getdetails(Integer.parseInt(currentcolor),"idcolor" ,con);
                            while(idcolor.next())
                            {
                                 images = con.getimagesofthecolor(itemid, idcolor.getString("color"), 10, con);
                            }
                        }
                        else
                        {
                            ResultSet single_color  = con.getdetails(itemid, "singleimage", con);
                            if(single_color.next())
                            {
                                String firstcolor = single_color.getString("color") ;
                                images = con.getimagesofthecolor(itemid, firstcolor, 10, con);
                            }
                        }
                        
                    %>
                    <div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 text-center pt-3">
                        <div id="imagegroup" class="bg-white">
                            <%
                                while(images.next())
                                {
                                    if(main_imgage == null)
                                    {
                                        main_imgage = images.getString("location");
                                    }
                            %>
                            <a href="#" data-image="<%=images.getString("location")%>" data-zoom-image="<%=images.getString("location")%>">
                                <img src="<%=images.getString("location")%>" class="img-fluid pt-3 p-1 " width="100">
                            </a>
                                    <%
                                }     
                            %>
                        </div>
                    </div>
                    <div class="col-xl-10 col-lg-10 col-md-10 col-sm-10 text-center">
                        <div class="p-3 mr-5 changeimage">
                            <%
                                if(main_imgage==null)
                                {
                                    request.getRequestDispatcher("").forward(request, response);
                                }
                            %>
                            <img src="<%=main_imgage %>"  id="image" style="width: 100%!important;">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12" id="subimage">
            <%
                ResultSet itemdetails = con.getdetails(itemid, "d", con);
                while(itemdetails.next())
                {
                    %>
                <form method="post" id="myform" action="orderplace">
                <div class="mt-5  ml-lg-5 ml-md-3">
                    <%
                        if(session.getAttribute("cartstatus")!=null)
                        {
                    %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <strong><i class="fal fa-check-circle"></i></strong> <%=session.getAttribute("cartstatus")%>.
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <%
                        session.setAttribute("cartstatus", null);
                        }
                    %>
                    <p class="h2 mt-3 fonttitle font-weight-600"><%=itemdetails.getString("title")%></p>
                    <p class="h5 mt-3 fontprice font-weight-700" >Price :  <%="<span>&#x20b9</span>"+itemdetails.getString("cost")%></p>
                    <p class="h4 mt-3 fontbrand font-weight-600"> Brand : <%=itemdetails.getString("brand")%></p>
                    <p class="h5 mt-3 fontbrand font-weight-600 text-capitalize">DRESS TYPE :
                        <%
                            if(itemdetails.getString("type").equals("kidboy"))
                            {
                                out.print("KID BOYS");
                            }else if(itemdetails.getString("type").equals("kidgirl"))
                            {
                                out.print("KID GIRLS");
                            }
                            else if(itemdetails.getString("type").equals("men"))
                            {
                                out.print("MEN");
                            }else
                            {
                                out.print("WOMEN");
                            }
                        %>

                    </p>
                    <%
                        String size = itemdetails.getString("size");
                        if(!(size == null || size.trim() == ""))
                        {
                            String S[] = size.split(" ");
                    %>
                            <hr>

                            <p class="h4 d-flex fontsize font-weight-400">
                                <span class="mt-lg-1">Select Size : </span>
                                <select class="form-control ml-3" name="size" onchange="changesize(this.value);" required style="width: auto !important;">
                                    <option value="" disabled selected>Size</option>
                                    <%
                                        for (int l = 0 ; l<S.length; l++)
                                        {
                                    %>
                                        <option value="<%=S[l]%>"><%=S[l]%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </p>
                    <%
                        }
                    %>
                    
                    <%
                }

                %>
                    <hr>
                    <p class="h4 fontselectcolors font-weight-400">
                        Select Colors<br>
                        <span class="bg-white d-flex d-inline-flex mt-1">
                        <%
                            int colorflag = 1;
                            ResultSet colorpicker = con.getdetails(itemid, "colors", con);
                            while(colorpicker.next())
                            {
                                ResultSet colorimage = con.getimagesofthecolor(itemid, colorpicker.getString("color"), 1, con);
                                while(colorimage.next())
                                {
                        %>
                        <input type="radio" class="radio" id="color<%=colorimage.getString("id") %>"
                                   <%
                                       try
                                    {
                                       if((currentcolor=="0" && colorflag ==1) || Integer.parseInt(currentcolor)== Integer.parseInt(colorpicker.getString("id")))
                                       {
                                           colorflag++;
                                   %>
                                   checked 
                                   <%
                                       }
                                    }
                                    catch(Exception e)
                                    {
                                        e.printStackTrace();
                                    }
                                   %>
                                   name="choosecolor" value="<%=colorpicker.getString("color") %>">
                            <label for="color<%=colorimage.getString("id") %>">
                                <a href="items?itemid=<%=request.getParameter("itemid")%>&currentcolorcode=<%=colorpicker.getString("id") %>">
                                    <img src="<%=colorimage.getString("location") %>" width="75" class="subimages">
                                </a>
                            </label>
                                <input type="hidden" name="colorids" value="<%=currentcolor%>">
                        <%
                                }
                            }
                        %>
                        </span>
                    </p>
                    <hr>
             
                        <input type="hidden" name="itemid" value='<%=itemid %>'>
                        <input type="hidden" name="size" class="itemsize">
                        <button type="submit" name="buynow" title="Please Choose the Size"
                                id="buynow" class="btn btn-lg btn-primary addtocartorbuy fontbuynow font-weight-400" style="font-size: 30px;"><i
                                class='fal fa-shopping-bag'></i> BUY NOW</button>
                        <button type="submit" name="addtocart" title="Please Choose the Size" class="btn btn-lg btn-secondary addtocartorbuy fontbuynow font-weight-400" style="font-size: 30px;"><i
                        class='fal fa-shopping-cart'></i> ADD TO CART</button>
                    <hr>

                    <div id="moredetails" class="justify-content-center">
                        <p class="font-weight-bold" id="moredetailslink" style="font-family: 'Montserrat', sans-serif;height:60px ;cursor: pointer; color: black;" onclick="loadmore('<%=itemid %>')"><span class="mb-5"> Load More Details About this Product</span> &nbsp;&nbsp;<i class="far fa-arrow-left fa-2x font-weight-bold animate__animated animate__flash animate__infinite" style="animation-duration:  2s !important;"></i></p>
                        <table class="table table-bordered table-responsive-sm table-hover" style="font-family: 'Oxygen', sans-serif;display: none;">
                            <thead class="table-info text-center h4 font-weight-light"><tr><th>Desctiption</th><th>Details</th></tr></thead>
                            <tbody class="h4">
                            </tbody>
                        </table>
                        <p class="font-weight-bold" id="lessdetailslink" style="font-family: 'Montserrat', sans-serif;cursor: pointer; display: none; color: black;"> Show less</p>
                    </div>
                </div>
                </form>
            </div>
        </div>

    </div>
    <%@include file="footer.html" %>
    <script src="javascript/js.js"></script>
    <script src="bootstrap/js/bootstrap.js"></script>
    <script src="bootstrap/js/bootstrap.bundle.js"></script>
    <script src="validate/validate.js"></script>
    <script src="jqueryui/jquery-ui.js"></script>
    <script src="zoom/zoom.js" type="text/javascript"></script>
 
    <script>
        $("#myform").validate({
            rules:{
              size:{
                  required:true
              }
            },
            messages:{
                size:{
                    required:""
                }
            }
        });
    </script>
    <script>
        function changesize(data)
        {
            $(".addtocartorbuy").removeAttr("title");
            $(".itemsize").val(data)
        }
    </script>
    <script>
            $('#image').bind('hover', function (e) {
                var ez = $('#image').data('ezPlus');
                $.fancyboxPlus(ez.getGalleryList());
                return false;
            });
            $("#image").ezPlus({     
                zoomWindowHeight: 900,
                zoomWindowWidth: 800,
                borderSize: 1,
                gallery: 'imagegroup',
                scrollZoom: true,
                easing: true,
                lensShape: "round",
                lenszoom: true,
                tint: true,
                tintOpacity: 0.2,
                zoomWindowOffsetX: 80,
                zoomTintFadeIn: true,
            });
    </script>
    <script>
        var load = false;
        function loadmore(data)
        {
            if(load == false)
            {
                $.ajax({
                   url: "loadajax",
                   type: 'POST',
                   async: false,
                   data: "type=itemdetails&itemid="+data,
                   dataType: 'json',
                   success: function (data) 
                    {
                        if(data.itemdetaisl)
                        {
                            $.each(data.itemdetaisl, function (key, value) {
                                var s = '<tr><td>'+value.description+'</td><td>'+value.details+'</td></tr>';
                                $("tbody").append(s);
                            });
                            $("#moredetailslink").fadeOut();
                            $("table").slideDown();
                            $("#lessdetailslink").fadeIn();
                            load = true;
                        }
                    }
                });
            }
            else
            {
                $("#moredetailslink").fadeOut();
                $("#lessdetailslink").fadeIn();
                $("table").slideDown();
            }
        }
        $("#lessdetailslink").on('click',function (){
           $("#moredetailslink").fadeIn(); 
           $("#lessdetailslink").fadeOut();
           $("table").slideUp();
        });
    </script>
    <script>
        $(".addtocartorbuy").tooltip({
            classes: {
                "ui-tooltip": "highlight"
            },
            hide: { effect: "explode", duration: 1000 },
            position: { my: "top-80", at: "center" }
        });
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
          });
    </script>
</body>

</html>