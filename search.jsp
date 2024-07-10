<%@page import="java.sql.ResultSet"%>
<%@page import="comm.classes.connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Searched Items</title>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="bootstrap/css/bootstrap-grid.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
        <style>
            body{
                background-image: url(images/bg/8.png) ;
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
            }
            .card1 
            {
                width: 350px;
                height: 600px;
                border-radius: 15px;
                padding: 1.5rem;
                background: white;
                position: relative;
                display: -webkit-box;
                display: flex;
                -webkit-box-align: end;
                align-items: flex-end;
                -webkit-transition: 0.4s ease-out;
                transition: 0.4s ease-out;
                box-shadow: 0px 7px 10px rgba(0, 0, 0, 0.3);
            }
            .card1:hover 
            {
                -webkit-transform: translateY(20px);
                transform: translateY(20px);
            }
            .card1:hover:before 
            {
                opacity: 1;
            }
            .card1:hover .info1 
            {
                opacity: 1;
                -webkit-transform: translateY(0px);
                transform: translateY(0px);
            }
            .card1:before 
            {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                display: block;
                width: 100%;
                height: 100%;
                border-radius: 15px;
                background: rgba(0, 0, 0, 0.6);
                z-index: 2;
                -webkit-transition: 0.5s;
                transition: 0.5s;
                opacity: 0;
            }
            .card1 img 
            {   
                margin-top: 20px;
                width: 100% auto ;
                height: 90% ;
                -o-object-fit: cover;
                object-fit: fill;
                position: absolute;
                top: 0;
                left: 0;
                border-radius: 15px;
            }
            .card1 .info1 
            {
                position: relative;
                z-index: 3;
                color: white;
                opacity: 0;
                -webkit-transform: translateY(50px);
                transform: translateY(50px);
                -webkit-transition: 0.5s;
                transition: 0.5s;
            }
            .card1 .info1 h1 
            {
                margin: 0px;
            }
            .card1 .info1 p 
            {
                letter-spacing: 1px;
                font-size: 20px;
                margin-top: 15px;
            }
            .vh-70{
                height: 70vh;
            }
        </style>
    </head>
    <body class=" user-select-none">
    <%@include file="header.jsp" %>
    <div class="container-fluid mr-auto">
        
        <div class="row p-3">
            <%
                connection con = new connection();
                String searchdata = request.getParameter("search");
                if(searchdata!=null && searchdata.trim() !="")
                {
                    int check=0;
                    String[] ss = searchdata.split(" ");
                    if(ss.length>0)
                    {
                        ResultSet rs = con.searchdata(ss,con);
                        while(rs.next())
                        {
                            check++;
                            %>
                                <div class="col-xl-3 col-lg-4 d-flex justify-content-center col-md-6 col-sm-12">
                                    <div class="card1" style="margin-bottom: 50px !important; margin-top: 10px !important;">
                                        <img src="<%=rs.getString("images") %>" class="img-fluid" />
                                        <div class="info1">
                                            <p class="fonttitle font-weight-500"><%=rs.getString("title") %></p>
                                            <strong class="mb-5 ml-auto fontprice"><h4 class=""><span>&#x20b9</span><%=rs.getString("cost") %></h4></strong>
                                            <form action="items">
                                                <input type="hidden" name="itemid" value="<%=rs.getInt("id")%>">
                                                <div class="">
                                                    <button class="btn btn-info" type="submit">Full Details</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            <%
                        }
                        if(check==0)
                        {
                            %>
                                <div class="vh-70 d-flex justify-content-center align-items-center m-auto">
                                    <div class="text-center text-primary h2">
                                        No Search results for the Keywords '<span style="font-weight: 600"><%=request.getParameter("search")%></span>'
                                    </div>
                                </div>
                            <%
                        }
                    }
                }
                else
                {
                    %>
                        <div class="vh-70 d-flex justify-content-center align-items-center m-auto">
                            <div class="text-center text-primary h2">
                                Search Something, that should appears hear.
                            </div>
                        </div>
                    <%
                }
            %>            
        </div>
    </div>
    <%@include file="footer.html" %>
    <script src="javascript/js.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.bundle.js" type="text/javascript"></script>
    </body>
</html>