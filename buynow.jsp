<%@page import="java.util.Iterator"%>
<%@page import="comm.classes.cartdetails"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="comm.classes.connection"%>
<%@page contentType="text/html" session="true" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>Order</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="jqueryui/jquery-ui.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <link href="bootstrap/bootstrap-steps.min.css" rel="stylesheet" type="text/css" />
    <style>
        body{
            background-image: url(images/bg/7.jfif) ;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
        }
        <% int totalprice = 0;%>
        <%
            if(session.getAttribute("cart")==null)
            {
                if(session.getAttribute("buynowittitle")==null)
                {
                    request.getRequestDispatcher("").forward(request, response);
                }
            }
        %>
        <% 
            if (session.getAttribute("id") !=null) 
            {
                session.setAttribute("path", null); 
            %>
                #first,
                #third,
                #fourth 
                {
                    display: none;
                }
            <%
            }
            else 
            {
                session.setAttribute("path", "items?BuyNow");
            %>
            #second,
            #third,
            #fourth 
            {
                display: none;
            }
        <%
            }
        %>
        .form-control:focus 
        {
            box-shadow: 0 0 9px 0.2rem rgb(0 123 255 / 36%);
        }
        .ui-checkboxradio-radio-label 
        {
            border-radius: 10px;
        }
        .ui-checkboxradio-radio-label1 {
            border-color: red;
        }
        .form-control1 {
            box-shadow: 0 0 0 0.07rem red !important;
            margin-top: 2px;
        }
        .error {
            color: red;
            margin-top: 2px;
            padding: 0px 2px;
            background-color: white;
        }
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type=number] {
            -moz-appearance: textfield;
        }
        
        @media screen and (min-width:770px) {
            .step-content {
                min-width: 8rem !important;
            }

            .step-circle::before {
                width: calc(8rem + 1rem - 1.5rem) !important;
            }
        }
        @media screen and (min-width:1200px) {
            .step-content {
                min-width: 14rem !important;
            }
            .step-circle::before {
                width: calc(14rem + 1rem - 1.5rem) !important;
            }
        }
        @media screen and (min-width:1350px) {
            .step-circle {
                width: 2.5rem !important;
                height: 2.5rem !important;
            }
            .step-content {
                min-width: 16rem !important;
            }
            .step-circle::before {
                width: calc(16rem + 1rem - 2.5rem) !important;
            }
        }
        .ch .close {
            opacity: 0;
            transition: 0.5s;
        }
        .ch:hover .close {
            opacity: 1;
        }
        @media screen and (min-width:1400px) {
            .step-circle {
                width: 3.5rem !important;
                height: 3.5rem !important;
            }
            .step-content {
                min-width: 18rem !important;
            }
            .step-circle::before {
                width: calc(18rem + 1rem - 3.5rem) !important;
            }
        }
        #payment {
            display: none;
        }
        .step-active .step-content .step-circle
        {
            background-color: darkblue;
        }
        .step-error .step-content .step-circle
        {
            background-color: red;
        }
        .step-active .step-content .step-text
        {
            color: darkblue;
        }
        .step-success .step-content .step-text
        {
            color:darkblue;
        }
        .step-text
        {
            font-weight: 900;
            color: white;
        }
    </style>
</head>

