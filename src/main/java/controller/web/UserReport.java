package controller.web;

import controller.admin.IpAddress;
import model.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import service.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
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


            RequestDispatcher rd = request.getRequestDispatcher("views/web/user-report.jsp");
            rd.forward(request,response);

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

        // Tạo đối tượng Report
        Report r = new Report(user_name, phoneNum, email, LocalDateTime.now(), detail, 0);

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

        // Hiển thị thông báo thành công và chuyển hướng
        response.sendRedirect(request.getContextPath() + "/user_report?success=1");
    }
}
