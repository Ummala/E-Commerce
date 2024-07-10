package admin.com.servalet;
import comm.classes.connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class cartservalet extends HttpServlet 
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException, JSONException 
    {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            connection con = new connection();
            String type = request.getParameter("type");
            if(type.equals("minus"))
            {
                String id =(String) request.getParameter("id");
                int q =Integer.parseInt((String) request.getParameter("q"));
                int minus = q-1;
                int result = con.updateq(id,minus);
                if(result>0)
                {
                    out.print(minus);
                }
                else
                {
                    out.print("fail");
                }
            }
            if(type.equals("plus"))
            {
                String id =(String) request.getParameter("id");
                int q =Integer.parseInt((String) request.getParameter("q"));
                int minus = q+1;
                int result = 0;
                result = con.updateq(id,minus);
                if(result>0)
                {
                    out.print(minus);
                }
                else
                {
                    out.print("fail");
                }
            }
            if(type.equals("remove"))
            {
                int id =Integer.parseInt((String) request.getParameter("id"));
                int result = con.removecart(id);
                if(result>0)
                {
                    out.print(result);
                }
                else
                {
                    out.print("fail");
                }
            }            
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(cartservalet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(cartservalet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    public String getServletInfo() 
    {
        return "Short description";
    }
}
