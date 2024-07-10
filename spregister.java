package admin.com.servalet;

import comm.classes.connection;
import comm.classes.fileupload;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.JSONArray;
import org.json.JSONObject;
@MultipartConfig
public class spregister extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException 
    {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            if(request.getParameter("submitr")!=null)
            {
                String fname=(String) request.getParameter("fname");
                String lname=(String) request.getParameter("lname");
                String email=(String) request.getParameter("email");
                String phone=(String) request.getParameter("phone");
                String aphone=(String) request.getParameter("aphone");
                String country=(String) request.getParameter("country");
                String state=(String) request.getParameter("state");
                String dist=(String) request.getParameter("dist");
                String address=(String) request.getParameter("address");
                String aaddress=(String) request.getParameter("aaddress");
                String password=(String) request.getParameter("password");
                String cpassword=(String) request.getParameter("cpassword");
                String category=(String) request.getParameter("category");
                Part file = request.getPart("idprofile");
                System.out.println(file);
                String query;
                if(password.equals(cpassword) && !password.equals(""))
                {
                    if(!category.equalsIgnoreCase(""))
                    {
                        if(!(fname.equals("")||lname.equals("")||email.equals("")||phone.equals("")||country.equals("")||state.equals("")||dist.equals("")||address.equals("")||password.equals("")))
                        {
                            int i=1;
                            Statement st;
                            connection con = new connection();
                            i = con.category(category);
                            if(i>0)
                            {
                                fileupload f = new fileupload();
                                String filename = f.fileupload(file, f.getdate(),"idproof");
                                if(filename!="fail")
                                {
                                    filename = "'idproof/"+filename+"'";
                                    query = "INSERT INTO `serviceprovider` (`id`, `fname`, `lname`, `email`, `phone`, `anotherphone`, `countrie`, `state`, `city`, `address`, `another_address`, `password`,`categery`, `filename`, `date`) VALUES (NULL, '"+fname+"', '"+lname+"', '"+email+"', '"+phone+"', '"+aphone+"', '"+country+"', '"+state+"', '"+dist+"', '"+address+"', '"+aaddress+"', '"+password+"','"+category+"',"+filename+", NOW());";
                                    st=(Statement) con.con.createStatement();
                                    i=st.executeUpdate(query);
                                    if(i>0)
                                    {   
                                        request.setAttribute("success","The Service man is added successfully. <a href='Home' class='alert-link'>Back to Home</a>");
                                        request.getRequestDispatcher("asp.jsp").forward(request, response);
                                    }
                                    else
                                    {
                                        request.setAttribute("error","The email is already exist");
                                        request.getRequestDispatcher("asp.jsp").forward(request, response);
                                    }
                                }
                                else
                                {
                                    request.setAttribute("error","File size is less then 200kb");
                                    request.getRequestDispatcher("asp.jsp").forward(request, response);
                                }
                            }
                            else
                            {
                                request.setAttribute("error","Category is already added");
                                request.getRequestDispatcher("asp.jsp").forward(request, response);
                            }
                        }
                        else
                        {
                            request.setAttribute("error","Some data is not entered");
                            request.getRequestDispatcher("asp.jsp").forward(request, response);
                        }
                    }
                    else
                    {
                        request.setAttribute("error","Category is already present");
                        request.getRequestDispatcher("asp.jsp").forward(request, response);
                    }
                }
                else
                {
                    request.setAttribute("error","Miss match password from server side");
                    request.getRequestDispatcher("asp.jsp").forward(request, response);
                }
            }
            else
            {
                request.setAttribute("error",null);
                request.getRequestDispatcher("asp.jsp").forward(request, response);
            }
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(spregister.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(spregister.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
