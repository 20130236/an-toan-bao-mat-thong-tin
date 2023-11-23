package controller.web;

import dao.ProductSearchDAO;
import domain.Email;
import model.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import service.*;
import util.EmailUtil;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Random;


@WebServlet(name = "AccountController", urlPatterns = "/account")
public class AccountController extends HttpServlet {
    private ServletFileUpload uploader = null;

    @Override
    public void init() throws ServletException {
        DiskFileItemFactory fileFactory = new DiskFileItemFactory();
        File filesDir = (File) getServletContext().getAttribute("javax.servlet.context.tempdir");
        fileFactory.setRepository(filesDir);
        this.uploader = new ServletFileUpload(fileFactory);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Lay ra danh sach loai bai viet
        PostService service = new PostService();
        ProductService productService = new ProductService();
        List<Post_Category> list = service.getListPostCategory();
        request.setAttribute("listAr", list);
        //Lay ra danh sach loai sp de chen vao header
        List<Product_type> listType = productService.getAllProduct_type();
        request.setAttribute("listType", listType);
        //Lay ra thong tin de chen vao footer
        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);
        OrderService orderService = new OrderService();
        orderService.updateOrderStatusByTransportLeadTime();
        UserModel oldUser = (UserModel) request.getSession().getAttribute("user");
        if (oldUser == null) {
            response.sendRedirect(request.getContextPath() + "/lab/login");
        } else {
            UserModel user = UserService.findById(oldUser.getId());
            request.setAttribute("user", user);
            List<Order> orders = orderService.getOderByUname(user.getUserName());
            request.setAttribute("od", orders);
            RequestDispatcher rd = request.getRequestDispatcher("views/web/user-acount.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String emailAddress = request.getParameter("email");
        String full_name = request.getParameter("full_name");
        String phone_num = request.getParameter("phone_num");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        int id = Integer.parseInt(request.getParameter("id"));
        String signatureText = request.getParameter("signature");
        String username = request.getParameter("user_name");

        Font font = getRandomFont(request, response);
        String path = createSignature(signatureText, username, font);
        UserService.createSignature(path, username);


        UserService.updateUserWeb(id, full_name, phone_num, emailAddress, address, gender, signatureText);
        request.setAttribute("success", "Cập nhật thông tin thành công");
        response.sendRedirect(request.getContextPath() + "/account");
        Email email = new Email();
        email.setFrom("happyhomenoithat@gmail.com");
        email.setTo(emailAddress);
        email.setFromPassword("smckqxzmhsecmqld");
        email.setSubject("HappyHome - Chữ ký điện tử");
        StringBuilder sb = new StringBuilder();
        sb.append("<div style=\"font-size:16px;color:black;\">");
        sb.append("<p style=\"font-size:24px;\">Tải chữ ký điện tử <p>");
        sb.append("<span>Xin chào </span>").append(full_name).append("<br><br>");
        sb.append("<span>Click vào đường dẫn dưới đây để tải chữ ký của bạn!").append("<strong> Nội Thất HappyHome</strong></span>").append("<br>");
        sb.append("<button style=\"padding:20px 15px;color:#fff;background-color:#343a40;border-radius:4px;\"><a href=http://localhost:8080").append("/signature?uid=").append(id).append(" style=\"font-size:16px;text-decoration: none;color:#fff\">Link tải</a></button>").append("<br><br>");
        sb.append("<span>Trân trọng!</span>").append("<br>");
        sb.append("<span>Cảm ơn</span>");
        email.setContent(sb.toString());
        EmailUtil.send(email);
    }

    private Font getRandomFont(HttpServletRequest request, HttpServletResponse response) {
        String[] fontNames = {"Arial", "Helvetica", "Times New Roman", "Verdana", "Courier New"};
        Random random = new Random();
        int randomIndex = random.nextInt(fontNames.length);
        String randomFontName = fontNames[randomIndex];

        // Get the ServletContext
        ServletContext servletContext = getServletContext();

        // Construct the relative path to the font file
        String relativePath = "/fonts/" + randomFontName + ".ttf";

        // Get the real path of the font file within the web application
        String realPath = servletContext.getRealPath(relativePath);

        // Load the font file using the real path
        try (InputStream fontStream = servletContext.getResourceAsStream(relativePath)) {
            if (fontStream != null) {
                System.out.println("Da load dc font");
                Font font = Font.createFont(Font.TRUETYPE_FONT, fontStream);
                return font.deriveFont(Font.PLAIN, 50);
            } else {
                System.out.println("Font file not found: " + realPath);
            }
        } catch (FontFormatException | IOException e) {
            System.out.println("Error loading font: " + e.getMessage());
        }
        return null;
    }

    public String createSignature(String signatureText, String username, Font font) {
        int width = 400;
        int height = 160;

        // Create a BufferedImage with the specified width and height
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        // Get the Graphics2D object from the image
        Graphics2D g2d = image.createGraphics();

        // Set the background color
        Color backgroundColor = Color.getHSBColor(0, 0, 0.9f);
        g2d.setColor(backgroundColor);
        g2d.fillRect(0, 0, width, height);

        // Set the signature text and font

        // Set the font color
        g2d.setColor(Color.BLACK);

        // Set the font
        g2d.setFont(font);

        // Calculate the position to center the text
        int stringWidth = g2d.getFontMetrics().stringWidth(signatureText);
        int x = (width - stringWidth) / 2;
        int y = height / 2;

        // Draw the signature text on the image
        g2d.drawString(signatureText, x, y);
        // Dispose the Graphics2D object
        g2d.dispose();

        String currentTime = String.valueOf(System.currentTimeMillis());
        String fileName = currentTime + "-" + username + ".png"; // Replace with the name of your font file

        // Get the ServletContext
        ServletContext servletContext = getServletContext();

        // Construct the relative path to the font file
        String relativePath = "/signature/" + fileName;

        // Get the real path of the font file within the web application
        String realPath = servletContext.getRealPath(relativePath);
        // Save the image to a file

        File outputFile = new File(realPath);
        System.out.println("realPath chu ky:" + realPath);
        try {
            outputFile.createNewFile();
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            ImageIO.write(image, "png", outputFile);
            System.out.println("Image created successfully.");
        } catch (IOException e) {
            System.out.println("Error creating image: " + e.getMessage());
        }

        return relativePath;
    }

    private File upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<FileItem> fileItemsList = uploader.parseRequest(request);
        String filePath = "/signature";
        for (FileItem fileItem : fileItemsList) {
            if (!fileItem.isFormField()) {
                String fileName = fileItem.getName();
                //File productDir = new File(filePath);
                //if(!productDir.exists())productDir.mkdirs();
                File file = new File(filePath + fileName);
                if (file.exists()) {
                    String currentTime = String.valueOf(System.currentTimeMillis());
                    file = new File(filePath + File.separator + currentTime + "-" + fileName);
                }
                fileItem.write(file);
                System.out.println("upload chu ky" + file.getAbsolutePath());
            }
        }
        return null;
    }
}
