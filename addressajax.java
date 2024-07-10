package comm.ajax;

import comm.classes.connection;
import comm.classes.email;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import org.json.JSONObject;

public class addressajax extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        connection con = new connection();
        try (PrintWriter out = response.getWriter()) 
        {
            if(request.getParameter("state")!=null)
            {
                Statement sts,sts1;
                String allstates="<option value=''>Choose States...</option>";
                sts=con.con.createStatement();
                sts1=con.con.createStatement();
                String countrie=request.getParameter("state");
                String countries = "select * from countries where name LIKE '"+countrie+"';";
                ResultSet countri = sts.executeQuery(countries);
                while(countri.next())
                {
                    String countrieid=countri.getString(1);
                    String states = "SELECT * FROM `states` WHERE country_id LIKE '"+countrieid+"';";
                    ResultSet stat = sts1.executeQuery(states);
                    while(stat.next())
                    {
                        allstates+="<option value='"+stat.getString(2)+"'>"+stat.getString(2)+"</option>";
                    }
                }
                out.print(allstates);
            }
            if(request.getParameter("city")!=null)
            {
                Statement sts,sts1;
                String allcity="<option value=''>Choose Cities...</option>";
                sts=con.con.createStatement();
                sts1=con.con.createStatement();
                String countrie=request.getParameter("city");
                String countries = "select * from states where name LIKE '"+countrie+"';";
                ResultSet countri = sts.executeQuery(countries);
                while(countri.next())
                {
                    String countrieid=countri.getString(1);
                    String states = "SELECT * FROM `cities` WHERE state_id LIKE '"+countrieid+"' order by name;";
                    ResultSet stat = sts1.executeQuery(states);
                    while(stat.next())
                    {
                        allcity+="<option value='"+stat.getString(2)+"'>"+stat.getString(2)+"</option>";
                    }
                }
                out.print(allcity);
            }
            if(request.getParameter("checkemail")!="")
            {
                boolean check = false;
                String s = request.getParameter("checkemail");
                check = con.cregister(s, con);
                JSONObject js = new JSONObject();
                if(check)
                    js.put("status", "success");
                else
                    js.put("status","fail");
                out.print(js);
            }
            if(request.getParameter("editprofile")!=null)
            {
                if(session.getAttribute("id")!=null)
                {
                    String id =(String) session.getAttribute("id");
                    String fname = (String) request.getParameter("fname");
                    String lname = (String) request.getParameter("lname");
                    String email = (String) request.getParameter("email");
                    String phone = (String) request.getParameter("phone");
                    int i = con.updateprofile(id,fname,lname,email,phone);
                    if(i>0)
                    {
                        session.setAttribute("uphone", phone);
                        session.setAttribute("uemail", email);
                        session.setAttribute("ufname", fname);
                        session.setAttribute("ulname", lname);
                        out.print("success");
                    }
                    else
                    {
                        out.print("fail");
                    }
                }
                else
                {
                    out.print("fail");
                }
            }
            if(request.getParameter("changepasswords")!=null)
            {
                String opass  = request.getParameter("opass");
                String npass  = request.getParameter("npass");
                String cpass  = request.getParameter("cpass");
                if(opass.equals((String)session.getAttribute("upassword")))
                {
                    if(npass.equals(cpass) && !npass.trim().equals(""))
                    {
                        int i = con.changepassword((String)session.getAttribute("id"), npass);
                        if(i>0)
                        {
                            session.setAttribute("upassword",npass);
                            LocalDateTime myDateObj = LocalDateTime.now();
                            DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
                            String formattedDate = myDateObj.format(myFormatObj);
                            final StringBuilder sb = new StringBuilder("<html> ");
                            sb.append("<body>");
                            sb.append("<div style='width: 70%; height: auto;margin: 60px auto; padding: 20px; border: 6px solid lightblue; border-radius: 10px;'>");
                            sb.append("<h2 style='margin-bottom: 20px;'>Hello, "+session.getAttribute("ufname")+" "+session.getAttribute("ulname")+"</h2>");
                            sb.append("<p style='margin-bottom: 20px;'>Yours password has been changed on "+formattedDate+".</p>");
                            sb.append("<p style='margin-bottom: 20px;'>If it is not done by You, Please let me know about this problem. <a href='http://localhost:8084/itemdelivery/page?name=contact'> Click</p>");
                            sb.append("</div>");
                            sb.append("</body>");
                            sb.append("</html>");
                            email sendmail = new email();
                            sendmail.send(sb.toString(), "Password Changed", (String)session.getAttribute("uemail"));
                            out.print(0);
                        }
                        else
                        {
                            out.print(3);
                        }
                    }
                    else
                    {
                        out.print(2);
                    }
                }
                else
                {
                    out.print(1);
                }
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
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
