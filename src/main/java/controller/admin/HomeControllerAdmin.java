package controller.admin;

import model.Statics.ProductSellNum;
import model.UserModel;
import service.ServiceStatistics;

import javax.lang.model.type.ArrayType;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

@WebServlet(name = "HomeControllerAdmin", value = "/admin-home")
public class HomeControllerAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel auth = (UserModel) request.getSession().getAttribute("auth");
        if( auth == null || !auth.checkRole(1)){
            request.setAttribute("error","Bạn không có quyền truy cập");
            response.sendRedirect("admin-login");
            return;
        }
        RequestDispatcher rd = request.getRequestDispatcher("views/admin/home.jsp");
        rd.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
