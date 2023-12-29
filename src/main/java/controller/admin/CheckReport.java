package controller.admin;

import dao.LogDAO;
import dao.RoleDAO;
import model.*;
import service.OrderService;
import service.ReportService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckReport", value = "/admin-check_report")
public class CheckReport extends HttpServlet {
    String name = "List-Check-Report";
    String listAccess1 = "xem danh sách duyệt report";

    String checkAccess1 = "duyệt yêu cầu report";
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(currentUser.getRole());
        boolean access = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(listAccess1));
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0, IpAddress.getClientIpAddr(request));
        boolean checkPm = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(checkAccess1));
        ReportService reportService = new ReportService();
        reportService.updateReportStatusByTransportLeadTime();
        List<Report> listReports = reportService.getAllReportNotCheck();
        log.setContent(listReports.toString());
        LogDAO.addLog(log);
        request.setAttribute("checkPm",checkPm);
        request.setAttribute("re",listReports);

        request.getRequestDispatcher("/views/admin/admin-checkreport.jsp").forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
