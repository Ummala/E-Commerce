package comm.servlets;

import comm.classes.email;
import comm.classes.connection;
import comm.classes.fileupload;
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


@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet 
{
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
       
        if(request.getParameter("submitlogin")!=null)
        {
            String username = request.getParameter("name");
            String password = request.getParameter("password");
            boolean check=true;
            try
            {
                String qry = "SELECT id,email,password,fname,lname,phone FROM `cregistration` WHERE `email` LIKE '"+username+"' AND `password` LIKE '"+password+"'";
                connection obj = new connection();
                HttpSession session=request.getSession();
                Statement st;
                ResultSet rs;
                st=obj.con.createStatement();
                rs = st.executeQuery(qry);
                while(rs.next())
                {
                    if(username.equalsIgnoreCase(rs.getString("email")) && password.equals(rs.getString("password")))
                    {
                        if(username.equalsIgnoreCase("admin@gmail.com"))
                        {
                            check = false;
                            session.setAttribute("adminid", rs.getString("id"));
                            session.setAttribute("username", rs.getString("email"));
                            session.setAttribute("name", rs.getString("fname")+" "+rs.getString("lname"));
                            session.setAttribute("password", rs.getString("password"));
                            response.sendRedirect("/itemdelivery/Admin/Home");
                        }
                        else
                        {
                            check = false;
                            session.setAttribute("id", rs.getString("id"));
                            session.setAttribute("uphone",rs.getString("phone") );
                            session.setAttribute("uemail", rs.getString("email"));
                            session.setAttribute("ufname", rs.getString("fname"));
                            session.setAttribute("ulname", rs.getString("lname"));
                            session.setAttribute("upassword", rs.getString("password"));
                            String path = (String) session.getAttribute("path");
                            session.setAttribute("path",null);
                            if(path!=null)
                            {
                                response.sendRedirect(path);
                            }
                            else
                            {
                                response.sendRedirect("/itemdelivery/");
                            }
                        }
                    }
                }
                if(check)
                {
                    request.setAttribute("error", "y");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                request.setAttribute("error", "y");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
        else
        {
            request.setAttribute("error", null);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        request.setAttribute("error", null);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
