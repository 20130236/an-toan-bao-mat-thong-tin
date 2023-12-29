package controller.admin;

import dao.LogDAO;
import dao.RoleDAO;
import model.*;
import service.IntroService;
import service.ReportService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

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
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0, IpAddress.getClientIpAddr(request));
        ReportService reportService = new ReportService();
        String idd = request.getParameter("id");
        int aid = Integer.parseInt(idd);
        Report reports = reportService.getReportById(aid);
        request.setAttribute("re", reports);

        log.setContent(reports.toString());
        LogDAO.addLog(log);

        request.getRequestDispatcher("/views/admin/admin-checkreportdetail.jsp").forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
//        Role roleUser = RoleDAO.findById(currentUser.getRole());
//        boolean access = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(checkAccess1));
//        if(!access){
//            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
//            return;
//        }
//        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0, IpAddress.getClientIpAddr(request));
//        ReportService reportService = new ReportService();
//        String idd = request.getParameter("id");
//        int aid = Integer.parseInt(idd);
//        Report reports = reportService.getReportById(aid);
//        request.setAttribute("re", reports);
//
//        // Lấy giá trị trạng thái mới từ form
//        String status = request.getParameter("status");
//
//        int st = Integer.parseInt(status);
//
//        // Cập nhật trạng thái report
//        reports.setStatus(st);
//
//        // Lưu cập nhật xuống cơ sở dữ liệu
//        reportService.updateReport(reports);
//        log.setContent(reports.toString());
//        LogDAO.addLog(log);
//
//        // Chuyển hướng hoặc hiển thị thông báo thành công (tuỳ vào yêu cầu của bạn)
//        response.sendRedirect(request.getContextPath() + "/path/to/success-page");

    }
}
