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

@WebServlet(name = "ListReportAdmin", value = "/admin-listreport_controller")
public class ListReportAdmin extends HttpServlet {
    String name = "List-report";
    String ListAccess1 = "xem danh sách report";
    String CheckAccess1 = "duyệt yêu cầu report";
    String DetailAccess1 = "xem chi tiết report";
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(currentUser.getRole());
        boolean access = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(ListAccess1));
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        boolean checkPm = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(CheckAccess1));
        boolean detailPm = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(DetailAccess1));
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0, IpAddress.getClientIpAddr(request));
        ReportService reportService = new ReportService();
        List<Report> listReports = reportService.getAllReport();
        log.setContent(listReports.toString());
        LogDAO.addLog(log);
        request.setAttribute("checkPm",checkPm);
        request.setAttribute("detailPm",detailPm);
        request.setAttribute("re",listReports);

        request.getRequestDispatcher("/views/admin/admin-listreport.jsp").forward(request,response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
