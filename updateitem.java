package comm.ajax;
import comm.classes.connection;
import comm.classes.subimages;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
public class updateitem extends HttpServlet 
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException, JSONException, SQLException 
    {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            connection con = new connection();
            if(request.getParameter("itemupdate")!=null)
            {
                String itemid = request.getParameter("itemid");
                String column = request.getParameter("column");
                String msg = request.getParameter("msg");
                if(itemid.equals("") || column.equals("") || msg.equals("") || itemid==null || column==null || msg ==null || msg.equals("null"))
                {
                    out.print("field is empty");
                }
                else
                {
                    String q = null;
                    if(column.equals("1"))
                    {
                        q = "UPDATE `items` SET `title` = '"+msg+"' WHERE `items`.`id` = "+itemid+";";
                    }
                    else 
                    if(column.equals("2"))
                    {
                        q = "UPDATE `items` SET `cost` = '"+msg+"' WHERE `items`.`id` = "+itemid+";";
                    }
                    else 
                    if(column.equals("3"))
                    {
                        q = "UPDATE `items` SET `brand` = '"+msg+"' WHERE `items`.`id` = "+itemid+";";
                    }
                    else 
                    if(column.equals("4"))
                    {
                        q = "UPDATE `items` SET `size` = '"+msg+"' WHERE `items`.`id` = "+itemid+";";
                    }
                    else
                    if(column.equals("5"))
                    {
                        q = "UPDATE `items` SET `type` = '"+msg+"' WHERE `items`.`id` = "+itemid+";";
                    }
                    else 
                    if(column.equals("6"))
                    {
                        q = "UPDATE `items` SET `searches` = '"+msg+"' WHERE `items`.`id` = "+itemid+";";
                    }
                    else 
                    if(column.equals("7"))
                    {
                        try
                        {
                            Statement st = con.con.createStatement();
                            String sql = "UPDATE `cart` SET `itemstatus` = '"+msg+"' WHERE `cart`.`itemid` = "+itemid+" AND status LIKE 'pending';";
                            int i = st.executeUpdate(sql);
                            System.out.println(sql+" "+i);
                        }
                        catch(Exception e)
                        {
                            e.printStackTrace();
                        }
                        q = "UPDATE `items` SET `status` = '"+msg+"' WHERE `items`.`id` = "+itemid+";";
                    }
                    if(q==null)
                    {
                        out.print("fail");
                    }
                    else
                    {
                        int i = con.updateitem(q);
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
            if(request.getParameter("getsubimages")!=null)
            {
                JSONObject jobj = new JSONObject();
                JSONArray jarr = new JSONArray();
                String id = request.getParameter("itemid");
                ArrayList<subimages> sub  = con.getsubimages(id);
                if(sub.size()>0)
                {
                    Iterator<subimages> itr = sub.iterator();
                    while(itr.hasNext())
                    {
                        JSONObject job = new JSONObject();
                        subimages ss = itr.next();
                        job.put("id", ss.getId());
                        job.put("color", ss.getColor());
                        job.put("status", ss.getStatus());
                        job.put("img", ss.getImg());
                        jarr.put(job);
                    }
                    jobj.put("list",jarr);
                    out.println(jobj);
                }
                else
                {
                    out.print("fail");
                }
            }
            if(request.getParameter("subimgstatus")!=null)
            {
                String itemid = request.getParameter("itemid").trim();
                String colorid = request.getParameter("colorid").trim();
                String status = request.getParameter("status").trim();
                if(itemid.equals("")||colorid.equals("")||status.equals(""))
                {
                    out.print("fail");
                }
                else
                {
//                    System.out.println(itemid+" "+colorid+" "+status);
                    int i = con.updatesubimgstatus(itemid,colorid,status);
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
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        try 
        {
            processRequest(request, response);
        } 
        catch (JSONException ex) 
        {
            Logger.getLogger(updateitem.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(updateitem.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        try 
        {
            processRequest(request, response);
        } 
        catch (JSONException ex) 
        {
            Logger.getLogger(updateitem.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(updateitem.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    public String getServletInfo() 
    {
        return "Short description";
    }
}
