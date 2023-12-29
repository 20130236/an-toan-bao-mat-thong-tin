package controller.admin;

import dao.LogDAO;
import model.*;
import service.API_LOGISTIC.Transport;
import service.IntroService;
import service.ReportService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ReportDetail", value = "/report_detail")
public class ReportDetail extends HttpServlet {
    String name = "Report-Detail";
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0, IpAddress.getClientIpAddr(request));
        ReportService reportService = new ReportService();
        String idd = request.getParameter("id");
        int aid = Integer.parseInt(idd);
        Report reports = reportService.getReportById(aid);
        request.setAttribute("re", reports);
        //lay ra thong tin cua hang
        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);

        log.setContent(reports.toString());
        LogDAO.addLog(log);
        request.getRequestDispatcher("/views/admin/admin-reportdetail.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
