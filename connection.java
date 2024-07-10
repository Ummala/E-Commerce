package comm.classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import jakarta.servlet.http.HttpSession;

//import java.io.File;
import static java.lang.System.out;
//import java.sql.*;
//import java.sql.DriverManager;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.util.ArrayList;
//import javax.servlet.http.HttpSession;
  
public class connection 
{
    public  static Statement st,st1;
    public static ResultSet rs,rs1;
    public Connection con;
    
    public connection()
    {
        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/itemdelivery","root","tiger");
        }
        catch(Exception e)
        {
            out.print(e);
        }
    }
    public static int registeruser(String fname,String lname,String email,String phone,String password) 
    {
        return 1;
    }
    public static boolean check(String s, connection c) throws SQLException {
        String q="SELECT * FROM `adminlogin` WHERE `username` LIKE '"+s+"'";
        st = (Statement) c.con.createStatement();
        rs = st.executeQuery(q);
        return rs.next();
    }
    public static int change(String s, connection c,HttpSession session) throws SQLException
    {
        st1 = c.con.createStatement();
        int i = 0;
        i = st1.executeUpdate("UPDATE `cregistration` SET `password` = '"+s+"' WHERE `cregistration`.`id` = 1;");
        if(i>0)
        {
            st = (Statement) c.con.createStatement();
            String q = "UPDATE `adminlogin` SET `password` = '"+s+"' WHERE `adminlogin`.`id` = '"+session.getAttribute("adminid")+"' ;";
            i = st.executeUpdate(q);
        }
        return  i;
    }
    public static int category(String s)
    {
        try
        {
            
            String q = "INSERT INTO `category` (`id`, `cname`, `date`) VALUES (NULL, '"+s+"', NOW());";
            connection con = new connection();
            st =(Statement) con.con.createStatement();
            int i=0;
            i=st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return  0;
    }
    public static boolean cregister(String s, connection con) throws SQLException 
    {
        String q = "SELECT * FROM `cregistration` WHERE email LIKE '"+s+"'";
        st = (Statement)con.con.createStatement();
        rs = st.executeQuery(q);
        return rs.next();
    }
    public static ArrayList<filelocation> getloc(String type,connection con)
    {
        ArrayList<filelocation> files = new ArrayList<filelocation>();
        try
        {
            String q;
            st= con.con.createStatement();
            if(type == "main")
            {
                q = "SELECT location FROM `courosel` WHERE `type` LIKE 'main' AND `visible` = 'yes' ORDER BY orderlist ASC;";
                
            }
            else
            {
                q = "SELECT location FROM `courosel` WHERE type LIKE '"+type+"' order by id desc;";
            }
            rs = st.executeQuery(q);
            while(rs.next())
            {
                filelocation f = new filelocation();
                f.setlocation(rs.getString(1));
               
                files.add(f);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return files;
    }    
    public static int changepassword(String pass, HttpSession se,connection con) throws SQLException
    {
        try
        {
            String opass = se.getAttribute("fid").toString();
            st = con.con.createStatement();
            String q = "SELECT * FROM `changepassword` WHERE email LIKE '"+se.getAttribute("fmail").toString()+"' AND password LIKE '"+opass+"' AND status LIKE '0'";
            rs = st.executeQuery(q);  
            if(rs.next())
            {
                q = "UPDATE `changepassword` SET `status`='1',`date`=now() WHERE email LIKE '"+se.getAttribute("fmail").toString()+"' AND password LIKE '"+se.getAttribute("fid").toString()+"';";
                st = con.con.createStatement();
                int i = st.executeUpdate(q);
                if(i>0)
                {
                    q = "UPDATE `cregistration` SET `password`='"+pass+"' WHERE email LIKE '"+se.getAttribute("fmail").toString()+"'";
                    st = con.con.createStatement();
                    i = st.executeUpdate(q);
                    if(i>0)
                    {
                        return 1;
                    }
                    else
                    {
                        return 0;
                    }
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 0;
            }
        }
        catch(Exception e)
        {
            return 0;
        }
    }
    public static int acceptresetpassword(String email,connection con,HttpSession session) throws SQLException
    {
        int status = 0;
        try{
            int i = (int)(Math.random()*10000000);
            session.setAttribute("fid",i);
            session.setAttribute("femail",email);
            String q = "INSERT INTO `changepassword` (`id`, `email`, `password`, `status`, `date`) VALUES (NULL, '"+email+"', '"+i+"', '0', NOW());";
            st = con.con.createStatement();
            status = st.executeUpdate(q);
            return status;
        }
        catch(Exception e)
        {
            return status;
        }
    }
    public static String getname(String email , connection con) throws SQLException
    {
        st=con.con.createStatement();
        String q= "SELECT fname,lname FROM `cregistration` WHERE email LIKE '"+email+"'";
        rs = st.executeQuery(q);
        if(rs.next())
        {
            return rs.getString("fname")+" "+rs.getString("lname");
        }
        else
        {
            return "";
        }
    }
    public static int contactus(String q, connection con) throws SQLException {
        int i = 0;
        try{
            st = con.con.createStatement();
            i = st.executeUpdate(q);
            return  i;
        }
        catch(Exception e)
        {
            return i;
        }
    }
    public static int additem(String title,String cost,String brand,String size,String age,String type,String searches,String filename,connection con) 
    {
        int i = -1;
        try
        {
            st = con.con.createStatement();
            String q = "INSERT INTO `items` (`id`, `title`, `cost`, `brand`, `size`, `age`, `type`, `searches`, `images`, `date`) VALUES (NULL, \""+title+"\", '"+cost+"',\""+brand+"\",'"+size+"','"+age+"', '"+type+"', \""+searches+"\",'"+filename+"', NOW());";
            System.out.println(q);
            i = st.executeUpdate(q);
            if(i>0)
            {
                q = "SELECT * FROM `items` WHERE images LIKE '"+filename+"';";
//                System.out.println(q);
                rs = st.executeQuery(q);
                while(rs.next())
                {
                    i = Integer.parseInt(rs.getString("id"));
                }
            }
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }
    public static void insertdetail(int id,String description, String details, connection con) 
    {
        try
        {
            String q = "INSERT INTO `itemdetails` (`id`, `itemid`, `description`, `details`) VALUES (NULL, '"+id+"', '"+description+"', '"+details+"');";
            st = con.con.createStatement();
            st.executeUpdate(q);
        }
        catch(Exception e)
        {
            System.out.println("Some data not been inserted.");
        }
    }
    public static void insetcolor(int id, String color, int stock,connection con) 
    {
        try
        {
            String q = "INSERT INTO `color` (`id`, `itemid`, `color`, `stock`) VALUES (NULL, '"+id+"', '"+color+"', '"+stock+"');";
            st = con.con.createStatement();
            st.executeUpdate(q);
        }
        catch(Exception e)
        {
            System.out.println(e+"/n some error while inserting colors");
        }
    }
    public static int removeitemid(int id, connection con) 
    {
        int i = 0;
        try
        {
            String q = "DELETE FROM `items` WHERE id LIKE '"+id+"'";
            st = con.con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }
    public static void insertsubimages(int id,String location,String color, connection con) 
    {
        try
        {
            String q = "INSERT INTO `subimages` (`id`, `itemid`, `location`, `color`) VALUES (NULL, '"+id+"', '"+location+"', '"+color+"');";
            st = con.con.createStatement();
            st.executeUpdate(q);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    public static ResultSet SelectAddress(int id, connection con) 
    {
        ResultSet rs = null;
        try
        {
            String q = "SELECT * FROM `address` WHERE cid LIKE '"+id+"' AND status LIKE 'show'";
            st = con.con.createStatement();
            rs = st.executeQuery(q);
            return rs;
        }
        catch(Exception e)
        {
            
            return rs;
        }
    }
    public static int adddeliveryaddress(int id,String country,String state,String city,String address,String zip,String phone,String aphone,String dtime, connection con)
    {
        int i = 0;
        try
        {
            String q = "INSERT INTO `address` (`id`, `cid`, `countryname`, `statename`, `cityname`, `zip`, `phone`, `aphone`, `address`, `addresstype`, `status`, `date`) VALUES (NULL, "+id+", '"+country+"', '"+state+"', '"+city+"', '"+zip+"', '"+phone+"','"+aphone+"', '"+address+"', '"+dtime+"', 'show', NOW());";
            st = con.con.createStatement();
            if(st.executeUpdate(q)>0)
            {
                st1= con.con.createStatement();
                q = "SELECT `id` FROM `address` WHERE cid LIKE '"+id+"' AND address LIKE '"+address+"' AND phone LIKE '"+phone+"' AND addresstype LIKE '"+dtime+"' AND cityname LIKE '"+city+"' AND aphone LIKE '"+aphone+"' AND status LIKE 'show';";
                rs = st1.executeQuery(q);
                
                while (rs.next()) 
                {
                    i = rs.getInt("id");
                }
            }
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }
    public static int addpayment(int id,String cardname,String cardnumber,String mm,String yy,String ccv,connection con) 
    {
        int i = 0;
        try
        {
            String q = "INSERT INTO `payment` (`id`, `cid`, `cardname`, `cardnumber`, `expdate`, `expireyear`, `cvv`, `date`) VALUES (NULL, '"+id+"', '"+cardname+"', '"+cardnumber+"', '"+mm+"', '"+yy+"', '"+ccv+"', NOW());";
            st = con.con.createStatement();
            if(st.executeUpdate(q)>0)
            {
                st1= con.con.createStatement();
                q = "SELECT `id` FROM `payment` WHERE cid LIKE '"+id+"' AND cardname LIKE '"+cardname+"' AND cardnumber LIKE '"+cardnumber+"' AND expdate LIKE '"+mm+"' AND expireyear LIKE '"+yy+"' AND cvv LIKE '"+ccv+"';";
                rs = st1.executeQuery(q);
                while (rs.next()) 
                {
                    i = rs.getInt("id");
                }
            }
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }
    public static int placeorder(int id,String itemid,int quantity,String color,String size,int price,String age,String status,String paymentmode,String address_id,String payment_id,connection con) 
    {
        int i = 0;
        try
        {
            String q="";
            
            if(paymentmode.equals("offline"))
            {
                payment_id = "0";
            }
            q = "INSERT INTO `placeorder` (`id`, `cid`, `itemid`, `quantity`, `color`, `size`, `price`, `age`, `status`, `paymentmode`, `addressid`, `paymentid`, `date`) VALUES (NULL, '"+id+"', '"+itemid+"', '"+quantity+"', '"+color+"', '"+size+"', '"+price+"', '"+age+"', '"+status+"', '"+paymentmode+"', '"+address_id+"', '"+payment_id+"', NOW());";
            st = con.con.createStatement();
            i=st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }
    public static ResultSet getorderdetails(String id,String color,connection con)
    {
        try
        {
            st = con.con.createStatement();
            rs = st.executeQuery("SELECT * FROM subimages, items WHERE items.id LIKE '"+id+"' AND subimages.color LIKE '"+color+"';");
            return rs;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return rs;
        }
    }
    public static ArrayList<cartlist> getcartdetails(HttpSession session,connection con)
    {
        ArrayList<cartlist> cart = new ArrayList<>();
        int id = Integer.parseInt((String) session.getAttribute("id"));
        try
        {
            st = con.con.createStatement();
            
            String q = "SELECT * FROM `cart` WHERE cid LIKE '"+id+"' AND status LIKE 'pending';";
            rs = st.executeQuery(q);
            while(rs.next())
            {
                q = "SELECT items.*,subimages.location FROM `subimages`,items WHERE itemid LIKE '"+rs.getInt("itemid")+"' AND color LIKE '"+rs.getInt("color")+"' LIMIT 1;";
                st1 = con.con.createStatement();
                rs1=st1.executeQuery(q);
                while (rs1.next()) 
                {
                    cartlist add = new cartlist();
                    add.setColor(rs.getString("color"));
                    add.setItemtitle(rs1.getString("title"));
                    add.setItemprice(rs1.getInt("cost"));
                    add.setQuantity(rs.getString("quantity"));
                    add.setSize(rs.getString("size"));
                    add.setLocation(rs.getString("location"));
                    cart.add(add);
                }
            }
            return cart;
        }
        catch(Exception e)
        {
            return cart;
        }
    }
    public static ResultSet searchdata(String[] data,connection con)
    {
        try
        {
            int i = 1;
            String q = "SELECT * FROM `items` WHERE ";
            for(int j = 0; j<data.length;j++)
            {
                if(data[j].equalsIgnoreCase("mens")||data[j].equalsIgnoreCase("men"))
                {
                    if(i==1)
                    {
                        q = q + "status LIKE 'in' AND searches LIKE '%"+data[j]+"%' AND type LIKE 'men'";
                        i++;
                    }
                    else
                    {
                        q = q + " AND searches LIKE '%"+data[j]+"%'";
                    }
                }
                else
                {
                    if(i==1)
                    {
                        q = q + "status LIKE 'in' AND  searches LIKE '%"+data[j]+"%'";
                        i++;
                    }
                    else
                    {
                        q = q + " AND searches LIKE '%"+data[j]+"%'";
                    }
                    
                }
            }
            st = con.con.createStatement();
            rs = st.executeQuery(q);
            return rs;
        }
        catch(Exception e)
        {
            return rs;
        }
    }
    public static ResultSet getimagesofthecolor(int id, String color,int limit, connection con) 
    {
        try
        {
            String q = "SELECT * FROM `subimages` WHERE itemid LIKE '"+id+"' AND color LIKE '"+color+"' LIMIT "+limit+";";
//            System.out.println("inside getimagesofthecolor method "+q);
            st = con.con.createStatement();
            rs = st.executeQuery(q);
            return rs;
        }
        catch(Exception e)
        {
            return rs;
        }
    }
    public static ResultSet getdetails(int id,String type,connection con) 
    {
        
        try
        {
            String q;
            if(type=="d")
            {
                q = "SELECT * FROM `items` WHERE id LIKE '"+id+"' AND status LIKE 'in';";
            }
            else if(type=="singleimage")
            {
                q = "SELECT * FROM `color` WHERE itemid LIKE '"+id+"' AND status LIKE 'in' LIMIT 1;";
            }
            else if(type=="idcolor")
            {
                q = "SELECT * FROM `color` WHERE id LIKE '"+id+"' AND status LIKE 'in' LIMIT 1;";
            }
            else
            {
                q = "SELECT * FROM `color` WHERE itemid LIKE '"+id+"' AND status LIKE 'in';";
                
            }
            st = con.con.createStatement();
            rs = st.executeQuery(q);
            return rs;
        }
        catch(Exception e)
        {
            return rs;
        }
    }

    public ArrayList<getmoredetails> getmoredetails(int id) 
    {
        ArrayList<getmoredetails> list = new ArrayList<>();
        try
        {
            st = con.createStatement();
            String q = "SELECT * FROM `itemdetails` WHERE itemid LIKE '"+id+"';";
            rs = st.executeQuery(q);
            while (rs.next()) 
            {
                getmoredetails details = new getmoredetails();
                details.setDescription(rs.getString("description"));
                details.setDetails(rs.getString("details"));
                list.add(details);
            }
            return list;
        }
        catch(Exception e)
        {
            return list;
        }
    }

    public String addtocart(String id, String color, String size , HttpSession session)  
    {
        int cid =Integer.parseInt((String)session.getAttribute("id"));
        String status="fail";
        try
        {
            st = con.createStatement();
            String q = "SELECT * FROM `cart` WHERE cid LIKE '"+cid+"' AND itemid LIKE '"+id+"' AND color LIKE '"+color+"' AND size LIKE '"+size+"' AND status LIKE 'pending';";
            
            rs = st.executeQuery(q);
            if(rs.next())
            {
                st1 = con.createStatement();
                int cartid = rs.getInt("id");
                int quantity = rs.getInt("quantity");
                quantity=quantity+1;
                q = "UPDATE `cart` SET `quantity` = '"+quantity+"' WHERE `cart`.`id` = "+cartid+";";
                int stt = st1.executeUpdate(q);
                if(stt>0)
                {
                    return "succes";
                }
            }
            else
            {
                
                st1 = con.createStatement();
                q = "INSERT INTO `cart` (`id`, `cid`, `itemid`, `color`, `quantity`, `size`, `status`, `date`) VALUES (NULL, '"+cid+"', '"+id+"', '"+color+"','1', '"+size+"', 'pending', now());";
                int stt = st1.executeUpdate(q);
                if(stt>0)
                {
                    return "succes";
                }
            }
            return status;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return status;
        }
    }
    public ArrayList<cartdetails> getcartdetails(int id)
    {
        ArrayList<cartdetails> list = new ArrayList<>();
        String q;
        try
        {
            q = "SELECT * FROM `cart` WHERE cid LIKE '"+id+"' AND status LIKE 'pending' AND itemstatus LIKE 'in' ORDER BY `cart`.`id` DESC;";
            st = con.createStatement();
            rs = st.executeQuery(q);
            while (rs.next()) 
            {
                cartdetails objects = new  cartdetails();
                objects.setId(rs.getInt("id"));
                objects.setQuantity(rs.getInt("quantity"));
                objects.setSize(rs.getString("size"));
                int itemid = rs.getInt("itemid");
                objects.setItemid(itemid);
                String color = rs.getString("color");
                q = "SELECT title,cost,brand FROM `items` WHERE id LIKE '"+itemid+"' AND status LIKE 'in'";
                st1 = con.createStatement();
                rs1 = st1.executeQuery(q);
                while (rs1.next()) 
                {                    
                    objects.setTitle(rs1.getString("title"));
                    objects.setPrice(rs1.getInt("cost"));
                    objects.setBrand(rs1.getString("brand"));
                }
                q = "SELECT location FROM `subimages` WHERE itemid LIKE '"+itemid+"' AND color LIKE '"+color+"' LIMIT 1;";
                Statement st3 = con.createStatement();
                ResultSet rs2 = st3.executeQuery(q);
                while (rs2.next())
                {                    
                    objects.setLocation(rs2.getString("location"));
                }
                q = "SELECT id FROM `color` WHERE itemid LIKE '"+itemid+"' AND color LIKE '"+color+"' LIMIT 1;";
                Statement st4 = con.createStatement();
                ResultSet rs3 = st4.executeQuery(q);
                while (rs3.next())
                {                    
                    objects.setColorid(rs3.getString("id"));
                }
                list.add(objects);
            }
            return list;
        }
        catch(Exception e)
        {
            return list;
        }
    }

    public int updateq(String id, int updates) 
    {
        int i = 0;
        String q = "UPDATE `cart` SET `quantity` = '"+updates+"' WHERE `cart`.`id` = "+id+";";
        try
        {
            st = con.createStatement(); 
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            return i;
        }
    }
    public int removecart(int id) 
    {
        int i = 0;
        String q = "DELETE FROM `cart` WHERE id LIKE "+id+";";
        try
        {
            st = con.createStatement(); 
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            return i;
        }
    }

    public ResultSet getbuynowdata(String id, String color, String size) 
    {
        try
        {
            String s = "SELECT * FROM items,subimages WHERE subimages.itemid LIKE '"+id+"' AND subimages.color LIKE '"+color+"' AND items.id LIKE '"+id+"' LIMIT 1";
            st = con.createStatement();
            rs = st.executeQuery(s);
            System.out.println(s);
            return rs;
        }
        catch(Exception e)
        {
            return rs;
        }
    }
    public ArrayList<orderlist> getorderlist(int id)
    {
        ArrayList<orderlist> list = new ArrayList<>();
        String q;
        try
        {
            st = con.createStatement();
            if(id==-1)
                q = "SELECT * FROM `placeorder` WHERE status Like 'order placed' ORDER BY `placeorder`.`id` DESC";
            else if(id==-2)
                q = "SELECT * FROM `placeorder` WHERE status Like 'SHIPPED' ORDER BY `placeorder`.`id` DESC";
            else
                q = "SELECT * FROM `placeorder` WHERE cid LIKE '"+id+"'  ORDER BY `placeorder`.`id` DESC";
            rs = st.executeQuery(q);
            while(rs.next())
            {
                orderlist obj = new orderlist();
                obj.setId(rs.getInt("id"));
                obj.setItemid(rs.getInt("itemid"));
                obj.setQuantity(rs.getString("quantity"));
                obj.setSize(rs.getString("size"));
                obj.setPrice(rs.getInt("price"));
                obj.setStatus(rs.getString("status"));
                obj.setDate(rs.getString("date"));
                obj.setPaymentmode(rs.getString("paymentmode"));
                obj.setAddressid(rs.getInt("addressid"));
                st1 = con.createStatement();
                q = "SELECT title,brand FROM `items` WHERE id LIKE '"+rs.getInt("itemid")+"'";
                rs1 = st1.executeQuery(q);
                while(rs1.next())
                {
                    obj.setTitle(rs1.getString("title"));
                    obj.setBrand(rs1.getString("brand"));
                }
                q = "SELECT location FROM `subimages` WHERE itemid LIKE '"+rs.getInt("itemid")+"' AND color LIKE '"+rs.getString("color")+"'  LIMIT 1;";
                Statement st2 = con.createStatement();               
                ResultSet rs2 = st2.executeQuery(q);
                while(rs2.next())
                {
                    obj.setLocation(rs2.getString("location"));
                }
                q = "SELECT * FROM `address` WHERE id LIKE '"+rs.getInt("addressid")+"';";
                Statement st3 = con.createStatement();
                ResultSet rs3 = st3.executeQuery(q);
                while (rs3.next()) 
                {                    
                    obj.setCountry(rs3.getString("countryname"));
                    obj.setState(rs3.getString("statename"));
                    obj.setCity(rs3.getString("cityname"));
                    obj.setAddress(rs3.getString("address"));
                    obj.setZip(rs3.getInt("zip"));
                    obj.setPhone(rs3.getString("phone"));
                    obj.setAphone(rs3.getString("aphone"));
                    obj.setAddresstype(rs3.getString("addresstype"));
                }
                q = "SELECT id FROM `color` WHERE itemid LIKE '"+rs.getInt("itemid")+"' AND color LIKE '"+rs.getString("color")+"'";
                Statement st4 = con.createStatement();
                ResultSet rs4 = st4.executeQuery(q);
                while(rs4.next())
                {
                    obj.setColorid(rs4.getInt("id"));
                }
                list.add(obj);
            }
            return list;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return list;
        }
    }

    public String getcolor(String colorid) 
    {
        try
        {
            String status = null;
            String q = "SELECT color FROM `color` WHERE id LIKE '"+colorid+"'";
            st = con.createStatement();
            rs = st.executeQuery(q);
            while(rs.next())
            {
                status = rs.getString("color");
            }
            return status;
        }
        catch(Exception e)
        {
            return "";
        }
    }

    public void changestatus(int cartid) 
    {
        try
        {
            String q = "UPDATE `cart` SET `status` = 'ordered' WHERE `cart`.`id` = '"+cartid+"';";
            st = con.createStatement();
            int i = st.executeUpdate(q);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public int deleteaddressid(String id) 
    {
        int i=0;
        try
        {
            String q = "UPDATE `address` SET `status` = 'hide' WHERE `address`.`id` = '"+id+"';";
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }
    public String getallsize()
    {
        String s = "";
        try
        {
            st = con.createStatement();
            String q = "select count(*) counts from items union all select count(*) counts from cregistration WHERE id != 1 union all select count(*) counts from placeorder where status like 'order placed'";
            rs = st.executeQuery(q);
            while(rs.next())
            {
                s = s + " " + rs.getString(1);
            }
            return s;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return s;
        }
    }

    public ResultSet getfaq() 
    {
        try
        {
            String q = "SELECT * FROM `faq` WHERE 1";
            st = con.createStatement();
            rs = st.executeQuery(q);
            return rs;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return rs;
        }
    }
    public ResultSet gettotalcount(String q) 
    {
        try
        {
            System.out.println(q);
            st = con.createStatement();
            rs = st.executeQuery(q);
            return rs;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return rs;
        }
    }

    public int deleteuserid(String id) 
    {
        try
        {
            String q = "DELETE FROM `cregistration` WHERE id LIKE '"+id+"';";
            st = con.createStatement();
            int i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return 0;
        }
    }
    public int updatestatus(String id)
    {
        int i = 0;
        try
        {
            String q = "UPDATE `placeorder` SET `status` = 'SHIPPED' WHERE `placeorder`.`id` = "+id+";";
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
        
    }

    public int updateprofile(String id, String fname, String lname, String email, String phone) 
    {
        int i = 0;
        try
        {
            String q = "UPDATE `cregistration` SET `fname`='"+fname+"',`lname`='"+lname+"',`email`='"+email+"',`phone`='"+phone+"' WHERE id LIKE '"+id+"'";
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }
    public int changepassword(String id, String password) 
    {
        int i = 0;
        try
        {
            String q = "UPDATE `cregistration` SET `password` = '"+password+"' WHERE `cregistration`.`id` = "+id+";";
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }
    public ResultSet getitemdetails(String status)
    {
        try
        {
            String q = "SELECT * FROM `items` WHERE status LIKE '"+status+"'";
            st = con.createStatement();
            rs = st.executeQuery(q);
            return rs;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return rs;
        }
    }

    public int updateitem(String q)
    {
        int i = 0;
        try
        {
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }

    public ArrayList<subimages> getsubimages(String id) 
    {
        ArrayList<subimages> list = new ArrayList<>();
        try
        {
            String q = "SELECT * FROM `color` WHERE itemid LIKE '"+id+"';";
            st = con.createStatement();
            rs = st.executeQuery(q);
            while(rs.next())
            {
                subimages s = new subimages();
                s.setId(rs.getString("id"));
                s.setColor(rs.getString("color"));
                s.setStatus(rs.getString("status"));
                st1 = con.createStatement();
                q = "SELECT location FROM `subimages` WHERE itemid LIKE '"+id+"' AND color LIKE '"+rs.getString("color")+"' LIMIT 1;";
                rs1 = st1.executeQuery(q);
                while(rs1.next())
                {
                    s.setImg(rs1.getString("location"));
                }
                list.add(s);
            }
            return list;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return list;
        }
    }

    public int updatesubimgstatus(String itemid, String colorid, String status) 
    {
        int i = 0;
        try
        {
            String q = "UPDATE `color` SET `status` = '"+status+"' WHERE `color`.`id` = "+colorid+" AND `color`.`itemid` = "+itemid+";";
            st = con.createStatement();
            i = st.executeUpdate(q);
            if(i>0)
            {
                st1 = con.createStatement();
                q = "SELECT color FROM `color` WHERE id LIKE '"+colorid+"';";
                rs = st1.executeQuery(q);
                while(rs.next())
                {
                    Statement st2 = con.createStatement();
                    q = "UPDATE `cart` SET `itemstatus` = '"+status+"' WHERE `cart`.`itemid` = '"+itemid+"' AND color LIKE '"+rs.getString(1)+"';";
                    System.out.println(q);
                    i = st2.executeUpdate(q);
                }
            }
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }
    public ResultSet getcoroseldetails(String type)
    {
        try
        {
            String q = "SELECT * FROM `courosel` WHERE type LIKE '"+type+"';";
            st = con.createStatement();
            rs = st.executeQuery(q);
            return rs;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return rs;
        }
    }

    public int changecoroselstatus(String id,String status) 
    {
        int i = 0;
        try
        {
            String q = "UPDATE `courosel` SET `visible` = '"+status+"' WHERE `courosel`.`id` = "+id+";";
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }
    public int deletecoroselid(String id) 
    {
        int i = 0;
        try
        {
            String q = "DELETE FROM `courosel` WHERE id LIKE '"+id+"';";
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }

    public int updatecoroselimg(String s, String id) 
    {
        int i = 0;
        try
        {
            String q = "UPDATE `courosel` SET `location` = '"+s+"', `visible` = 'yes' WHERE `courosel`.`id` = "+id+";";
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }

    public int insertnewcorosel(String filename, String order) 
    {
        int i = 0;
        try
        {
            String q = "INSERT INTO `courosel` (`id`, `itemid`, `color`, `type`, `location`, `orderlist`, `visible`, `date`) VALUES (NULL, NULL, NULL, 'main', '"+filename+"', '"+order+"', 'yes', NOW());";
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }

    public int cancelorder(String id) 
    {
        int i = 0;
        try
        {
            String q = "UPDATE `placeorder` SET `status` = 'Order Cancelled' WHERE `placeorder`.`id` = "+id+";";
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return i;
        }
    }

    public ResultSet getcomplaints(String q) 
    {
        try
        {
            st = con.createStatement();
            rs = st.executeQuery(q);
            return rs;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return rs;
        }
    }

    public int updatecomplain(String id, String msg) 
    {
        int i = 0;
        try
        {
            String q = "UPDATE `contactus` SET `status` = '"+msg+"' WHERE `contactus`.`id` = "+id+";";
            st = con.createStatement();
            i = st.executeUpdate(q);
            return i;
        }
        catch(Exception e)
        {
            return i;
        }
    }
}