<%@page import="java.util.Iterator"%>
<%@page import="comm.classes.cartdetails"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="comm.classes.connection"%>
<%@page contentType="text/html" session="true" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cart List</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="bootstrap/css/bootstrap-grid.css" rel="stylesheet" type="text/css"/>
        <link href="bootstrap/css/bootstrap-reboot.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
        <link href="bootstrap/toast/toast.min.css" rel="stylesheet" type="text/css"/>
        <style>
            body
            {
                background-image: url(images/bg/7.jfif) ; 
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
        </style>
    </head>
    <body class=" user-select-none">
        <%@include file="header.jsp" %>
        <form method="POST" action="orderplace">
        <%
            try
            {
        %>
        <%!int totalprice = 0;%>
        <div class="container">
            <%
                connection con = new connection();
                int id =Integer.parseInt((String)session.getAttribute("id"));
                ArrayList<cartdetails> list = con.getcartdetails(id);
                if(list.size()>0)
                {
                    %>
                        <div class="d-flex justify-content-end" style=" color: black;margin-top: 40px !important;">
                            <div class="h1 mt-1 mb-5 font-weight-700 font6 text-primary">
                                <span>Total Price : <span>&#x20b9</span><span id="totalpricedisplay"></span></span>
                            </div>
                        </div>
                    <%
                    totalprice = 0;
                    Iterator<cartdetails> itr = list.iterator();
                    while(itr.hasNext())
                    {
                        cartdetails obj = itr.next();
                        totalprice = totalprice + ( obj.getPrice() * obj.getQuantity());
                        
            %>
                    <div class="row mt-2 bg-white" id="cartid<%=obj.getId()%>">
                        <input type="hidden" name="currentprice<%=obj.getId() %>" id="currentprice<%=obj.getId()%>" value="<%=obj.getPrice() %>">
                        <div class="col-xl-4 col-md-4 col-sm-5 text-center">
                            <div class="p-2">
                                <a href="items?itemid=<%=obj.getItemid()%>&currentcolorcode=<%=obj.getColorid()%>">
                                    <img src="<%=obj.getLocation() %>" class="img-fluid" style="width: 70%;">
                                </a>
                            </div>
                            <div class="d-flex mt-2 p-2 justify-content-center">
                                <div style="width: 13%; cursor: pointer;" class="border h3" onclick="minusitem('<%=obj.getId()%>')"><i class="fal fa-minus"></i></div>
                                <input type="hidden" name="count<%=obj.getId()%>" id="countinput<%=obj.getId()%>" value="<%=obj.getQuantity()%>">
                                <div style="width: 33%;" id="displaycount<%=obj.getId()%>" class="h3"><%=obj.getQuantity()%></div>
                                <div style="width: 13%; cursor: pointer;" class="border h3" onclick="plusitem('<%=obj.getId()%>')"><i class="fal fa-plus"></i></div>
                            </div>
                        </div>
                        <div class="col-xl-8 col-md-8 col-sm-7">
                            <div class="mt-3 ml-lg-5 ml-sm-5 p-3 ml-md-5">
                                <p class="h2 fonttitle font-weight-700"><%=obj.getTitle()%></p>
                                <input type="hidden" name="pricescount<%=obj.getId()%>" id="pricescounthidden<%=obj.getId()%>" value="<%=obj.getPrice()*obj.getQuantity()%>">
                                <p class="h4 fontprice1 font-weight-700">Price : <span>&#x20b9</span><span id="pricescount<%=obj.getId()%>"><%=obj.getPrice()*obj.getQuantity() %></span></p>
                                <p class="h4 fontbrand font-weight-700   ">Brand : <%=obj.getBrand()%></p>
                                <p class="h4 fontsize font-weight-700">Size : <%=obj.getSize() %></p>
                                <input class="btn btn-danger mt-5 font8" onclick="removecart('<%=obj.getId()%>')" value="Remove from the cart" type="button">
                            </div>
                        </div>  
                    </div>
                    <hr id="removehr<%=obj.getId()%>">
            <%
                    }
                    %>
                        
                            <div class="d-flex justify-content-end" style="margin-top: 65px !important;">
                                <input type="hidden" name="totalprice" id="totalprice">
                                <div class="h3 mt-2 mb-5 font-weight-700 font6 text-primary">
                                    <button type="submit" name="buycartlist" class="btn btn-lg btn-primary">Buy Now</button>
                                </div>
                            </div>
                        
                    <%
                }
                 else
                {
                    %>
                    <div class="container">
                        <div style="height: 80vh;" class="row d-flex justify-content-center align-items-center">
                            <div class="text-center h1 text-primary">
                                <div class="col-xl-12">You didn't added any items to the cart</div>
                            </div>
                        </div>
                    </div>
                    <%
                }
            %>
        </div>
        <%
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }   
        %>
        </form>
        <%@include file="footer.html" %>
        <script src="javascript/js.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.bundle.js" type="text/javascript"></script>
        <script src="bootstrap/toast/toast.min.js" type="text/javascript"></script>
        <script>
            $("#totalprice").val("<%=totalprice %>");
            $("#totalpricedisplay").html("<%=totalprice %>")
            function minusitem(data)
            {
                var price = parseInt($("#pricescounthidden"+data).val());
                var cprice = parseInt($("#currentprice"+data).val());
                var totalprice = parseInt($("#totalprice").val());
                var q = $("#countinput"+data).val();
                var s = false;
                if(q==1)
                {
                    s = confirm("Your item is quality is 1. So do you want to remove this from cart,")
                }
                else
                {
                    $.ajax({
                        url: "cartservalet",
                        type: 'POST',
                        async: false,
                        data: "type=minus&id="+data+"&q="+q,
                        success: function (data1) 
                        {
                            if(data1!="fail")
                            {
                                $("#displaycount"+data).html("");
                                $("#displaycount"+data).html(data1);
                                $("#countinput"+data).val(data1);
                                var sum = price-cprice;
                                $("#pricescount"+data).html(sum);
                                $("#pricescounthidden"+data).val(sum)
                                var modifytotalprice = totalprice-cprice;
                                $("#totalprice").val(modifytotalprice);
                                $("#totalpricedisplay").html(modifytotalprice);
                            }
                            else
                            {
                                alert("Sorry some error is Occured");
                            }
                        }
                    });
                }
                if(s)
                {
                    removecart(data);
                }
            }
            function plusitem(data)
            {
                
                var price = parseInt($("#pricescounthidden"+data).val());
                var cprice = parseInt($("#currentprice"+data).val());
                var totalprice = parseInt($("#totalprice").val());
                var q = $("#countinput"+data).val();
                $.ajax({
                    url: "cartservalet",
                    type: 'POST',
                    async: false,
                    data: "type=plus&id="+data+"&q="+q,
                    success: function (data1) 
                    {
                        if(data1 != "fail")
                        {
                            $("#displaycount"+data).html(data1);
                            $("#countinput"+data).val(data1);
                            var sum = price+cprice;
                            $("#pricescount"+data).html(sum);
                            $("#pricescounthidden"+data).val(sum)
                            var modifytotalprice = totalprice+cprice;
                            $("#totalprice").val(modifytotalprice);
                            $("#totalpricedisplay").html(modifytotalprice);
                        }
                        else
                        {
                            alert("Sorry some error is Occured");
                        }
                    }
                });
                
            }
            function removecart(data)
            {
                var cprice = parseInt($("#currentprice"+data).val());
                var con = confirm("Do you want to remove this item from cart");
                var q = parseInt($("#countinput"+data).val());
                var totalprice = parseInt($("#totalprice").val());
                if(con)
                {   
                    $.ajax({
                        url: "cartservalet",
                        type: 'POST',
                        data: "type=remove&id="+data,
                        success: function (data1) 
                        {
                            if(data1!="fail")
                            {
                                $("#cartid"+data).slideUp();
                                $("#removehr"+data).slideUp();
                                var modifytotalprice = totalprice-(cprice*q);
                                $("#totalprice").val(modifytotalprice);
                                $("#totalpricedisplay").html(modifytotalprice);
                                toslaalert("bottom-right","success",'<i class="far fa-check-circle"></i> Success','Item as been removed from the cart');
                            }
                            else
                            {
                                toslaalert("bottom-right","warning",'<i class="far fa-exclamation-triangle"></i> Warning','Item Not deleted<br>try again');
                            }
                        }
                    });
                }
            }
        </script>
    </body>
</html>
