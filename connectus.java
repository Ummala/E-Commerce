package comm.servlets;

import comm.classes.connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;


public class connectus extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            if(request.getParameter("contactus")!=null)
            {
                String fname = request.getParameter("fname");
                String lname = request.getParameter("lname");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String message = request.getParameter("message");
                connection con = new connection();
                String q = "INSERT INTO `contactus` (`id`, `fname`, `lname`, `email`, `phone`, `msg`) VALUES (NULL, '"+fname+"', '"+lname+"', '"+email+"', '"+phone+"', '"+message+"');";
                int i = con.contactus(q, con);
                if(i>0)
                {
                    request.setAttribute("success", "true");
                    request.getRequestDispatcher("contactus.jsp").forward(request, response);
                }
                else
                {
                    request.setAttribute("error", "true");
                    request.getRequestDispatcher("contactus.jsp").forward(request, response);
                }
                
            }
            else
            {
                request.getRequestDispatcher("contactus.jsp");
            }
        }
    }
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(connectus.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(connectus.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
