package comm.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class items extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException
    {
        HttpSession session = request.getSession();
        try
        {
            if(request.getParameter("Cartlist")!=null)
            {
                if(session.getAttribute("id")!=null)
                {
                    request.getRequestDispatcher("cartlist.jsp").forward(request, response);
                }
                else
                {
                    request.getRequestDispatcher("page?name=login").forward(request, response);
                }
            }
            if(request.getParameter("myorder")!=null)
            {
                if(session.getAttribute("id")==null)
                {
                    request.getRequestDispatcher("page?name=login").forward(request, response);
                }
                request.getRequestDispatcher("ordercompletepage.jsp").forward(request, response);
            }
            if(request.getParameter("itemid")!=null)
            {
                request.getRequestDispatcher("itemdetail.jsp").forward(request, response);
            }
            if(request.getParameter("BuyNow")!=null)
            {
                request.getRequestDispatcher("buynow.jsp").forward(request, response);
            }
            if(request.getParameter("search")!=null || request.getParameter("search").trim()!="")
            {
                request.getRequestDispatcher("search.jsp").forward(request, response);
            }
        }
        catch(Exception e)
        {
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(items.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(items.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    public String getServletInfo() 
    {
        return "Short description";
    }
}
