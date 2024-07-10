package comm.servlets;

import comm.classes.connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
public class validateregister extends HttpServlet 
{

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException, SQLException 
    {
        HttpSession session = request.getSession();
        if(request.getParameter("submitform")!=null)
        {
            int status = 0;
            try
            {
                String fname = request.getParameter("fname").trim();
                String lname = request.getParameter("lname").trim();
                String email = request.getParameter("email").trim();
                String phone = request.getParameter("phone").trim();
                String gender = request.getParameter("gender").trim();
                System.out.println(gender);
                String password = request.getParameter("password").trim();
                connection con = new connection();
                Statement st = (Statement) con.con.createStatement();
                String qry = "INSERT INTO `cregistration`(`id`, `fname`, `lname`, `email`, `phone`, `gender`, `password`, `date`) VALUES ("+null+",'"+fname+"','"+lname+"','"+email+"','"+phone+"','"+gender+"','"+password+"',now())";
                status = st.executeUpdate(qry);
                if(status>0)
                {
                    session.setAttribute("regsuccess","yes");
                    session.setAttribute("regerror",null);
                    response.sendRedirect("page?name=register");
                }
                else
                {
                    session.setAttribute("regerror","yes");
                    session.setAttribute("regsuccess",null);
                    response.sendRedirect("page?name=register");            
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
                session.setAttribute("regerror","yes");
                session.setAttribute("regsuccess",null);
                response.sendRedirect("page?name=register");  
            }
        }
        else
        {
            session.setAttribute("regerror",null);
            session.setAttribute("regsuccess",null);
            response.sendRedirect("page?name=register");     
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(validateregister.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(validateregister.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() 
    {
        return "Short description";
    }

}
