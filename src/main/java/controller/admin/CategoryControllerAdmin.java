package controller.admin;

import dao.RoleDAO;
import model.CategoryProModel;
import model.Role;
import model.UserModel;
import service.CategoryProService;
import util.MessageUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryController", value = "/admin-data-category")
public class CategoryControllerAdmin extends HttpServlet {

    String name = "List-Category-Product";
    private static String editAccess = "sửa danh mục sản phẩm";
    private static String deleteAccess = "xoa danh muc sản phẩm";
    private static String addAccess = "thêm danh mục sản phẩm";
    private static String listAccess = "xem danh sach danh muc sản phẩm";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = "";
        if(request.getParameter("action") != null){
            action = request.getParameter("action");
        }
        UserModel user = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(user.getRole());
        boolean access = access(action,roleUser);
        boolean deletePm = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(deleteAccess));
        MessageUtil.showMessage(request);
        List<CategoryProModel> listCate;
        if(action.equals("add")){
            if(!access){
                response.sendRedirect("admin-data-category?message=not_permission");
                return;
            }
            String name = request.getParameter("cate");
            CategoryProService.addCate(name);
            response.sendRedirect("admin-data-category?message=insert_success");
            return;
        }
        if(action.equals("delete")){
            if(!access){
                response.sendRedirect("admin-data-category?message=not_permission");
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
            CategoryProService.deleteCate(id);
            response.sendRedirect("admin-data-category?message=delete_success");
            return;
        }
        if(action.equals("edit")){
            if(!access){
                response.sendRedirect("admin-data-category?message=not_permission");
                return;
            }
            String name = request.getParameter("cate");
            int id = Integer.parseInt(request.getParameter("id"));
            if(name == null){
                CategoryProModel cate = CategoryProService.findById(id);
                request.setAttribute("cate",cate);
                request.getRequestDispatcher("views/admin/edit-category-product.jsp").forward(request,response);
                return;
            }
            CategoryProService.updateCate(id,name);
            CategoryProModel cate = CategoryProService.findById(id);
            request.setAttribute("cate",cate);
            request.setAttribute("success","Sửa thành công");
            request.getRequestDispatcher("views/admin/edit-category-product.jsp").forward(request,response);
            return;
        }
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        listCate = CategoryProService.findAll();
        request.setAttribute("listCate",listCate);
        request.setAttribute("deletePm",deletePm);
        RequestDispatcher rd = request.getRequestDispatcher("views/admin/category-product.jsp");
        rd.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private static boolean access(String action, Role role) throws ServletException, IOException {
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
