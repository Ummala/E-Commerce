package comm.servlets;


import comm.classes.connection;
import comm.classes.email;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;


@WebServlet(name = "page", urlPatterns = {"/page"})
public class page extends HttpServlet 
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        try 
        {
            HttpSession session = request.getSession();
            String path = (String) request.getParameter("name");
            if (path.equals("forgettenpassword")) 
            {
                if(request.getParameter("submit")!=null)
                {
                    String email = request.getParameter("email");
                    if(email == null)
                    {
                        request.setAttribute("erroremail", null);
                        request.setAttribute("validemail", null);
                        request.getRequestDispatcher("forgettenpassword.jsp").forward(request, response);
                    }

                    else
                    {
                        connection con = new connection();
                        Statement st;
                        ResultSet rs;
                        st=(Statement) con.con.createStatement();
                        String q = "SELECT id FROM `cregistration` WHERE email LIKE '"+email+"' AND email NOT LIKE 'admin@gmail.com'";
                        rs = st.executeQuery(q);
                        if(rs.next())
                        {
                            int i = 0;
                            i = con.acceptresetpassword(email,con,session);
                            if(i>0)
                            {
                                String name = con.getname(email,con);
                                final StringBuilder sb = new StringBuilder("<html> ");
                                sb.append("<body>");
                                sb.append("<div style='width: 70%; height: auto;margin: 60px auto; padding: 20px; border: 6px solid lightblue; border-radius: 10px;'>");
                                sb.append("<h2 style='margin-bottom: 20px;'>Hello, "+name+"</h2>");
                                sb.append("<p style='margin-bottom: 20px;'>You are requested for reset password.Please click the below button and reset your password here.</p>");
                                sb.append("<button style='border: none; padding: 5px; margin-bottom: 20px;'><a href='http://localhost:8084/itemdelivery/page?name=reset&email="+email+"&id="+session.getAttribute("fid")+"' style='text-decoration: none; color:blue;font-size: 20px;'>Reset password</a></button>");
                                sb.append("</div>");
                                sb.append("</body>");
                                sb.append("</html>");
                                email e = new email();
                                e.send(sb.toString(), "Reset Password", email);
                                request.setAttribute("erroremail", null);
                                request.setAttribute("validemail", "yes");
                                request.getRequestDispatcher("forgettenpassword.jsp").forward(request, response);
                            }
                            else
                            {
                                request.setAttribute("erroremail", "yes");
                                request.setAttribute("validemail", null);
                                request.getRequestDispatcher("forgettenpassword.jsp").forward(request, response);
                            }
                        }
                        else
                        {
                            request.setAttribute("erroremail", "yes");
                            request.setAttribute("validemail", null);
                            request.getRequestDispatcher("forgettenpassword.jsp").forward(request, response);
                        }
                    }
                }
                else
                {
                    request.setAttribute("erroremail", null);
                    request.setAttribute("validemail", null);
                    request.getRequestDispatcher("forgettenpassword.jsp").forward(request, response);
                }
            }
            if (path.equals("login")) 
            {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            if (path.equals("register")) 
            {
                request.getRequestDispatcher("Registration.jsp").forward(request, response);
            }
            if (path.equals("faq")) 
            {
                request.getRequestDispatcher("faq.jsp").forward(request, response);
            }
            if (path.equals("Dashboard"))
            {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            if (path.equals("Profile"))
            {
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            }
            if (path.equals("reset"))
            {
                try
                {
                    if(request.getParameter("changepassword")!=null)
                    {
                        request.getRequestDispatcher("changepassword").forward(request, response);
                    }
                    else
                    {
                        session.setAttribute("fmail",request.getParameter("email"));
                        session.setAttribute("fid",request.getParameter("id"));
                        response.sendRedirect("page?name=request");
                    }
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
            }
            if(path.equals("request"))
            {
                request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
            }
            if(path.equals("contact"))
            {
                if(request.getParameter("contactus")!=null)
                {
                    request.getRequestDispatcher("connectus").forward(request, response);
                }
                else
                {
                    request.getRequestDispatcher("contactus.jsp").forward(request, response);
                }
            }
            if(path.equals("aboutus"))
            {
                request.getRequestDispatcher("aboutus.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
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

