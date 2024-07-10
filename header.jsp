<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="comm.classes.connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<link href="https://fonts.googleapis.com/css2?family=Abel&family=Archivo+Black&family=Baloo+Tammudu+2:wght@400;500;600;700;800&family=Bebas+Neue&family=Cabin:wght@400;500;600;700&family=Cardo:wght@400;700&family=Chakra+Petch:wght@300;400;500;600;700&family=Cinzel:wght@400;500;600;700;800;900&family=Cuprum:wght@400;500;600;700&family=El+Messiri:wght@400;500;600;700&family=Fira+Sans:wght@100;200;300;400;500;600;700;800;900&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Mina:wght@400;700&family=Montserrat:wght@100;200;300;400;500;600;700;800;900&family=Nunito:wght@200;300;400;600;700;800;900&family=Oxygen:wght@300;400;700&family=Roboto+Slab:wght@100;200;300;400;500;600;700;800;900&family=Trispace:wght@100;200;300;400;500;600;700;800&family=Vidaloka&family=Volkhov:wght@400;700&display=swap" rel="stylesheet">
<link href="bootstrap/css/font.css" rel="stylesheet" type="text/css"/>
<style>
    button:focus
    {
        border-color: transparent;
    }
    .navbar .dropdown-menu{
        right: 0% !important;
    }
    
    @media screen and (min-width: 992px) {

        .navbar .dropdown:hover .dropdown-menu,
        .navbar .dropdown .dropdown-menu:hover {
            display: block;
            visibility: visible;
            opacity: 1;
            transition: visibility 0s, opacity 0.3s linear;
        }

        .dropdown-menu{
            left: -10%;
            z-index: 99999;
        }

        .navbar .dropdown-menu {
            margin-right: 10px !important;
            border: 1px solid rgba(0, 0, 0, .15);
            box-shadow: 0 0 20px black;
            background-color: #fff;
        }

        .text-decoration-none {
            text-decoration: none;
        }

        .vh-50 {
            height: 50vh !important;
        }
    }

    ::-webkit-scrollbar {
        background: #343a40;
        opacity: 0.3;
        width: 15px;
        border-radius: 10px;
    }

    ::-webkit-scrollbar-track {
        opacity: 0.3;
        background-color: transparent;
        border: 2px solid black;
        box-shadow: inset 0 0 2.5px 2px white;
    }

    ::-webkit-scrollbar-thumb {
        opacity: 0.1;
        background: linear-gradient(45deg, #06dee1, #79ff6c);
        border-radius: 5px;
        cursor: pointer !important;
    }
    #search:focus
    {
        box-shadow: none;
    }
    :root {
        --avatar-size: 50px;
    }
    .circles {
      height : var(--avatar-size);
      text-align: center;
      width : var(--avatar-size);
      background: 
          radial-gradient(circle at 50% 0,
            rgba(255,0,0,.5),
            rgba(255,0,0,0) 70.71%),
          radial-gradient(circle at 6.7% 75%,
            rgba(0,0,255,.5),
            rgba(0,0,255,0) 70.71%),
          radial-gradient(circle at 93.3% 75%,
            rgba(0,255,0,.5),
            rgba(0,255,0,0) 70.71%) beige;
      border-radius: 50%;
    }
    .headerlinks:hover p
    {
        margin: 1px;
        padding: 5px;
        border-radius: 5px;
        border: 2px solid gold;
    }
    .headerlinks p
    {
        margin: 3px;
        padding: 5px;
        border-radius: 5px;
    }
</style>
<script>
    function Searchdata()
    {
        var a = document.getElementById("search").value;
        if(a == null || a == "" || a == " ")
        {
            return false;
        }
        else
        {
            document.searchform.action = "items";
            document.searchform.submit();
            return true;
        }
    }
</script>
<nav class="navbar navbar-expand-lg  navbar-dark bg-dark font-weight-700 font2">
    <a class="navbar-brand" href="/itemdelivery/">
        <img class="img-fluid" style="height: 70px !important; margin-left: 20px;" src="images/3.png">
    </a>
    
    
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ml-auto"  style="margin-top: 12px;">
            <div style="padding:9px;">
                <form name="searchform" onsubmit="return Searchdata();">
                    <div class="input-group">
                        <input type="text" name="search" id="search" class="form-control border-warning" style="border-top-left-radius: 50px; border-bottom-left-radius: 50px; border: 2px solid #ffc107 !important;" placeholder="Search your items here" aria-label="Recipient's username" aria-describedby="basic-addon2">
                        <div class="input-group-append">
                            <button  style="border-top-right-radius: 50px;outline: none; border-bottom-right-radius: 50px;" class="input-group-text bg-warning border-warning" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
            <%!String id, fname;%>
            <%
                id = (String) session.getAttribute("id");
                if (id == null) {
            %>
            
                <li class="nav-item p-2">
                    <a class="nav-link active" href="page?name=login">Sign in</a>
                </li>
                <li class="nav-item p-2">
                    <a class="nav-link" href="page?name=register">Sign up</a>
                </li>
            <%
                }
                if (id != null ) {
                    fname = (String) session.getAttribute("ufname");
            %>
            <li class="nav-item dropdown p-2 active font-weight-700 font6">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Welcome <%=fname%>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="items?myorder" target="_blank"><i class="fal fa-bags-shopping"></i> My orders</a>
                    <a class="dropdown-item" href="page?name=Profile"><i class="fal fa-address-card"></i> Profile</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="Logout"><i class="fal fa-sign-out-alt"></i> Logout</a>
                </div>
            </li>
            <li class="nav-item p-2">
                <a class="nav-link  text-warning" href="items?Cartlist" target="_blank"><i class="fal fa-cart-plus h3 font-weight-bold"></i></a>
            </li>
            <%
                }
            %>
        </ul>
    </div>
</nav>
    <div class="container-fluid bg-dark text-white sticky-top" style="z-index: 1111;">
    <div class="row justify-content-center">
        <div class="d-flex justify-content-between col-xl-6 col-lg-6 col-md-8 col-sm-11">
            <%
                String q = "SELECT DISTINCT type FROM `items` WHERE 1 ";
                Statement st5;
                ResultSet rs5;
                connection con1 = new connection();
                st5 = con1.con.createStatement();
                rs5 = st5.executeQuery(q);
                while(rs5.next())
                {
                    out.print("<a href='items?search="+rs5.getString(1)+"' class='font-weight-700 font6 text-decoration-none text-white text-capitalize headerlinks'><p>"+rs5.getString(1)+"</p></a>");
                }
            %>
        </div>
    </div>   
</div>
