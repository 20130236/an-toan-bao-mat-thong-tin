package controller.admin;

import dao.RoleDAO;
import model.Permission;
import model.Role;
import model.UserModel;
import util.MessageUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "RoleData", value = "/admin-role-data")
public class RoleData extends HttpServlet {
    private static String editAccess = "sửa quyền";
    private static String deleteAccess = "xoá quyền";
    private static String addAccess = "thêm quyền";
    private static String listAccess = "xem danh sách quyền";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action")==null?"":request.getParameter("action");
        UserModel user = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(user.getRole());
        boolean access = access(action,roleUser);
        boolean deletePm = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(deleteAccess));
        MessageUtil.showMessage(request);
        List<Role> roles = RoleDAO.findAll();
        if(action.equals("add")){
            if(!access){
                response.sendRedirect("/admin-role-data?message=not_permission");
                return;
            }
            ArrayList<Permission> permissions =  RoleDAO.getAllpermiss();
            request.setAttribute("permissions",permissions);
            request.getRequestDispatcher("views/admin/add-role.jsp").forward(request,response);
            return;
        }
        if(action.equals("delete")){
            if(!access){
                response.sendRedirect("/admin-role-data?message=not_permission");
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
            RoleDAO.delete(id);
            roles = RoleDAO.findAll();
            request.setAttribute("roles", roles);
            request.getRequestDispatcher("views/admin/role-data.jsp").forward(request,response);
            return;
        }
        if(action.equals("edit")){
            if(!access){
                response.sendRedirect("/admin-role-data?message=not_permission");
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
                Role role = RoleDAO.findById(id);
                ArrayList<Permission> permissions =  RoleDAO.getAllpermiss();
                request.setAttribute("permissions",permissions);
                request.setAttribute("role",role);
                request.getRequestDispatcher("views/admin/edit-role.jsp").forward(request,response);
                return;
        }
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        request.setAttribute("deletePm",deletePm);
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("views/admin/role-data.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private static boolean access(String action,Role role) throws ServletException, IOException {
        int access;
        if(action.equals("edit")){
            access = RoleDAO.findIdPermissionByName(editAccess);
        } else if (action.equals("add")) {
            access = RoleDAO.findIdPermissionByName(addAccess);
        } else if (action.equals("delete")) {
            access = RoleDAO.findIdPermissionByName(deleteAccess);
        } else {
            access = RoleDAO.findIdPermissionByName(listAccess);
        }
        return Access.checkAccess(role.getPermission(),access);
    }
}
