package admin.com.servalet;

import comm.classes.connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Enumeration;


public class adminpage extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            
            HttpSession session = request.getSession();
            String path = request.getParameter("url");
            if(path.equals("login"))
            {
                if(request.getParameter("submitlogin")!=null)
                {
                    String name = request.getParameter("name");
                    String password = request.getParameter("password");
                    connection con = new connection();
                    Statement st;
                    ResultSet rs;
                    st = con.con.createStatement();
                    boolean check =true;
                    String q = "SELECT * FROM `adminlogin` WHERE username LIKE '"+name+"' AND password LIKE '"+password+"';";
                    rs = st.executeQuery(q);
                    
                    while(rs.next())
                    {
                        if(name.equalsIgnoreCase(rs.getString("username")) && password.equals(rs.getString("password")))
                        {
                            check = false;
                            session.setAttribute("adminid", rs.getString("id"));
                            session.setAttribute("username", rs.getString("username"));
                            session.setAttribute("name", rs.getString("name"));
                            session.setAttribute("password", rs.getString("password"));
                            response.sendRedirect("/itemdelivery/Admin/Home");
                        }
                    }
                    if(check)
                    {
                        request.setAttribute("error", "y");
                        request.getRequestDispatcher("adminpage?url=loginfail").forward(request, response);
                    }
                }
                else
                {
                    request.setAttribute("error", null);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            }
            if(path.equals("loginfail"))
            {
                request.setAttribute("error", "y");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            if(path.equals("forgot"))
            {
                request.getRequestDispatcher("forgot.jsp").forward(request, response);
            }
            if(path.equals("register"))
            {
                request.getRequestDispatcher("asp.jsp").forward(request, response);
            }
            if(path.equals("changepassword"))
            {
                request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            }
            if(path.equals("logout"))
            {
                session.removeAttribute("id");
                session.invalidate();
                response.sendRedirect("/itemdelivery/");
                
            }
            if(path.equals("sendlink"))
            {
                if(request.getParameter("sendlink")!=null)
                {
                    String s = request.getParameter("email");
                    connection con = new connection();
                    if(con.check(s, con))
                    {
                        request.setAttribute("success","Re-set Link send to your mail successfully.<a href=\"/itemdelivery/Admin\" class=\"alert-link text-decoration-none\"> Go Back</a>");
                        request.getRequestDispatcher("forgot.jsp").forward(request, response);
                    }
                    else
                    {
                        request.setAttribute("error","Invalid E-mail ID");
                        request.getRequestDispatcher("forgot.jsp").forward(request, response);
                    }
                }
                else
                {
                    request.setAttribute("success",null);
                    request.setAttribute("error",null);
                    request.getRequestDispatcher("forgot.jsp").forward(request, response);
                }
            }
            if(path.equals("change"))
            {
                if(request.getParameter("change")!=null)
                {
                    String opass = request.getParameter("npass");
                    String npass = request.getParameter("pass");
                    String cpass = request.getParameter("rpass");
                    if(!opass.equals("")&& opass.equals(session.getAttribute("password")))
                    {
                        if(npass.equals(cpass) && !npass.equals(""))
                        {
                            connection con = new connection();
                            if(con.change(cpass, con, session)>0)
                            {
                                request.setAttribute("success","Password Changed Successfully.<a href=\"/itemdelivery/Admin/Home\" class=\"alert-link text-decoration-none\"> Back to Home</a>");
                                request.setAttribute("error",null);
                                session.setAttribute("password",cpass);
                                request.getRequestDispatcher("changepassword.jsp").forward(request, response);
                            }
                            else
                            {
                                request.setAttribute("success",null);
                                request.setAttribute("error","Something Wents Wrong");
                                request.getRequestDispatcher("changepassword.jsp").forward(request, response);
                            }
                        }
                        else
                        {
                            request.setAttribute("success",null);
                            request.setAttribute("error","Something Wrong in new password and Confirm password");
                            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
                        }
                    }
                    else
                    {
                        request.setAttribute("success",null);
                        request.setAttribute("error","Wrong Old password");
                        request.getRequestDispatcher("changepassword.jsp").forward(request, response);
                    }
                }
                else
                {
                    request.setAttribute("success",null);
                    request.setAttribute("error",null);
                    request.getRequestDispatcher("changepassword.jsp").forward(request, response);
                }
            }
            if(path.equals("AddItem"))
            {
                request.getRequestDispatcher("additem.jsp").forward(request, response);
            }
            if(path.equals("Users"))
            {
                request.getRequestDispatcher("allusers.jsp").forward(request, response);
            }
            if(path.equals("PendingLists"))
            {
                request.getRequestDispatcher("orderpending.jsp").forward(request, response);
            }
            if(path.equals("OrderedLists"))
            {
                request.getRequestDispatcher("passedorder.jsp").forward(request, response);
            }
            if(path.equals("ItemLists"))
            {
                request.getRequestDispatcher("itemdetails.jsp").forward(request, response);
            }
            if(path.equals("ComplaintBox"))
            {
                request.getRequestDispatcher("complaintbox.jsp").forward(request, response);
            }
            if(path.equals("unavailableitems"))
            {
                request.getRequestDispatcher("unavailableitems.jsp").forward(request, response);
            }
            if(path.equals("carousel"))
            {
                request.getRequestDispatcher("carousel.jsp").forward(request, response);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
