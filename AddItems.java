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

@MultipartConfig
public class AddItems extends HttpServlet 
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String errorpage = "adminpage?url=AddItem";
        String successpage = "adminpage?url=AddItem";
        fileupload f = new fileupload();
        connection con = new connection();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try
        {
            if(request.getParameter("itemupload")!=null )
            {
                if(Integer.parseInt(request.getParameter("page"))==1)
                {
                    String title = request.getParameter("title");
                    String cost = request.getParameter("cost");
                    String brand = request.getParameter("brand");
                    String size = request.getParameter("size");
                    String age = request.getParameter("age");
                    String type = request.getParameter("type");
                    String searches = request.getParameter("searches");
                    if(request.getParameter("details")==null || request.getParameter("details")== "" || request.getParameter("noofcolor")==null || request.getParameter("details")=="")
                    {
                        request.setAttribute("error","Please fill out the form completly.");
                        request.getRequestDispatcher(errorpage).forward(request, response);
                    }
                    int details = Integer.parseInt(request.getParameter("details"));
                    int noofcolor = Integer.parseInt(request.getParameter("noofcolor"));
                    Part mainfile = request.getPart("mainimage");
                    String filename = f.fileupload(mainfile, f.getdate(),"images/itemimage");
                    int i = con.additem(title,cost,brand,size,age,type,searches,filename,con);
                    if(i>0)
                    {
                        Part file = null;
                        String filesname = f.getdate();
                        int incfile = 1;
                        for (int j = 1; j <= details; j++)
                        {
                            String description = request.getParameter("description"+j);
                            String detail = request.getParameter("details"+j);
                            if(description != "" && description != null && detail != "" && detail != null)
                            {
                                con.insertdetail(i, description, detail, con);
                            }                        
                        }
                        for(int j = 1; j <= noofcolor; j++)
                        {
                            String colorcode = request.getParameter("color"+j);
                            int stock = Integer.parseInt(request.getParameter("stock"+j));
                            if(colorcode!="" && colorcode!=null && stock>0)
                            {
                                con.insetcolor(i, colorcode, stock, con);
                                int flag = 0;
                                for(int a = 1; a<=10; a++)
                                {
                                    file = request.getPart("color"+j+""+a);
                                    if((file!=null) || ((a==1 && file != null)|| (a==2 && file != null)))
                                    {
                                        flag = 1;
                                        String ss = f.fileupload(file, filesname+incfile, "images/itemimage");
                                        
                                        if(ss!="fail")
                                        {
                                            incfile++;
                                            con.insertsubimages(i, ss, colorcode, con);
                                        }
                                    }
                                    else
                                    {
                                        if(flag==1)
                                        {
                                            continue;
                                        }
                                        else
                                        {
                                            con.removeitemid(i, con);
                                            request.setAttribute("error","Error in uploading a pic");
                                            request.getRequestDispatcher(errorpage).forward(request, response);
                                        }
                                    }
                                }                            
                            }
                        }
                        request.setAttribute("success","One item added successfully");
                        request.getRequestDispatcher(successpage).forward(request, response);
                    }
                    else
                    {
                        request.setAttribute("error","Something went wrong in Item details forms");
                        request.getRequestDispatcher(errorpage).forward(request, response);
                    }
                }
                else
                {
                    request.setAttribute("error","Something went wrong in Item details form1");
                    request.getRequestDispatcher(errorpage).forward(request, response);
                }
            }
            else
            {
                request.getRequestDispatcher(errorpage).forward(request, response);
            }
        }
        catch(Exception e)
        {
            out.print("Something wents wrong in the form please go back and fill the form again <a href='"+successpage+"'> Click </a> Here.");
            request.setAttribute("error","Please Fill the form completely 1");
            e.printStackTrace();
            request.getRequestDispatcher(errorpage).forward(request, response);
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
