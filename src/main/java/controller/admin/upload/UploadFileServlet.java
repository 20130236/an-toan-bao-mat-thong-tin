package controller.admin.upload;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Paths;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductSearchDAO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "UploadFileServlet", value = "/UploadDownloadFileServlet")
public class UploadFileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ServletFileUpload uploader = null;

    @Override
    public void init() throws ServletException{
        DiskFileItemFactory fileFactory = new DiskFileItemFactory();
        File filesDir = (File) getServletContext().getAttribute("javax.servlet.context.tempdir");
        fileFactory.setRepository(filesDir);
        this.uploader = new ServletFileUpload(fileFactory);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filePath = "E:/LapTrinhWeb/cuoi ky/HappyHome/src/main/webapp/upload";
        if(!ServletFileUpload.isMultipartContent(request)){
            throw new ServletException("Content type is not multipart/form-data");
        }
        int id = 0;
        try {
            List<FileItem> fileItemsList = uploader.parseRequest(request);
            for (FileItem fileItem1 : fileItemsList) {
                if (fileItem1.getFieldName().equals("id_pro")) {
                    id = Integer.parseInt(fileItem1.getString());
                }
            }
                ProductSearchDAO.deleteAllImg(id);
            for (FileItem fileItem : fileItemsList) {
                if(!fileItem.isFormField()){
                    String fileName = fileItem.getName();
                    File productDir = new File(filePath);
                    if(!productDir.exists())productDir.mkdirs();
                    File file = new File(filePath + File.separator + fileName);
                    if(file.exists()){
                        String currentTime = String.valueOf(System.currentTimeMillis());
                        file = new File(filePath + File.separator + currentTime + "-" + fileName);
                        ProductSearchDAO.addImg(id, "/upload/"  + currentTime  + "-"  + fileName );
                    } else {
                        ProductSearchDAO.addImg(id,"/upload/"   +  fileName);
                    }
                    fileItem.write(file);
                    System.out.println(file.getAbsolutePath());
                }
            }
            response.sendRedirect("edit_product?pid=" + id);
        } catch (Exception e) {
            System.out.println("failure yo upload");
        }
    }
}

