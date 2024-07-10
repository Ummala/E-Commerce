package comm.servlets;

import comm.classes.connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class changepassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            HttpSession session = request.getSession();
            String pass = request.getParameter("password");
            String cpass = request.getParameter("cpassword");
            if(pass.equals(cpass))
            {
                if(pass=="" || pass == null)
                {
                    request.setAttribute("fail","Password is empty, Please enter your password correctly.");
                    request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
                }
                else
                {
                    connection con = new connection();
                    int i = con.changepassword(pass, session, con);
                    if(i>0)
                    {
                        request.setAttribute("success","Password Changed successfully. Goto <a href='page?name=login' class='alert-link'> Login </a> page");
                        request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
                    }
                    else
                    {
                        request.setAttribute("fail","Your link as been expired.");
                        request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
                    }
                }
            }
            else
            {
                request.setAttribute("fail","Miss Match password, Please enter your password correctly.");
                request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(changepassword.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(changepassword.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
