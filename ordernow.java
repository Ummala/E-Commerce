package comm.servlets;

import comm.classes.cartdetails;
import comm.classes.connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

public class ordernow extends HttpServlet 
{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        HttpSession session = request.getSession();
        connection con = new connection();
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            if(session.getAttribute("id")!=null && request.getParameter("ordernow")!=null)
            {
                String finaladd_id="0",finalpayment_id="0";
                String country,state,city,address,zip,phone,aphone,dtime;
                String color,size,age,status,paymentmethod;
                String paymentmode = request.getParameter("payment");                
                String cardname,cardnumber,mm,yy,ccv;                
                int address_id = 0,payment_id=0,quantity=0,price=0;
                String addressid = request.getParameter("addressmodes");
                System.out.println(addressid);
                if(addressid.equals("new"))
                {
                    country = request.getParameter("country");
                    state = request.getParameter("state");
                    city = request.getParameter("dist");
                    address = request.getParameter("address");
                    zip = request.getParameter("zip");
                    phone = request.getParameter("phone");
                    aphone = request.getParameter("aphone");
                    dtime = request.getParameter("addresstype");
                    address_id = con.adddeliveryaddress(Integer.parseInt((String)session.getAttribute("id")),country,state,city,address,zip,phone,aphone,dtime,con);
                    finaladd_id = ""+address_id;
                    System.out.println(finaladd_id+" new");
                }
                else
                if(addressid.equals("old"))
                {
                    finaladd_id = request.getParameter("oldaddress");
                }
               
                if(paymentmode.equals("online"))
                {
                    cardname = request.getParameter("cardname");
                    cardnumber = request.getParameter("cardnumber");
                    mm = request.getParameter("mm");
                    yy = request.getParameter("yy");
                    ccv = request.getParameter("ccv");
                    payment_id = con.addpayment(Integer.parseInt((String)session.getAttribute("id")),cardname,cardnumber,mm,yy,ccv,con);
                    finalpayment_id =(String) ""+payment_id ;
                }
                else
                {
                    finalpayment_id = "offline";
                }
                if(session.getAttribute("cart")==null)
                {
                    quantity = Integer.parseInt((String)request.getParameter("quantity"));
                    color =(String) session.getAttribute("buynowchoosecolor");
                    size =(String) session.getAttribute("buynowsize");
                    age =(String) session.getAttribute("age");
                    String itemid = (String) session.getAttribute("buynowid");
                    status = "order placed";

                    price =Integer.parseInt((String) session.getAttribute("buynowprice"));

                    int i = con.placeorder(Integer.parseInt((String)session.getAttribute("id")),itemid,quantity,color,size,price,age,status,paymentmode,finaladd_id,finalpayment_id,con);
                    if(i>0)
                    {
                        request.setAttribute("success","Your Order is placed Succefully");
                        request.getRequestDispatcher("ordercompletepage.jsp").forward(request, response);
                    }
                    else
                    {
                        request.setAttribute("error","Some error occurs, Your are is not done at.");
                        request.getRequestDispatcher("ordercompletepage.jsp").forward(request, response);
                    }
                }
                else
                {
                    status = "order placed";
                    int id =Integer.parseInt((String) session.getAttribute("id"));
                    ArrayList<cartdetails> list = con.getcartdetails(id);
                    if(list.size()>0)
                    {
                        Iterator<cartdetails> itr = list.iterator();
                        while(itr.hasNext())
                        {
                            cartdetails obj = itr.next();
                            String idcolor = con.getcolor(obj.getColorid().toString());
                            int i = con.placeorder(Integer.parseInt((String)session.getAttribute("id")),""+obj.getItemid(),obj.getQuantity(),idcolor,obj.getSize(),obj.getPrice(),"0",status,paymentmode,finaladd_id,finalpayment_id,con);
                            if(i>0)
                            {
                                int cartid = obj.getId();
                                con.changestatus(cartid);
                            }
                        }
                        request.setAttribute("success","Your Order is placed Succefully");
                        request.getRequestDispatcher("ordercompletepage.jsp").forward(request, response);
                    }
                }
            }
            else
            {
                request.getRequestDispatcher("ordercompletepage.jsp").forward(request, response);
            }
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
        processRequest(request, response);
    }
    @Override
    public String getServletInfo() 
    {
        return "Short description";
    }
}
