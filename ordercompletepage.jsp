<%@page import="java.util.Iterator"%>
<%@page import="comm.classes.orderlist"%>
<%@page import="java.util.ArrayList"%>
<%@page import="comm.classes.connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Order placed</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@1,600&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Abel&family=Archivo+Black&family=Baloo+Tammudu+2:wght@400;500;600;700;800&family=Bebas+Neue&family=Cabin:wght@400;500;600;700&family=Cardo:wght@400;700&family=Chakra+Petch:wght@300;400;500;600;700&family=Cinzel:wght@400;500;600;700;800;900&family=Cuprum:wght@400;500;600;700&family=El+Messiri:wght@400;500;600;700&family=Fira+Sans:wght@100;200;300;400;500;600;700;800;900&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Mina:wght@400;700&family=Montserrat:wght@100;200;300;400;500;600;700;800;900&family=Nunito:wght@200;300;400;600;700;800;900&family=Oxygen:wght@300;400;700&family=Roboto+Slab:wght@100;200;300;400;500;600;700;800;900&family=Trispace:wght@100;200;300;400;500;600;700;800&family=Vidaloka&family=Volkhov:wght@400;700&display=swap" rel="stylesheet">
        <style>
            body{
                background-image: url(images/bg/7.jfif) ; 
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
            .heighlet
            {
                font-weight: 900 !important;
                font-family: 'Raleway', sans-serif;
            }
        </style>
    </head>
    <body class=" user-select-none"> 
        <%@include file="header.jsp" %>
        <div class="container-fluid">
            <div class="row d-flex justify-content-center m-1 m-lg-5">
                <div class="col-xl-8 col-lg-12 col-md-12 col-sm-12">
                    <%
                        if(request.getAttribute("success")!=null)
                        { 
                    %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <%=request.getAttribute("success") %>
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;
                            </button>
                        </div>
                    <%  
                        }
                        if(request.getAttribute("error")!=null) 
                        { 
                    %>
                            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                <%=request.getAttribute("error") %>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;
                                </button>
                            </div>
                    <%
                        }
                    %>
                    <%
                        if(session.getAttribute("id")!=null)
                        {
                            session.setAttribute("path", null);
                            connection con = new connection();
                            ArrayList<orderlist> list = con.getorderlist(Integer.parseInt((String)session.getAttribute("id")));
                            if(list.size()>0)
                            {
                                int counts = 1;
                                Iterator<orderlist> itr = list.iterator();
                                while(itr.hasNext())
                                {
                                    orderlist ord = itr.next();
                                    if(counts==1)
                                    {
                                        Statement st = con.con.createStatement();
                                        ResultSet rs = st.executeQuery("SELECT COUNT(id) FROM `placeorder` WHERE status NOT LIKE 'Order Cancelled' AND cid LIKE "+session.getAttribute("id")+";");
                                        while(rs.next())
                                        {
                                            out.print("<input type='hidden' id='ordercount' value='"+rs.getString(1)+"' name='ordercount'>");
                                            out.print("<p class='ordercount h1 mb-lg-4 ml-lg-5 d-flex font4 font-weight-700 justify-content-end' style='color:black;'>My Order Lists ("+rs.getString(1)+")</p>");
                                        }
                                        counts++;
                                    }
                    %>
                    
                                    <div class="row p-1 m-lg-1 bg-white">
                                        <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                            <div class="text-center mt-lg-4">
                                                <a href="items?itemid=<%=ord.getItemid()%>&currentcolorcode=<%=ord.getColorid()%>" class=" text-decoration-none">
                                                    <img src="<%=ord.getLocation() %>" class="img-fluid figure-img" style="width: 70%;">
                                                </a>
                                                <%
                                                    if(!ord.getStatus().equals("Order Cancelled"))
                                                    {
                                                        %>
                                                            <p class="mt-xl-4 h4 text-info" style="cursor: pointer;" id="cancelorder<%=ord.getId()%>" onclick="cancelmyorder('<%=ord.getId()%>')">Cancel Order</p>
                                                        <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                        <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                            <h3 class="fonttitle font-weight-700"><%=ord.getTitle()%></h3>
                                            <h4 class="fontselectcolors font-weight-700">Brand : <%=ord.getBrand()%></h4>
                                            <h5 class="fontsize font-weight-700">Size : <%=ord.getSize() %></h5>
                                            <h5 class="fontquantity font-weight-700">Quantity : <%=ord.getQuantity()%></h5>
                                            <h5 class="font6 font-weight-500">Order time : <%=ord.getDate()%></h5>
                                            <h5 class="font6 font-weight-500 cancle<%=ord.getId()%>">Status : <%=ord.getStatus()%></h5>
                                            <h5 class="font6 font-weight-500">Payment Mode :
                                                <%
                                                    if(ord.getPaymentmode().equals("offline"))
                                                    {
                                                        out.print("Cash on Delivery");
                                                    }
                                                    else
                                                    {
                                                        out.print(ord.getPaymentmode());
                                                    }
                                                %></h5>
                                            <p class="h3 fontprice1"><strong>Price : </strong><span>&#x20b9</span><%=ord.getPrice() * Integer.parseInt(ord.getQuantity()) %></p>
                                            <div class="card" style="background: transparent;">
                                                <div class="card-header">
                                                    <h2 class="text-danger font6">Delivery Address</h2>
                                                </div>
                                                <div class="card-body font3">
                                                    <h5><span class="heighlet">Country </span>: <%=ord.getCountry()%>, <span class="heighlet">State </span>: <%=ord.getState()%>, <span class="heighlet">City </span>: <%=ord.getCity()%></h5>
                                                    <h5><span class="heighlet">Address </span>: <%=ord.getAddress()%></h5>
                                                    <h5><span class="heighlet">Zip-code </span>: <%=ord.getZip()%></h5>
                                                    <h5><span class="heighlet">Phone number </span>: <%=ord.getPhone()%></h5>
                                                    <%
                                                        try
                                                        {
                                                        String aphones = ord.getAphone();
                                                        if(aphones.length()== 10)
                                                        {
                                                            out.print("<h5><span class='heighlet'>Phone number </span>: "+ord.getAphone()+"</h5>");
                                                        }
                                                        }
                                                        catch(Exception e)
                                                        {
                                                            e.printStackTrace();
                                                        }
                                                    %>
                                                    <h5><span class="heighlet">Delivery time </span>: 
                                                        <%
                                                            if(ord.getAddresstype().equals("home"))
                                                            {
                                                                out.print("8AM - 10PM");
                                                            }
                                                            else
                                                            {
                                                                out.print("10AM - 6PM");
                                                            }
                                                        %>
                                                    </h5>
                                                </div>
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                        <%  
                                }
                            }
                            else
                            {
                        %>
                            <div class="row d-flex justify-content-center align-items-center" style="height: 70vh;">
                                <div class="col-xl-8 col-md-8 col-sm-10">
                                    <div class="card card-body">
                                        <p class="h2 text-primary">You didn't ordered anything yet.</p>
                                    </div>
                                </div>
                            </div>
                        <%
                            }
                        }
                        else
                        {
                            session.setAttribute("path", "ordercompletepage.jsp");
                    %>
                            <div class="row d-flex justify-content-center align-items-center" style="height: 70vh;">
                                <div class="col-xl-8 col-md-8 col-sm-10">
                                    <div class="card card-body">
                                        <p class="h2 text-primary">Please Login to see your orders</p>
                                        <a href="page?name=login" class="btn btn-lg text-uppercase h3 p-2 m-5 btn-info">login</a>
                                    </div>
                                </div>
                            </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <%@include file="footer.html" %>
        <script src="javascript/js.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="bootstrap/js/bootstrap.bundle.js" type="text/javascript"></script>
        <script src="bootstrap/toast/toast.min.js" type="text/javascript"></script>
        <script>
            function cancelmyorder(id)
            {
                var s = confirm("Do you want to cancel the order?"+id);
                if(s)
                {
                    $.ajax({
                       url: "loadajax",
                       data: "type=cancelorder&id="+id,
                       type: 'POST',
                       success: function (data)
                       {
                           if(data!="fail")
                           {
                               $(".cancle"+id).html("Status : Order Cancelled");
                               $("#cancelorder"+id).fadeOut();
                               var s =Math.floor( $("#ordercount").val() );
                               s = s - 1;
                               $(".ordercount").html("My Order Lists ("+s+")");
                               $("#ordercount").val(s);
//                               toslaalert("bottom-right","success",'<i class="far fa-check-circle"></i> Success','Order has been cancelled !!','5000');
                           }
                       }
                    });
                }
            }
        </script>
    </body>
</html>
