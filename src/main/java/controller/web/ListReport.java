package controller.web;

import model.*;
import service.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListReport", urlPatterns = "/user_listreport")
public class ListReport extends HttpServlet {
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

        ReportService reportService = new ReportService();
        reportService.updateReportStatusByTransportLeadTime();

        UserModel oldUser = (UserModel) request.getSession().getAttribute("user");

        if (oldUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            UserModel user = UserService.findById(oldUser.getId());
            request.setAttribute("user", user);

            List<Report> reports = reportService.getReportsByUserId(user.getId());
            request.setAttribute("re", reports);

            RequestDispatcher rd = request.getRequestDispatcher("views/web/user_listreport.jsp");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Có thể xử lý các yêu cầu POST ở đây nếu cần
    }
}
