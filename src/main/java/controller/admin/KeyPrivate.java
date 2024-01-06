package controller.admin;

import digitalsignature.USERKEY.DSA;
import domain.Email1;
import model.UserModel;
import util.EmailUtil;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.security.KeyPair;
import java.util.Base64;

@WebServlet(name = "KeyPrivate", value = "/keyPrivate")
public class KeyPrivate extends HttpServlet {
    DSA dsa = new DSA();
    
    //Tạo key và lưu public key vào database,tải private key về máy người dùng
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
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
            email1.setTo(currentUser.getEmail());
            email1.setFromPassword("smckqxzmhsecmqld");
            email1.setSubject("HappyHome - Private Key");

            // Nội dung email
            StringBuilder sb = new StringBuilder();
            sb.append("<div style=\"font-size:16px;color:black;\">");
            sb.append("<p style=\"font-size:24px;\">Tải private key</p>");
            sb.append("<span>Xin chào </span>").append("<br><br>");
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
            dsa.savePublicKeyToDatabase(keyPair.getPublic(), currentUser.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin-check_report");
    }
}
