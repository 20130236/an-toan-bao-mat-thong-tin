package controller.admin;

import controller.admin.datatable.DataTable;
import dao.RoleDAO;
import dao.UserDAO;
import mapper.UserMapper;
import model.Log;
import model.Role;
import model.UserModel;
import service.LogService;
import service.UserService;
import util.MessageUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DataUserController", value = "/admin-data-user")
public class DataUserController extends HttpServlet {
    String name="List-User";
    private static String editAccess = "sửa user";
    private static String deleteAccess = "xoá user";
    private static String addAccess = "thêm user";
    private static String listAccess = "xem danh sách user";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MessageUtil.showMessage(request);
        String action = request.getParameter("action")==null?"":request.getParameter("action");
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(currentUser.getRole());
        boolean access = access(action,roleUser);
        int id = 0;
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0,IpAddress.getClientIpAddr(request));
        if(request.getParameter("id") != null ) {id = Integer.parseInt(request.getParameter("id"));}

        if(action.equals("edit")){
            if(!access){
                request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
                return;
            }
            List<Role> roles = RoleDAO.findAll();
            UserModel user = UserService.findById(id);
            log.setSrc(this.name + " VIEW ");
            log.setContent(user.toString());
            LogService.addLog(log);
            request.setAttribute("roles",roles);
            request.setAttribute("user",user);
            request.getRequestDispatcher("views/admin/edit-user.jsp").forward(request, response);
            return;
        }
        if(action.equals("add")){
            if(!access){
                response.sendRedirect("/admin-role-data?message=not_permission");
                return;
            }
            List<Role> roles = RoleDAO.findAll();
            request.setAttribute("roles",roles);
            request.getRequestDispatcher("views/admin/add-user.jsp").forward(request, response);
            return;
        }
        if(action.equals("delete")){
            if(!access){
                response.sendRedirect("/admin-data-user?message=not_permission");
                return;
            }
            UserModel deleteUser = UserService.findById(id);
            UserService.delete(id);
            log.setSrc(this.name + " DELETE ");
            log.setContent(deleteUser.toString());
            log.setLevel(Log.WARNING);
            LogService.addLog(log);
            List<UserModel> users = UserService.findAll();
            request.setAttribute("users",users);
            request.getRequestDispatcher("views/admin/user-data.jsp").forward(request, response);
        }
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        boolean deletePm = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(deleteAccess));
        List<UserModel> users = UserService.findAll();
        log.setContent(users.toString());
        LogService.addLog(log);
        request.setAttribute("deletePm",deletePm);
        request.setAttribute("users",users);
        request.getRequestDispatcher("views/admin/user-data.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MessageUtil.showMessage(request);
        String action = request.getParameter("action");
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");

        int id = 0;
        int role = 0;
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String full_name = request.getParameter("full_name");
        String enable = request.getParameter("enable");

        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0,IpAddress.getClientIpAddr(request));

        if(request.getParameter("id") != null ){ id = Integer.parseInt(request.getParameter("id"));}
        if(request.getParameter("role") != null ) {role = Integer.parseInt(request.getParameter("role"));}
        if(action.equals("edit")){
            UserModel oldUser = UserService.findById(id);
            UserModel newUser = new UserModel(id,oldUser.getUserName(),oldUser.getPassWord(),role,full_name,oldUser.getPhoneNum(),email,oldUser.getAddress(),0,oldUser.getGender());
            UserService.updateAdmin(newUser,enable);
            log.setSrc(this.name + " EDIT ");
            log.setContent(newUser.toString());
            LogService.addLog(log);
            request.setAttribute("success","Cập nhật thành công");
            request.setAttribute("user",newUser);
            response.sendRedirect("admin-data-user?action=edit&id=" + id + "&message=update_success");
            return;
        }
        if(action.equals("add")){
            log.setSrc(this.name+" ADD ");
            if(UserService.checkUserName(username)){
                log.setContent("ADD USER FAIL");
                log.setContent("exist username");
                LogService.addLog(log);
                request.setAttribute("error","Tên tài khoản đã tồn tại");
                request.getRequestDispatcher("views/admin/add-user.jsp").forward(request, response);
                return;
            }
            UserModel user = new UserModel(0,username,password,role,"","",email,"",1,"");
            UserService.save(user);
            log.setContent("ADD USER SUCCESS"  + user.toString());
            LogService.addLog(log);
            request.setAttribute("success","Thêm thành công");
            request.getRequestDispatcher("views/admin/add-user.jsp").forward(request, response);
        }
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