<body class=" user-select-none">
    <%@include file="header.jsp" %>
    <div class="container-fluid">
        <div class="mt-5 mb-5 d-flex row justify-content-center align-content-center">
            <div class="col-xl-11 col-md-10 col-sm-12">
                <ul class="steps">
                    <li class="step first">
                        <div class="step-content">
                            <span class="step-circle">1</span>
                            <span class="step-text"><i class="fal fa-sign-in-alt"></i> Login</span>
                        </div>
                    </li>
                    <li class="step second">
                        <div class="step-content">
                            <span class="step-circle">2</span>
                            <span class="step-text"><i class="fal fa-address-card"></i> Address</span>
                        </div>
                    </li>
                    <li class="step third">
                        <div class="step-content">
                            <span class="step-circle">3</span>
                            <span class="step-text"><i class="fal fa-credit-card"></i> Payment</span>
                        </div>
                    </li>
                    <li class="step forth">
                        <div class="step-content">
                            <span class="step-circle">4</span>
                            <span class="step-text"><i class="fal fa-check-double"></i> Place Order</span>
                        </div>
                    </li>
                </ul>
                <form method="POST" id="myform" action="ordernow">
                    <fieldset id="first">
                        <hr class="border-primary 
                            <%if(session.getAttribute("cart")!=null ) {%>
                            col-xl-8 col-md-8 col-lg-8 col-sm-12 p-0
                            <%}%>
                            ">
                        <div class="row justify-content-center">
                            <div class="col-xl-8 col-md-10 col-sm-12">
                                <div class="card card-body p-5 border-bottom-0 border-top-0 border-primary">
                                    <% 
                                        if (session.getAttribute("id") != null) 
                                        {
                                    %>
                                    <div class="justify-content-center align-items-center text-center text-success h1" style="font-family: 'Nunito', sans-serif;">
                                        <i class="fas fa-shield-check"></i> Your account is verified successfully.
                                    </div>
                                    <%
                                        } 
                                        else 
                                        {
                                    %>
                                    <div style="font-family: 'Nunito', sans-serif;" class="justify-content-center mt-5 align-items-center text-center text-danger h1 mb-4">
                                        <i class="fal fa-exclamation-circle"></i> You didn't logged in with your Account.
                                    </div>
                                    <div style="font-family: 'Nunito', sans-serif;" class="justify-content-center align-items-center text-center text-info h3">
                                        <i class="fad fa-smile"></i> Please login and come back again.<br>
                                        <a s href="page?name=login" class="btn btn-lg btn-warning text-uppercase p-2 mt-5"
                                            style=" font-family: 'Nunito', sans-serif;letter-spacing: 1px;">Login</a>
                                        <p class="mt-5 text-primary h5">Login to access next steps.</p>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        <hr class="border-primary 
                            <%if(session.getAttribute("cart")!=null ) {%>
                            col-xl-8 col-md-8 col-lg-8 col-sm-12 p-0
                            <%}%>
                            ">
                        <%if(session.getAttribute("cart")!=null ) 
                        { 
                        %>
                            <div class="row d-flex d-inline justify-content-center">
                                <div class="col-xl-8 col-md-8 col-lg-8 col-sm-12">
                                    <div>
                                        <p><a class="btn btn-primary next float-right text-uppercase text-light">next</a></p>
                                    </div>
                                </div>
                            </div>
                        <% 
                        }
                        else
                        {
                        %>
                            <p><a class="btn btn-primary next float-right text-uppercase text-light">next</a></p>
                        <% }%>  
                    </fieldset>
                    <fieldset id="second">
                        <hr class="border-primary 
                            <%if(session.getAttribute("cart")!=null ) {%>
                            col-xl-8 col-md-8 col-lg-8 col-sm-12 p-0
                            <%}%>
                            ">
                        <div class="card card-body border-0 border-primary" style="background: transparent">
                            <div class="row justify-content-center">
                                <div class="col-xl-8 col-md-8 col-lg-8 col-sm-12 p-0 mt-2">
                                    <%
                                        if(session.getAttribute("id")!=null)
                                        {
                                            connection con = new connection();
                                            int id =Integer.parseInt((String)session.getAttribute("id"));
                                            ResultSet rs = con.SelectAddress(id , con);
                                            int ccc= 1,uuu=1;
                                            while(rs.next())
                                            {
                                                if(ccc==1)
                                                {
                                    %>
                                                <div class="card card-body border-dark">
                                                    <div class="row">
                                            <%
                                                    ccc++;
                                                }
                                            %>
                                                        <div class="col-xl-6 col-md-6 col-sm-12" id="deleteaddressid<%=rs.getInt("id") %>">
                                                            <div class="card card-body shadow border-primary">
                                                                <input onclick="addresscard(true)" type="radio" id="addressid<%=rs.getString("id")%>" name="oldaddress" value="<%=rs.getString("id")%>" class="form-check-input ml-3">
                                                                <label for="addressid<%=rs.getString("id")%>" class="ml-5" style="cursor: pointer;font-family: 'Nunito', sans-serif;">
                                                                    <p><span class="font-weight-bold">Address : </span><%=rs.getString("address")%></p>
                                                                    <p><span class="font-weight-bold">Phone : </span><%=rs.getString("phone")%><% if(rs.getString("aphone")!=null){%>, <span class="font-weight-bold">Alternate Phone : </span><%=rs.getString("aphone")%><%}%></p>
                                                                    <p><span class="font-weight-bold">Country : </span><%=rs.getString("countryname")%>, <span class="font-weight-bold">State : </span><%=rs.getString("statename")%>, <span class="font-weight-bold">City : </span><%=rs.getString("cityname")%></p>
                                                                    <p><span class="font-weight-bold">Zip Code : </span><%=rs.getString("zip")%></p>
                                                                    <p><span class="font-weight-bold">Timings : </span><% String ss = rs.getString("addresstype"); if(ss=="home") out.print("7AM - 8PM"); else out.print("10AM - 6PM");%></p>
                                                                </label>
                                                                <p>
                                                                    <span class="float-right btn btn-danger" style="width:200px;" onclick="removeaddress('<%=rs.getInt("id") %>')">Remove Address</span>
                                                                </p>
                                                            </div>
                                                        </div>
                                        <%
                                            }
                                        %>
                                                <%
                                                    if(ccc==2)
                                                    {
                                                        ccc++;
                                                %>
                                                        </div>
                                                    </div>
                                                <%
                                                    }
                                                %>
                                                <div class="col-xl-3 col-md-4 mt-4" id="addnewaddressbtn" style="display: none;">
                                                    <button onclick="addresscard(false)" class="btn btn-info">Add New Address</button> 
                                                </div>
                                            <%
                                        }
                                    %>
                                    <div id="newaddress">
                                        <div class="card card-body border-dark mt-2">
                                            <div class="row">
                                                <div class="col-xl-4 col-md-4">
                                                    <label for="country">Country</label>
                                                    <select class="form-control" name="country" required
                                                        onchange="states(this.value)" id="country">
                                                        <option value="">Country</option>
                                                        <%
                                                                connection con = new connection();
                                                                Statement st;
                                                                ResultSet rs;
                                                                st = con.con.createStatement();
                                                                String s = "SELECT * FROM `countries` WHERE id LIKE '101'";
                                                                rs = st.executeQuery(s);
                                                                while (rs.next()) {
                                                            %>
                                                        <option value="<%=rs.getString("name")%>"><%=rs.getString("name")%>
                                                        </option>
                                                        <%
                                                                }
                                                            %>
                                                    </select><br>
                                                </div>
                                                <div class="col-xl-4 col-md-4">
                                                    <label for="state">State</label>
                                                    <select class="form-control d-block w-100" id="state" required
                                                        onchange="cities(this.value)" name="state">
                                                        <option value="">Choose...</option>
                                                      </select><br>
                                                </div>
                                                <div class="col-xl-4 col-md-4">
                                                    <label for="state">City</label>
                                                    <select class="form-control d-block w-100" id="dist" required
                                                        name="dist">
                                                        <option value="">Choose...</option>
                                                    </select><br>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-xl-12 mb-5 mt-4">
                                                    <label for="address">Address</label>
                                                    <textarea class="form-control" name="address" rows="5" required
                                                        minlength="6"></textarea>
                                                </div>
                                                <div class="col-xl-4 col-md-4">
                                                    <label for="zip">Zip Code</label>
                                                    <input type="number" placeholder="581108" name="zip" required
                                                        class="form-control" id="zip" minlength="6" maxlength="6">
                                                </div>
                                                <div class="col-xl-4 col-md-4">
                                                    <label for="phone">Phone</label>
                                                    <input type="number" placeholder="Phone number" required name="phone"
                                                        class="form-control" id="phone">
                                                </div>
                                                <div class="col-xl-4 col-md-4">
                                                    <label for="aphone">Alternate Phone</label>
                                                    <input type="number" placeholder="Alternate Phone number" name="aphone"
                                                        class="form-control" id="aphone">
                                                </div><br>
                                                <div class="col-xl-10 col-md-6"><br>
                                                    <label class="d-flex">Available timings</label>
                                                    <div id="radioset" class="d-block">
                                                        <input type="radio" name="addresstype" required value="home"
                                                            id="male"><label for="male"
                                                            class="font-weight-bold mr-2">Business address 10AM - 6PM</label>
                                                        <input type="radio" name="addresstype" required value="business"
                                                            id="female"><label for="female" class="font-weight-bold">Home
                                                            address 7AM-8PM</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <%
                                if(session.getAttribute("cart")==null)
                                {
                            %>
                                <div class="col-xl-4 mt-2">
                                    <div class="row align-items-center sticky-top" style="top: 40px;">
                                        <div class="col-xl-12 col-md-12 col-sm-12">
                                            <div class="card card-body shadow border-primary">
                                                <div class="justify-content-center text-center">
                                                    <img class="img-fluid" width="150" src="<%=session.getAttribute("buynowlocation") %>">
                                                    <div class="text-left text-uppercase h3">
                                                        <h3 style="font-family: 'Trispace', sans-serif; font-weight: 900;"><%=session.getAttribute("buynowittitle") %></h3>
                                                        <p class="h4" style="font-family: 'Rubik', sans-serif; font-weight: 700;">Price : <span>&#x20b9</span><%=session.getAttribute("buynowprice") %></p>
                                                        <h4 style="font-family: 'Cinzel', serif; font-weight: 500;">Brand : <%=session.getAttribute("buynowbrand") %></h4>
                                                        <h5 style="font-family: 'Cuprum', sans-serif; font-weight: 400;">Size : <%=session.getAttribute("buynowsize") %></h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-12 col-md-12 col-sm-12">
                                            <div class="card card-body shadow border-primary">
                                                <div class="d-flex">
                                                    <label class="h4 mt-1 mr-2" for="quantity" style="font-family: 'Cuprum', sans-serif; font-weight: 400;">Quantity : </label>
                                                    <input type="number" required name="quantity"
                                                        style="width: 100px !important;" placeholder="eg: 2"
                                                        class="form-control" id="quantity" onkeyup="pricecalculate(this.value)">
                                                </div>
                                            </div>
                                        </div>                                        
                                    </div>
                                </div>
                                <% 
                                    }
                                    else
                                    {
                                %>
                                <div class="col-xl-8 p-0 col-md-8 col-sm-12 mt-3">
                                    <div class="card card-body border-dark">
                                        <div class="row">
                                <%
                                        int id =Integer.parseInt((String) session.getAttribute("id"));
                                        ArrayList<cartdetails> list = con.getcartdetails(id);
                                        if(list.size()>0)
                                        {
                                            Iterator<cartdetails> itr = list.iterator();
                                            while(itr.hasNext())
                                            {
                                                cartdetails obj = itr.next();
                                        %>
                                                    <div class="col-xl-6 col-md-6 col-sm-12 mt-4">
                                                        <div class="card card-body border-dark">
                                                            <div class="justify-content-center text-center">
                                                                <img class="img-fluid" width="150" src="<%=obj.getLocation() %>">
                                                                <div class="text-left text-uppercase h3">
                                                                    <h3 class="ml-lg-3 fonttitle font-weight-900"><%=obj.getTitle()%></h3>
                                                                    <h5 class="ml-lg-3 fontprice font-weight-600">Price : <span>&#x20b9</span><%=obj.getPrice()*obj.getQuantity() %></h5>
                                                                    <h4 class="ml-lg-3 fontquantity  font-weight-500">Quantities : <%=obj.getQuantity()%></h4>
                                                                    <h5 class="ml-lg-3 fontsize">Size : <%=obj.getSize()%></h5>
                                                                    <%
                                                                        totalprice = totalprice + (obj.getPrice()*  obj.getQuantity()) ;
                                                                    %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                        <%
                                            }
                                        }
                                %>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <hr class="border-primary 
                            <%if(session.getAttribute("cart")!=null ) {%>
                            col-xl-8 col-md-8 col-lg-8 col-sm-12 p-0
                            <%}%>
                            ">
                        <%if(session.getAttribute("cart")!=null ) 
                        { 
                        %>
                            <div class="row d-flex d-inline justify-content-center">
                                <div class="col-xl-8 col-md-8 col-lg-8 col-sm-12">
                                    <div>
                                        <p><a class="btn btn-primary next float-right text-uppercase text-light">next</a></p>
                                        <p><a class="btn btn-primary previous float-left text-uppercase text-light">Previous</a></p>
                                    </div>
                                </div>
                            </div>
                        <% 
                        }
                        else
                        {
                        %>
                            <p><a class="btn btn-primary next float-right text-uppercase text-light">next</a></p>
                            <p><a class="btn btn-primary previous float-left text-uppercase text-light">Previous</a></p>
                        <% }%>    
                    </fieldset>
                    <fieldset id="third">
                        <hr class="border-primary 
                            <%if(session.getAttribute("cart")!=null ) {%>
                            col-xl-8 col-md-8 col-lg-8 col-sm-12 p-0
                            <%}%>
                            ">
                        <div class="card card-body border-0 border-primary" style="background: transparent">
                            <div class="row justify-content-center">
                                <div class="col-xl-8 p-0 col-md-8 col-sm-12">
                                    <%
                                        if(session.getAttribute("cart")!=null)
                                        {
                                    %>
                                    <h2 class="text-right fontprice font-weight-700">Total price :
                                        <%
                                                out.print("<span>&#x20b9</span>"+totalprice);
                                        %>
                                    </h2>
                                    <%
                                        }
                                    %>
                                    <div class="card card-body border-dark">
                                        <label class="h2 text-info text-uppercase" style="font-family: 'Trispace', sans-serif;font-weight: 500;"s>Choose Payment Method</label>
                                        <div id="radioset1" class="mt-3" style="font-family: 'Trispace', sans-serif;">
                                            <input type="radio" onclick="pay(this.value);" name="payment" required
                                                value="offline" id="offline"><label for="offline"
                                                class="font-weight-bold mr-2">Cash On Delivery</label>
                                            <input type="radio" onclick="pay(this.value);" name="payment" required
                                                value="online" id="online"><label for="online"
                                                class="font-weight-bold">Online Payment</label>
                                                
                                        </div><br>

                                        <div id="payment">
                                            <div class="form-group">
                                                <label for="username"><h6>Card Owner Name</h6></label>
                                                <input type="text" name="cardname" placeholder="Card Owner Name"required class="form-control ">
                                            </div>
                                            <div class="form-group">
                                                <label for="cardNumber"><h6>Card number</h6></label>
                                                <div class="input-group"> 
                                                    <input type="text" name="cardnumber"placeholder="Valid card number" class="form-control " required>
                                                    <div class="input-group-append">
                                                        <span class="input-group-text text-muted">
                                                            <i class="fab fa-cc-visa mx-1"></i>
                                                            <i class="fab fa-cc-mastercard mx-1"></i>
                                                            <i class="fab fa-cc-amex mx-1"></i>
                                                        </span> 
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-8">
                                                    <div class="form-group">
                                                        <label><span class="hidden-xs"><h6>Expiration Date</h6></span></label>
                                                        <div class="input-group"> 
                                                            <input type="number" placeholder="MM" name="mm" class="form-control" required> 
                                                            <input type="number" placeholder="YY" name="yy"class="form-control" required> 
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-4">
                                                    <div class="form-group mb-4"> 
                                                        <label data-toggle="tooltip" title="Three digit CV code on the back of your card"><h6>CVV <i class="fa fa-question-circle d-inline"></i></h6></label> 
                                                        <input type="password" placeholder="ccv" required class="form-control" name="ccv">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    if(session.getAttribute("cart")==null)
                                    {
                                %>
                                <div class="col-xl-4 col-md-4 col-sm-12">
                                    <div class="card card-body border-dark">
                                        <div class="row align-items-center">
                                            
                                            <div class="col-xl-12 col-md-12 col-sm-12">
                                                <div class="card card-body shadow border-primary">
                                                    <div class="justify-content-center text-center">
                                                        <img class="img-fluid" width="150" src="<%=session.getAttribute("buynowlocation") %>">
                                                        <div class="text-left text-uppercase">
                                                            <h3 class="fonttitle font-weight-900"><%=session.getAttribute("buynowittitle") %></h3>
                                                            <p class="fontprice h4 font-weight-700">Price : <span>&#x20b9</span><%=session.getAttribute("buynowprice") %></p>
                                                            <h4 class="fontbrand">Brand : <%=session.getAttribute("buynowbrand") %></h4>
                                                            <h5 class="fontsize">Size : <%=session.getAttribute("buynowsize") %></h5>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-12 col-md-12 col-sm-12">
                                                <div class="card card-body shadow mt-4 border-primary">
                                                    <div class="justify-content-center">
                                                        <p class="font3 font-weight-600 h4">Quantity : <span id="q"></span></p>
                                                        <p class="fontprice1 font-weight-700 h4">Totle Price : <span>&#x20b9</span><span id="p"></span></p>
                                                        <input type="hidden" required name="quantityprice" id="quantityprice" min="1" max="1000">
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                                <% 
                                    }
                                    else
                                    {
                                %>
                                <div class="col-xl-8 p-0 col-md-8 col-sm-12 mt-3">
                                    <div class="card card-body border-dark">
                                        <div class="row">
                                <%
                                        int id =Integer.parseInt((String) session.getAttribute("id"));
                                        ArrayList<cartdetails> list = con.getcartdetails(id);
                                        if(list.size()>0)
                                        {
                                            Iterator<cartdetails> itr = list.iterator();
                                            while(itr.hasNext())
                                            {
                                                cartdetails obj = itr.next();
                                        %>
                                                    <div class="col-xl-6 col-md-6 col-sm-12 mt-4">
                                                        <div class="card card-body border-dark">
                                                            <div class="justify-content-center text-center">
                                                                <img class="img-fluid" width="150" src="<%=obj.getLocation() %>">
                                                                <div class="text-left text-uppercase h3">
                                                                    <h3 class="ml-lg-3 fonttitle font-weight-900"><%=obj.getTitle()%></h3>
                                                                    <h5 class="ml-lg-3 fontprice font-weight-600">Price : <span>&#x20b9</span><%=obj.getPrice()*obj.getQuantity() %></h5>
                                                                    <h4 class="ml-lg-3 fontquantity  font-weight-500">Quantities : <%=obj.getQuantity()%></h4>
                                                                    <h5 class="ml-lg-3 fontsize">Size : <%=obj.getSize()%></h5>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                        <%
                                            }
                                        }
                                %>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <hr class="border-primary 
                            <%if(session.getAttribute("cart")!=null ) {%>
                            col-xl-8 col-md-8 col-lg-8 col-sm-12 p-0
                            <%}%>
                            ">
                        <%if(session.getAttribute("cart")!=null ) 
                        { 
                        %>
                            <div class="row d-flex d-inline justify-content-center">
                                <div class="col-xl-8 col-md-8 col-lg-8 col-sm-12">
                                    <div>
                                        <p><a class="btn btn-primary next float-right text-uppercase text-light">next</a></p>
                                        <p><a class="btn btn-primary previous float-left text-uppercase text-light">Previous</a></p>
                                    </div>
                                </div>
                            </div>
                        <% 
                        }
                        else
                        {
                        %>
                            <p><a class="btn btn-primary next float-right text-uppercase text-light">next</a></p>
                            <p><a class="btn btn-primary previous float-left text-uppercase text-light">Previous</a></p>
                        <% }%>  
                    </fieldset>
                    <fieldset id="fourth">
                        <hr class="border-primary 
                            <%if(session.getAttribute("cart")!=null ) {%>
                            col-xl-8 col-md-8 col-lg-8 col-sm-12 p-0
                            <%}%>
                            ">
                        <div class="card card-body border-0 border-primary" style="background: transparent;">
                            <h3 class="text-primary h1 text-center font4 font-weight-700">Confirm Your Order</h3>
                            <div class="row justify-content-center">
                                <%
                                    if(session.getAttribute("cart")==null)
                                    {
                                %>
                                <div class="col-xl-8 col-12 col-md-12 col-sm-12 p-0 card card-body">
                                    <div class="row">
                                            <div class="col-xl-6 col-md-6 col-sm-12 text-center d-flex align-items-center justify-content-center m-auto">
                                                <img src="<%=session.getAttribute("buynowlocation") %>" class="img-fluid" style="width: 60%;">
                                            </div>
                                            <div class="col-xl-6 col-md-6 col-sm-12 d-flex align-items-center">
                                                <div class="card card-body border-0">
                                                    <p class="h3 fonttitle font-weight-500"><span class="font-weight-bold"></span><%=session.getAttribute("buynowittitle") %></p><br>
                                                    <p class="h3 fontprice1"><span class="font-weight-bold">Total Price : &#x20b9</span><span class="p"></span></p><br>
                                                    <p class="h3 font6 font-weight-400"><span class="font-weight-bold">No Of Items : </span><span class="q"></span></p><br>
                                                    <p class="h3 fontsize"><span class="font-weight-bold">Size : </span><span><%=session.getAttribute("buynowsize") %></span></p><br>
                                                    <p class="h3 offline font7 font-weight-500"><span class="font-weight-bold">Payment Mode : </span><span class="mode">Cash On Delivery</span></p><br>
                                                    <div class="online font10 font-weight-400">
                                                        <p class="h3"><span class="font-weight-bold">Payment Mode : </span><span class="mode">Online</span></p><br>
                                                        <p class="h3"><span class="font-weight-bold">Payment Status : </span><span class="mode">Success</span></p><br>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
                                </div>  
                                <%
                                    }
                                    else
                                    {
                                    %>
                                        <div class="col-xl-8 col-md-8 col-sm-12">
                                            <div class="row">
                                    <%
                                        int id =Integer.parseInt((String) session.getAttribute("id"));
                                        ArrayList<cartdetails> list = con.getcartdetails(id);
                                        if(list.size()>0)
                                        {
                                            int count = 1;
                                            Iterator<cartdetails> itr = list.iterator();
                                            while(itr.hasNext())
                                            {
                                                cartdetails obj = itr.next();
                                                if(count==1)
                                                {
                                                    out.print("<h2 class='d-flex ml-lg-4 fontprice font-weight-700 mr-3 mt-2 justify-content-end' style='width:100%;'>Total Price :<span>&#x20b9</span>"+totalprice+"</h2>");
//                                                    out.print("Total price : "+totalprice+"");
                                                    count++;
                                                }
                                %>
                                                    <div class="col-xl-6 col-md-6 col-sm-12 mt-4">
                                                        <div class="card card-body border-dark">
                                                            <div class="justify-content-center text-center">
                                                                <img class="img-fluid" width="150" src="<%=obj.getLocation() %>">
                                                                <div class="text-left text-uppercase h3">
                                                                    <h3 class="ml-lg-3 fonttitle font-weight-900"><%=obj.getTitle()%></h3>
                                                                    <h5 class="ml-lg-3 fontprice font-weight-600">Price : <span>&#x20b9</span><%=obj.getPrice()*obj.getQuantity() %></h5>
                                                                    <h4 class="ml-lg-3 fontquantity  font-weight-500">Quantities : <%=obj.getQuantity()%></h4>
                                                                    <h5 class="ml-lg-3 fontsize">Size : <%=obj.getSize()%></h5>
                                                                    <%
                                                                        totalprice = totalprice + (obj.getPrice() * obj.getQuantity());
                                                                    %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                        <%
                                            }
                                        }
                                    %>
                                            </div>
                                        </div>
                                    <%
                                    }
                                %>
                            </div>
                        </div>
                        <input type="hidden" name="ordertype" value="" id="ordertype">
                        <input type="hidden" name="size" value="<%=session.getAttribute("buynowsize") %>">
                        <input type="hidden" name="addressmodes" id="addressmodes" value="new">
                        <hr class="border-primary 
                            <%if(session.getAttribute("cart")!=null ) {%>
                            col-xl-8 col-md-8 col-lg-8 col-sm-12 p-0
                            <%}%>
                            ">
                        <%if(session.getAttribute("cart")!=null ) 
                        { 
                        %>
                            <div class="row d-flex d-inline justify-content-center">
                                <div class="col-xl-8 col-md-8 col-lg-8 col-sm-12">
                                    <div>
                                        <p><input class="btn btn-success float-right text-uppercase text-light" type="submit"name="ordernow" value="Place the Order"></p>
                                        <p><a class="btn btn-primary previous float-left text-uppercase text-light">Previous</a></p>
                                    </div>
                                </div>
                            </div>
                        <% 
                        }
                        else
                        {
                        %>
                            <p><input class="btn btn-success float-right text-uppercase text-light" type="submit"name="ordernow" value="Place the Order"></p>
                            <p><a class="btn btn-primary previous float-left text-uppercase text-light">Previous</a></p>
                        <% }%>  
                        
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <%@include file="footer.html" %>
    <script src="javascript/js.js"></script>
    <script src="bootstrap/js/bootstrap.bundle.js"></script>
    <script src="bootstrap/js/bootstrap.js"></script>
    <script src="jqueryui/jquery-ui.js"></script>
    <script src="validate/validate.js"></script>
    <script>
        var price = <%=session.getAttribute("buynowprice") %>;
        function pricecalculate(data)
        {
            $("#quantityprice").val(0);
            $("#quantityprice").val(data*price);
            $("#q,.q").html("");
            $("#p,.p").html("");
            $("#q,.q").append(data);
            $("#p,.p").append(data*price);
        }
        var santosh;
        var sanprev="";
        function addresscard(data)
        {
            santosh=($('input[type=radio][name=oldaddress]'));
            santosh = santosh.parent(santosh);
            santosh.css("background-color","white");
            if(data == true)
            {
                $("#addnewaddressbtn").fadeIn();
                $("#newaddress").slideUp();
                $("input:radio[name='oldaddress']").each(function(i) {
                    this.required = true;
                 });
                 santosh=($('input[type=radio][name=oldaddress]:checked').attr('id'));
                 santosh=$("#"+santosh).parent();
                 santosh.css("background-color","skyblue");
                 $("#addressmodes").val("old");
            }
            else
            {
                $("#addnewaddressbtn").fadeOut();
                $("#newaddress").slideDown();
                $("input:radio[name='oldaddress']").each(function(i) 
                {
                    this.checked = false;
                    this.required = false;
                });
                $("#addressmodes").val("new");
            }
        }
    </script>
    <script>
        function removeaddress(data)
        {
            var s = confirm("Do you want to delete this address permanantly!!!");
            if(s)
            {
                $.ajax({
                   url: "loadajax",
                   type: 'POST',
                   data: "type=addressiddelete&id="+data,
                   success: function (data1) 
                   {
                        if(data1=="success")
                        {
                            $("#deleteaddressid"+data).slideUp();
                        }
                        else
                        {
                            alert("Something wents wrong");
                        }
                   }
                });
            }
        }
    </script>
    <script>
        $("#radioset").buttonset();
        $("#radioset1").buttonset();
        function pay(data) {
            if (data === "online") {
                $("#payment").slideDown();
                $("#ordertype").val(data);
                $(".offline").hide();
                $(".online").show();
            }
            else if (data === "offline") {
                $("#payment").slideUp();
                $("#ordertype").val(data);
                $(".online").hide();
                $(".offline").show();
            }
        }
    </script>
    <script>
        $(".first").addClass("step-active");
    </script>
    <% 
        if (session.getAttribute("id") != null) {
        %>
    <script>
        $(".first").addClass("step-success");
        $(".first").removeClass("step-active");
        $(".second").addClass("step-active");
        $(".next").click(function () {
            window.scrollTo(0, 0); 
            var form = $("#myform");
            jQuery.validator.addMethod("mobile", function (value, element) {
                return /^[6789][0-9]{9}$/.test(value.trim());
            }, "Enter valid mobile number.");
            form.validate({
                errorPlacement: function (error, element) {
                    if (element.is(":radio")) {
                        error.appendTo(element.parents("#radioset"));
                    } else {
                        error.insertAfter(element);
                    }
                },
                errorElement: 'span',
                errorClass: 'error',
                highlight: function (element, errorClass, validClass) {
                    $(element).closest('.form-control').addClass("form-control1");
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).closest('.form-control').removeClass("form-control1");
                },
                rules: {
                    phone: {
                        mobile: true
                    },
                    quantity:{
                        required:true,
                        min:1
                    },
                    cardnumber:{
                        required:true,
                        number:true,
                        minlength:12,
                        maxlength:12,
                    },
                    mm:{
                        required:true,
                        min:1,
                        max:12
                    },
                    yy:{
                        required:true,
                        min:19,
                        max:50
                    },
                    ccv:{
                        required:true,
                        minlength:3
                    }
                },
                messages:
                    {
                        cardnumber:{
                        required:"",
                        number:"",
                        minlength:"",
                        maxlength:""
                        },
                        quantity:{
                          min:"minimum quantity is 1"  
                        },
                        mm:{
                            required:"",
                            min:"",
                            max:""
                        },
                        yy:{
                            required:"",
                            min:"",
                            max:""
                        },
                        ccv:{
                            required:"",
                            minlength:""
                        }
                    }
            });
            if (form.valid() === true) {
                if ($('#first').is(":visible")) {
                    $(".first").removeClass("step-active step-error");
                    $(".first").addClass("step-success");
                    $(".second").addClass("step-active");
                    current_fs = $('#first');
                    next_fs = $('#second');
                } else
                    if ($('#second').is(":visible")) {
                        $(".second").addClass("step-success");
                        $(".second").removeClass("step-active step-error");
                        $(".third").addClass("step-active");
                        current_fs = $('#second');
                        next_fs = $('#third');
                    } else if ($('#third').is(':visible')) {
                        $(".third").addClass("step-success");
                        $(".third").removeClass("step-active step-error");
                        $(".forth").addClass("step-active");
                        current_fs = $('#third');
                        next_fs = $('#fourth');
                    }
                next_fs.slideDown();
                current_fs.slideUp();
            } else {
                if ($('#first').is(":visible")) {
                    $(".first").addClass("step-error");
                } else
                    if ($('#second').is(":visible")) {
                        $(".second").addClass("step-error");
                    } else
                        if ($('#third').is(":visible")) {
                            $(".third").addClass("step-error");
                        }
            }
        });
        $('.previous').click(function () {
            window.scrollTo(0, 0);
            if ($('#second').is(":visible")) {
                $(".second").removeClass('step-active step-error');
                $(".first").removeClass("step-success");
                $(".first").addClass('step-active');
                current_fs = $('#second');
                next_fs = $('#first');
            } else if ($('#third').is(":visible")) {
                $(".third").removeClass('step-active step-error');
                $(".second").removeClass("step-success");
                $(".second").addClass('step-active');
                current_fs = $('#third');
                next_fs = $('#second');
            } else if ($('#fourth').is(":visible")) {
                $(".forth").removeClass('step-active step-error');
                $(".third").removeClass("step-success");
                $(".third").addClass('step-active');
                current_fs = $('#fourth');
                next_fs = $('#third');
            }
            next_fs.slideDown();
            current_fs.slideUp()();
        });
    </script>
    <%
            }
        %>
    <script>
        function states(state) {
            if (state != "") {
                $.ajax({
                    url: "addressajax",
                    type: 'POST',
                    data: "state=" + state,
                    success: function (data) {

                        $("#state").html(data);
                    }
                });
            } else {
                $("#state").html("<option value=''>Choose Country</option>");
                $("#dist").html("<option value=''>Choose State</option>");
            }
        }
        function cities(city) {
            $.ajax({
                url: "addressajax",
                type: 'POST',
                data: "city=" + city,
                success: function (data) {
                    $("#dist").html(data);
                }
            });
        }
    </script>
</body>
</html>