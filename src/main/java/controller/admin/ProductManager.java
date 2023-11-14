package controller.admin;

import dao.RoleDAO;
import model.*;

import service.LogService;
import service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

@WebServlet(name = "ProductManager", value = "/admin-product_manager")
public class ProductManager extends HttpServlet {
    String name = "List-Product";

    private static String deteleAccess = "xoá sản phẩm";
    private static String listAccess = "xem danh sách sản phẩm";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(currentUser.getRole());
        boolean access = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(listAccess));
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        boolean detelePm = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(deteleAccess));
        ProductService service = new ProductService();
        List<Product> pro = service.getAllProduct();
        request.setAttribute("deletePm",detelePm);
        request.setAttribute("listProduct", pro);
        request.getRequestDispatcher("views/admin/data-product.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
