package comm.ajax;
import comm.classes.connection;
import comm.classes.getmoredetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class loadajax extends HttpServlet 
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException, JSONException, SQLException 
    {
        connection con = new connection();
        JSONObject jobj = new JSONObject();
        JSONArray jarr = new JSONArray();
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            String type = request.getParameter("type");
            if(type.equals("itemdetails"))
            {
                int id = Integer.parseInt(request.getParameter("itemid"));
                ArrayList<getmoredetails> list;
                list = con.getmoredetails(id);
                if(list.size()>0)
                {
                    Iterator<getmoredetails> itr = list.iterator();
                    while (itr.hasNext()) 
                    {                        
                        getmoredetails s = itr.next();
                        JSONObject arro = new JSONObject();
                        arro.put("description", s.getDescription());
                        arro.put("details", s.getDetails());
                        jarr.put(arro);
                    }
                    jobj.put("itemdetaisl", jarr);
                    out.print(jobj);
                }
            }
            if(type.equals("addressiddelete"))
            {
                String id = request.getParameter("id");
                int i = con.deleteaddressid(id);
                if(i>0)
                {
                    out.print("success");
                }
                else
                {
                    out.print("fail");
                }
            }
            if(type.equals("deleteuser"))
            {
                String id = request.getParameter("id");
                int i = con.deleteuserid(id);
                if(i>0)
                {
                    out.print("success");
                }
                else
                {
                    out.print("fail");
                }
            }
            if(type.equals("updatestatus"))
            {
                String id = request.getParameter("id");
                int i = con.updatestatus(id);
                if(i>0)
                {
                    out.print("success");
                }
                else
                {
                    out.print("fail");
                }
            }
            if(type.equals("faqs"))
            {
                ResultSet rs = con.getfaq();
                while(rs.next())
                {
                    JSONObject j = new JSONObject();
                    j.put("q", rs.getString(2));
                    j.put("a", rs.getString(3));
                    jarr.put(j);
                }
                jobj.put("r",jarr);
                out.print(jobj);
            }
            if(type.equals("cancelorder"))
            {
                String id = request.getParameter("id");
                int i = con.cancelorder(id);
                if(i>0)
                {
                    out.print("success");
                }
                else
                {
                    out.print("fail");
                }
            }
            if(type.equals("updatecomplain"))
            {
                String id = request.getParameter("id");
                String msg = request.getParameter("msg");
                int i = con.updatecomplain(id,msg);
                if(i>0)
                {
                    out.print("success");
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
            Logger.getLogger(loadajax.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(loadajax.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        try {
            processRequest(request, response);
        } catch (JSONException ex) {
            Logger.getLogger(loadajax.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(loadajax.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    public String getServletInfo() 
    {
        return "Short description";
    }
}
