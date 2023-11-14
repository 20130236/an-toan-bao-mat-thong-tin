package controller.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import dao.ImportProductDAO;
import dao.RoleDAO;
import model.ImportProduct;
import model.Role;
import model.UserModel;
import util.HttpUtil;
import util.MessageUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;


@WebServlet(name = "ImportProductController",value = "/admin-import-product")
public class ImportProductController extends HttpServlet {
    private String listAccess = "nhập hàng";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel user = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(user.getRole());
        boolean access = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(listAccess));
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        MessageUtil.showMessage(request);
        RequestDispatcher rd = request.getRequestDispatcher("views/admin/import-product.jsp");
        rd.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ObjectMapper mapper = new ObjectMapper();
        UserModel currentUser = (UserModel)request.getSession().getAttribute("auth");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        /*String data = getData(request.getReader());
        ImportProduct importProduct0 = new ObjectMapper().readValue(data, ImportProduct.class);*/
        ImportProduct importProduct =  HttpUtil.of(request.getReader()).toModel(ImportProduct.class);

        //importProduct.setUsername();
        ImportProductDAO.importProducts(importProduct,currentUser.getUserName());
        mapper.writeValue(response.getOutputStream(), "{}");
    }

}