package controller.web;

import controller.admin.IpAddress;
import dao.UserDAO;
import digitalsignature.USERKEY.DSA;
import domain.Email1;
import model.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import service.*;
import util.EmailUtil;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.KeyPair;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "UserReport", value = "/user_report")
public class UserReport extends HttpServlet {
    String name ="User-Report";
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Lay ra danh sach loai bai viet
        PostService service = new PostService();
        ProductService productService = new ProductService();
        List<Post_Category> list = service.getListPostCategory();
        request.setAttribute("listAr", list);
        //Lay ra danh sach loai sp de chen vao header
        List<Product_type> listType = productService.getAllProduct_type();
        request.setAttribute("listType",listType);
        //Lay ra thong tin de chen vao footer
        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);

        UserModel oldUser = (UserModel) request.getSession().getAttribute("user");
        if (oldUser == null) {
            response.sendRedirect(request.getContextPath() + "/lab/login");
        } else {
            UserModel user = UserService.findById(oldUser.getId());
            request.setAttribute("user", user);
            RequestDispatcher rd = request.getRequestDispatcher("views/web/user-report.jsp");
            rd.forward(request, response);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("user");
        Log log = new Log(Log.INFO, currentUser.getId(), this.name, "", 0, IpAddress.getClientIpAddr(request));
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy dữ liệu từ form gửi lên
        String user_name = request.getParameter("user_name");
        String email = request.getParameter("email");
        String phoneNum = request.getParameter("phone_num");
        String detail = request.getParameter("message");
        String date_key = request.getParameter("date_key");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime parsedDate = LocalDateTime.parse(date_key, formatter);
        String dateKey = parsedDate.format(formatter);

        // Tạo đối tượng Report
        Report r = new Report(user_name, phoneNum, email, LocalDateTime.now(), detail, parsedDate, 0);

        ReportService rser = new ReportService();

        // Lấy user_id từ người dùng đang đăng nhập
        int user_id = currentUser.getId();
        rser.addReport(r, user_id);

        // Thêm bản ghi vào cơ sở dữ liệu

        request.setAttribute("success", "Gửi yêu cầu thành công");
        // Log the action
        log.setContent(r.toString());
        log.setLevel(Log.ALERT);
        LogService.addLog(log);

        DSA dsa = new DSA();
        UserDAO usd = new UserDAO();

//        if (Integer.parseInt(pstatus) == 1) {
            // cập nhật lại trạng thái đn hàng
            OrderService os = new OrderService();
            os.updateLeakKey(user_name, dateKey);

            try {
                // Tạo cặp khóa
                KeyPair keyPair = dsa.generateKeyPair();

                // Lưu private key vào file
                byte[] privateKeyBytes = keyPair.getPrivate().getEncoded();
                String fileName = "private_key.bin";
                try (FileOutputStream fos = new FileOutputStream(fileName)) {
                    fos.write(privateKeyBytes);
                } catch (IOException e) {
                    e.printStackTrace();
                }

                // Gửi private key qua email người dùng
                Email1 email1 = new Email1();
                email1.setFrom("happyhomenoithat@gmail.com");
                email1.setTo(email);
                email1.setFromPassword("smckqxzmhsecmqld");
                email1.setSubject("HappyHome - Private Key");

                // Nội dung email
                StringBuilder sb = new StringBuilder();
                sb.append("<div style=\"font-size:16px;color:black;\">");
                sb.append("<p style=\"font-size:24px;\">Tải private key</p>");
                sb.append("<span>Xin chào </span>").append(usd.findFullnameById(user_id)).append("<br><br>");
                sb.append("<span>Đây là private key của bạn: </span>").append("<br>");

                // Đính kèm private key vào email
                MimeBodyPart attachmentPart = new MimeBodyPart();
                attachmentPart.setDataHandler(new DataHandler(new FileDataSource(fileName)));
                attachmentPart.setFileName(fileName);

                // Tạo đối tượng MimeMultipart để kết hợp văn bản và file đính kèm
                Multipart multipart = new MimeMultipart();
                multipart.addBodyPart(attachmentPart);

                // Thêm nội dung văn bản vào email
                MimeBodyPart textPart = new MimeBodyPart();
                textPart.setText(sb.toString(), "UTF-8", "html");

                multipart.addBodyPart(textPart);

                // Đặt nội dung email
                email1.setContent(multipart);

                // Gửi email
                EmailUtil.send(email1);

                // Lưu public key vào database
                //     userDAO.createKey();
                dsa.savePublicKeyToDatabase(keyPair.getPublic(), user_id);
            } catch (Exception e) {
                e.printStackTrace();
            }
//        }

        // Hiển thị thông báo thành công và chuyển hướng
        response.sendRedirect(request.getContextPath() + "/user_report?success=1");
    }
}
