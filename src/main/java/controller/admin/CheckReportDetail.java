package controller.admin;

import dao.LogDAO;
import dao.RoleDAO;
import dao.UserDAO;
import digitalsignature.USERKEY.DSA;
import domain.Email1;
import model.*;
import service.IntroService;
import service.LogService;
import service.OrderService;
import service.ReportService;
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
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.KeyPair;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import static digitalsignature.USERKEY.DSA.getCurrentTimestamp;

@WebServlet(name = "CheckReportDetail", value = "/check_reportdetail")
public class CheckReportDetail extends HttpServlet {
    String name = "Check-Detail";
    String checkAccess1 = "duyệt yêu cầu report";
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(currentUser.getRole());
        boolean access = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(checkAccess1));
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        String idParameter = request.getParameter("id");
        Logger logger = Logger.getLogger(CheckReportDetail.class.getName());

        if (idParameter != null) {
            logger.info("Value of 'id' parameter: " + idParameter);
        } else {
            logger.warning("'id' parameter is null or empty");
            response.sendRedirect(request.getContextPath() + "/error-page");
            return;
        }
        int id;
        try {
            id = Integer.parseInt(idParameter);
        } catch (NumberFormatException e) {
            // Handle the case where 'id' parameter cannot be parsed as an integer
            logger.warning("Unable to parse 'id' parameter as an integer");
            response.sendRedirect(request.getContextPath() + "/error-page");
            return;
        }

        Log log = new Log(Log.INFO, currentUser.getId(), this.name, "", 0, IpAddress.getClientIpAddr(request));
        ReportService reportService = new ReportService();
        Report reports = reportService.getReportById(id);

        if (reports == null) {
            // Handle the case where the report with the specified id is not found
            logger.warning("Report with id " + id + " not found");
            response.sendRedirect(request.getContextPath() + "/error-page");
            return;
        }

        request.setAttribute("re", reports);

        log.setContent(reports.toString());
        LogDAO.addLog(log);
        request.getRequestDispatcher("/views/admin/admin-checkreportdetail.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.INFO, currentUser.getId(), this.name, "", 0, IpAddress.getClientIpAddr(request));

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        int pid = Integer.parseInt(request.getParameter("report_id"));
        String pstatus = request.getParameter("status");
        int uid = Integer.parseInt(request.getParameter("user_id"));
        String user_name = request.getParameter("user_name");
        String date_key = request.getParameter("date_key");
        String email = request.getParameter("email");

        Logger logger = Logger.getLogger(CheckReportDetail.class.getName());
        String dateKey;
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime parsedDate = LocalDateTime.parse(date_key, formatter);
            dateKey = parsedDate.format(formatter);
        } catch (NumberFormatException e) {
            // Handle the case where 'id' parameter cannot be parsed as an integer
            logger.warning("Unable to convert data type");
            response.sendRedirect(request.getContextPath() + "/error-page");
            return;
        }

        DSA dsa = new DSA();
        UserDAO usd = new UserDAO();
        Report p = new Report();
        log.setContent(p.toString());
        LogService.addLog(log);
        ReportService ser = new ReportService();
        ser.updateStatus(pid, Integer.parseInt(pstatus));

        if (Integer.parseInt(pstatus) == 1) {
            // cập nhật lại trạng thái đn hàng
            OrderService os = new OrderService();
            os.updateLeakKey(user_name, dateKey);

            // thu hổi key và tạo mới
//            response.sendRedirect(request.getContextPath() + "/keyPrivate");
//            return;

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
                sb.append("<span>Xin chào </span>").append(usd.findFullnameById(uid)).append("<br><br>");
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
                dsa.savePublicKeyToDatabase(keyPair.getPublic(), uid);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin-check_report");

    }
}

