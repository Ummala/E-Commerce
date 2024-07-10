package comm.classes;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.http.Part;


public class fileupload 
{
    public static String fileupload(Part filepart,String file,String folder) throws IOException
    {
        String filename=null;
        try
        {            
            String headers = filepart.getHeader("content-disposition");
            String imagedetails = headers.split(";")[2].replace("filename=", "");
            filename = imagedetails.replace("\"", "");
            if(filename != "" && filename != null && filepart.getSize()>200)
            {
                int dot = filename.lastIndexOf('.');
                String base = (dot == -1) ? filename : filename.substring(0, dot);
                String extension = (dot == -1) ? "" : filename.substring(dot+1);
                filename = file+"."+extension;
                InputStream inst = filepart.getInputStream();
                if (new File("F:/new project/itemdelivery/web/" + folder).exists()) 
                {    
                } 
                else 
                {
                    new File("F:/new project/itemdelivery/web/" + folder).mkdir();
                }
                String path = "F:/new project/itemdelivery/web/"+folder+"/";
                int i = 1;
                while(new File("F:/new project/itemdelivery/web/" + folder+"/"+filename).exists())
                {
                    filename = file+"("+i+")."+extension;
                    i++;
                } 
                File output = new File(path+filename);
                OutputStream outs = new FileOutputStream(output);
                byte[] img = new byte[10240];
                int l = -1;
                while((l=inst.read(img))!=-1 )
                {
                    outs.write(img,0,l);
                }
                return folder+"/"+filename;
            }
            else
            {
                return "fail";
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return "fail";
        }
    }
    public boolean checkimg(String img)
    {
        return (new File("F:/new project/itemdelivery/web/"+img).exists());
    }
    public static String getdate()
    {
        LocalDateTime myDateObj = LocalDateTime.now();  
        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("ddMMyyyyHHmmss");  
        String now = myDateObj.format(myFormatObj);  
        return now;
    }

}
