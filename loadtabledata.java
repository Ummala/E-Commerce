package comm.ajax;
import comm.classes.connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
public class loadtabledata extends HttpServlet 
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException, JSONException, SQLException 
    {
        connection con = new connection();
        JSONObject jsonobject = new JSONObject();
        JSONArray jsonarray = new JSONArray();
        response.setContentType("text/html;charset=UTF-8");
        String type = request.getParameter("type");
        try (PrintWriter out = response.getWriter())
        {
            if(type.equals("loadallusers"))
            {
                String searchdata = request.getParameter("search[value]").trim();
                String dir = request.getParameter("order[0][dir]");
                String column = request.getParameter("order[0][column]");
                String length = request.getParameter("length");
                String offset = request.getParameter("start");
                String q;
                switch (column) {
                    case "1":
                        q = "WHERE id !=1 AND (id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR gender LIKE '%"+searchdata+"%' OR date LIKE '%"+searchdata+"%') ORDER BY cregistration.fname "+dir+" LIMIT "+length+" OFFSET "+offset;
                        break;
                    case "2":
                        q = "WHERE  id !=1 AND (id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR gender LIKE '%"+searchdata+"%' OR date LIKE '%"+searchdata+"%') ORDER BY cregistration.lname "+dir+" LIMIT "+length+" OFFSET "+offset;
                        break;
                    case "3":
                        q = "WHERE  id !=1 AND (id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR gender LIKE '%"+searchdata+"%' OR date LIKE '%"+searchdata+"%') ORDER BY cregistration.email "+dir+" LIMIT "+length+" OFFSET "+offset;
                        break;
                    case "4":
                        q = "WHERE  id !=1 AND (id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR gender LIKE '%"+searchdata+"%' OR date LIKE '%"+searchdata+"%') ORDER BY cregistration.phone "+dir+" LIMIT "+length+" OFFSET "+offset;
                        break;
                    case "5":
                        q = "WHERE  id !=1 AND (id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR gender LIKE '%"+searchdata+"%' OR date LIKE '%"+searchdata+"%') ORDER BY cregistration.gender "+dir+" LIMIT "+length+" OFFSET "+offset;
                        break;
                    case "7":
                        q = "WHERE  id !=1 AND (id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR gender LIKE '%"+searchdata+"%' OR date LIKE '%"+searchdata+"%') ORDER BY cregistration.date "+dir+" LIMIT "+length+" OFFSET "+offset;
                        break;
                    default:
                        q = "WHERE  id !=1 AND (id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR gender LIKE '%"+searchdata+"%' OR date LIKE '%"+searchdata+"%') ORDER BY cregistration.id "+dir+"  LIMIT "+length+" OFFSET "+offset;
                        break;
                }

                String totalcount = "";
                ResultSet rs = con.gettotalcount("SELECT COUNT(id) FROM `cregistration` WHERE id !=1 AND (1)");
                while(rs.next())
                {
                    totalcount=rs.getString(1);
                }
                rs = con.gettotalcount("SELECT count(*) FROM `cregistration` WHERE  id !=1 AND (id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR gender LIKE '%"+searchdata+"%' OR date LIKE '%"+searchdata+"%')");
                String resultq = "";
                while(rs.next())
                {
                    resultq = rs.getString(1);
                }         
                rs = con.gettotalcount("SELECT *,date_format(date,'%b %d, %Y ,%h:%m:%s') as date1  FROM `cregistration` "+q);
                int c = 1;
                while(rs.next())
                {
                    JSONArray subarray = new JSONArray();
                    subarray.put(rs.getString(1));
                    subarray.put(rs.getString(2));
                    subarray.put(rs.getString(3));
                    subarray.put(rs.getString(4));
                    subarray.put(rs.getString(5));
                    subarray.put(rs.getString(6));
                    subarray.put(rs.getString(7));
                    subarray.put(rs.getString("date1"));
                    subarray.put("<span onclick=\"deleteuser('"+rs.getString(1)+"')\" class='btn btn-danger datas"+rs.getString(1)+"'>Delete</span>");
                    jsonarray.put(subarray);
                }
                jsonobject.put("draw", Integer.parseInt(request.getParameter("draw")));
                jsonobject.put("recordsTotal", Integer.parseInt(totalcount));
                jsonobject.put("recordsFiltered", Integer.parseInt(resultq));
                jsonobject.put("data", jsonarray);
                out.print(jsonobject);
            }
            if(type.equals("loadcomplaints"))
            {
                try
                {
                    String searchdata = request.getParameter("search[value]").trim();
                    String dir = request.getParameter("order[0][dir]");
                    String column = request.getParameter("order[0][column]");
                    String length = request.getParameter("length");
                    String offset = request.getParameter("start");
                    jsonobject.put("draw", request.getParameter("draw"));
                    String q;
                    switch (column) 
                    {
                        case "1":
                            q= "WHERE id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR msg LIKE '%"+searchdata+"%' OR status LIKE '%"+searchdata+"%' ORDER BY fname "+dir+" LIMIT "+length+" OFFSET "+offset+";";
                            break;
                        case "2":
                            q= "WHERE id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR msg LIKE '%"+searchdata+"%' OR status LIKE '%"+searchdata+"%' ORDER BY lname "+dir+" LIMIT "+length+" OFFSET "+offset+";";
                            break;
                        case "3":
                            q= "WHERE id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR msg LIKE '%"+searchdata+"%' OR status LIKE '%"+searchdata+"%' ORDER BY email "+dir+" LIMIT "+length+" OFFSET "+offset+";";
                            break;
                        case "4":
                            q= "WHERE id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR msg LIKE '%"+searchdata+"%' OR status LIKE '%"+searchdata+"%' ORDER BY phone "+dir+" LIMIT "+length+" OFFSET "+offset+";";
                            break;
                        case "5":
                            q= "WHERE id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR msg LIKE '%"+searchdata+"%' OR status LIKE '%"+searchdata+"%' ORDER BY msg "+dir+" LIMIT "+length+" OFFSET "+offset+";";
                            break;
                        default:
                            q= "WHERE id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR msg LIKE '%"+searchdata+"%' OR status LIKE '%"+searchdata+"%' ORDER BY id "+dir+" LIMIT "+length+" OFFSET "+offset+";";
                            break;
                    }
                    String totalcount = "0";
                    String resultcount = "0";
                    Statement st = con.con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT COUNT(*) as total FROM `contactus` WHERE id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR msg LIKE '%"+searchdata+"%' OR status LIKE '%"+searchdata+"%'");
                    System.out.println("SELECT COUNT(*) as total FROM `contactus` WHERE id LIKE '%"+searchdata+"%' OR fname LIKE '%"+searchdata+"%' OR lname LIKE '%"+searchdata+"%' OR email LIKE '%"+searchdata+"%' OR phone LIKE '%"+searchdata+"%' OR msg LIKE '%"+searchdata+"%' OR status LIKE '%"+searchdata+"%'");
                    while (rs.next()) 
                    {                    
                        resultcount = rs.getString(1);
                    }
                    Statement st1 = con.con.createStatement();
                    ResultSet rs1 = st1.executeQuery("SELECT COUNT(id) AS total FROM `contactus` WHERE 1");
                    while (rs1.next()) 
                    {                    
                        totalcount = rs1.getString(1);
                    }
                    ResultSet rs2 = con.getcomplaints("SELECT * FROM `contactus` "+q);
                    while (rs2.next()) 
                    {
                        JSONArray newarr = new JSONArray();
                        newarr.put(rs2.getString(1));
                        newarr.put(rs2.getString(2));
                        newarr.put(rs2.getString(3));
                        newarr.put(rs2.getString(4));
                        newarr.put(rs2.getString(5));
                        newarr.put(rs2.getString(6));
                        String msg = "";
                        if(rs2.getString(7).equals("ignore"))
                        {
                            msg = "<p class=\"btn btn-danger disabled\">Ignored</p>";
                        }
                        else
                        if(rs2.getString(7).equals("solved"))
                        {
                            msg = "<p class=\"btn btn-info disabled\">Accepted</p>";
                        }
                        else
                        if(rs2.getString(7).equals("pending"))
                        {
                            msg = "<div id='update"+rs2.getString(1)+"'><p class=\"btn btn-danger m-2\" onclick=\"updatecomplaints('"+rs2.getString(1)+"','ignore')\">Ignore</p><p class=\"btn btn-info m-2\" onclick=\"updatecomplaints('"+rs2.getString(1)+"','solved')\">Accept</p></div>";
                        }
                        newarr.put(msg);
                        jsonarray.put(newarr);
                    }
                    jsonobject.put("draw", Integer.parseInt(request.getParameter("draw")));
                    jsonobject.put("recordsTotal", Integer.parseInt(totalcount));
                    jsonobject.put("recordsFiltered", Integer.parseInt(resultcount));
                    jsonobject.put("data", jsonarray);
                    out.print(jsonobject);
//                    System.out.println(jsonobject);
                }
                catch(Exception e)
                {
                    e.printStackTrace();
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
            Logger.getLogger(loadtabledata.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(loadtabledata.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(loadtabledata.class.getName()).log(Level.SEVERE, null, ex);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(loadtabledata.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    public String getServletInfo() 
    {
        return "Short description";
    }
}
