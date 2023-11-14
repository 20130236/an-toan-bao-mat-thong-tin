package controller.admin;

import dao.RoleDAO;
import model.Introduce;
import model.Role;
import model.RoleModel;
import model.UserModel;
import service.IntroService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "InfoController", value = "/admin-info_controller")
public class InfoController extends HttpServlet {

    String listAccess = "sửa thông tin trên website";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserModel user = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(user.getRole());
        boolean access = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(listAccess));
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        IntroService intro = new IntroService();
        Introduce in = intro.getIntro();
        request.setAttribute("info",in);
        request.getRequestDispatcher("views/admin/info.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String n = request.getParameter("pname");
        String intro = request.getParameter("pintroduce");
        String add = request.getParameter("paddress");
        String showr = request.getParameter("pshowroom");
        String time = request.getParameter("ptimework");
        String em = request.getParameter("pemail");
        String p = request.getParameter("pphone");
        String cap = request.getParameter("pcaption");

        IntroService se = new IntroService();
        se.editIntro(n,intro,add,showr,time,em,p,cap);
        response.sendRedirect("/info_controller");
    }
}
