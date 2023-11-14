package controller.admin;

import model.Log;
import model.UserModel;
import service.LogService;
import service.UserService;
import util.MessageUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "LoginControllerAdmin", value = "/admin-login")
public class LoginControllerAdmin extends HttpServlet {
    String name= "AUTH";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MessageUtil.showMessage(request);
        RequestDispatcher rd = request.getRequestDispatcher("views/admin/login.jsp");
        rd.forward(request, response);
        //request.getRequestDispatcher("views/admin/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserModel user = UserService.checkLogin(username, password);
        Log log = new Log(Log.INFO,-1,this.name,"",0,IpAddress.getClientIpAddr(request));
        if (user != null) {
            log.setId(user.getId());
            if (user.getEnable() != 1) {
                log.setSrc(this.name+"  USER LOGIN FALSE");
                log.setContent(" USER LOGIN FALSE: User - "+ username);
                log.setLevel(Log.WARNING);
                request.setAttribute("error", "Tài khoản của bạn đã bị khoá");
                request.getRequestDispatcher("views/admin/login.jsp").forward(request, response);
                LogService.addLog(log);
                return;
            }
            if (user.checkRole(1)) {
                log.setUserId(user.getId());
                log.setSrc(this.name+"  USER LOGIN SUCCESS");
                log.setContent(" USER LOGIN SUCCESS: User - " + username);
                request.getSession().setAttribute("auth", user);
                response.sendRedirect("admin-home");
            } else {
                log.setSrc(this.name + " USER LOGIN D0 NOT HAVE ACCESS");
                log.setContent(" USER LOGIN D0 NOT HAVE ACCESS: User - "+ username);
                log.setLevel(Log.WARNING);
                request.getSession().setAttribute("auth", user);
                request.setAttribute("error", "Bạn không có quyền truy cập.");
                request.getRequestDispatcher("views/admin/login.jsp").forward(request, response);
            }
        } else {
            log.setSrc(this.name+"  USER LOGIN FALSE");
            log.setContent(" USER LOGIN FALSE: User - " + username);
            log.setLevel(Log.WARNING);
            request.setAttribute("error", "Thông tin đăng nhập không hợp lệ.");
            request.getRequestDispatcher("views/admin/login.jsp").forward(request, response);
        }
        LogService.addLog(log);
    }
}
