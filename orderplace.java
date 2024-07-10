package comm.servlets;

import comm.classes.cartlist;
import comm.classes.connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;


public class orderplace extends HttpServlet 
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        connection con = new connection();
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");
        try
        {
            if(request.getParameter("buynow")!=null || session.getAttribute("buynowlogin")!=null)
            {
                session.setAttribute("cart", null);
                String id = request.getParameter("itemid");
                String color = request.getParameter("choosecolor");
                String size = request.getParameter("size");
                
                if(request.getParameter("buynow")!=null)
                {
                    session.setAttribute("buynowid", id);
                    session.setAttribute("buynowchoosecolor", color);
                    session.setAttribute("buynowsize", size);
                    session.setAttribute("buynowlogin", "true");
                    ResultSet rs = con.getbuynowdata(id,color,size);
                    while(rs.next())
                    {
                        session.setAttribute("buynowittitle", rs.getString("title"));
                        session.setAttribute("buynowprice", rs.getString("cost"));
                        session.setAttribute("buynowbrand", rs.getString("brand"));
                        session.setAttribute("buynowlocation", rs.getString("location"));
                    }
                    response.sendRedirect("items?BuyNow");
                }
                else
                {
                    id = (String)session.getAttribute("buynowid");
                    color = (String)session.getAttribute("buynowchoosecolor");
                    size = (String)session.getAttribute("buynowsize");
                    ResultSet rs = con.getbuynowdata(id,color,size);
                    while(rs.next())
                    {
                        session.setAttribute("buynowittitle", rs.getString("title"));
                        session.setAttribute("buynowprice", rs.getString("cost"));
                        session.setAttribute("buynowbrand", rs.getString("brand"));
                        session.setAttribute("buynowlocation", rs.getString("location"));
                    }
                    response.sendRedirect("items?BuyNow");
                }
                
            }
            if(request.getParameter("buycartlist")!=null)
            {
                session.setAttribute("buynowlogin", null);
                session.setAttribute("cart", "yes");
                response.sendRedirect("items?BuyNow");
            }
            if(request.getParameter("addtocart")!=null || session.getAttribute("comeback")!=null)
            {
                String id = request.getParameter("itemid");
                String color = request.getParameter("choosecolor");
                String size = request.getParameter("size");
                String colorids = request.getParameter("colorids");
                if(session.getAttribute("id")!=null)
                {
                    if(session.getAttribute("comeback")!=null)
                    {
                        session.setAttribute("path", null);
                        session.setAttribute("comeback",null);
                        id = (String) session.getAttribute("cartid");
                        color =(String) session.getAttribute("cartcolor");
                        size =(String) session.getAttribute("cartsize");
                        colorids =(String) session.getAttribute("colorids");
                        String status = con.addtocart(id,color,size, session);
                        if(status.equals("succes"))
                        {
                            session.setAttribute("cartstatus", "This item is added to the cart successfully, <strong><a class='alert-link' href='items?Cartlist' target= '_blank'>Check it out</a>.</strong>");
                            if(colorids != "0" || colorids != null)
                            {
                                if(colorids.equals("0"))
                                {
                                    response.sendRedirect("items?itemid="+id);
                                }
                                else
                                {
                                    response.sendRedirect("items?itemid="+id+"&currentcolorcode="+colorids);
                                }
                            }
                            else
                            {
                                response.sendRedirect("items?itemid="+id);
                            }
                        }
                    }
                    else
                    {
                        String status = con.addtocart(id,color,size, session);
                        if(status.equals("succes"))
                        {
                            session.setAttribute("cartstatus", "This item is added to the cart successfully, <strong><a class='alert-link' href='cartlist.jsp' target= '_blank'>Check it out</a>.</strong>");
                            if(colorids != "0" || colorids != null)
                            {
                                if(colorids.equals("0"))
                                {
                                    response.sendRedirect("items?itemid="+id);
                                }
                                else
                                {
                                    response.sendRedirect("items?itemid="+id+"&currentcolorcode="+colorids);
                                }
                            }
                            else
                            {
                                response.sendRedirect("items?itemid="+id);
                            }
                        }
                    }
                }
                else
                {
                    session.setAttribute("cartid", id);
                    session.setAttribute("cartcolor", color);
                    session.setAttribute("cartsize", size);
                    session.setAttribute("comeback", "true");
                    session.setAttribute("path", "orderplace");
                    session.setAttribute("colorids", colorids);
//                    request.getRequestDispatcher("page?name=login");
                    response.sendRedirect("page?name=login");
                }
            }
        }
        catch(Exception e)
        {
            
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() 
    {
        return "Short description";
    }
}
