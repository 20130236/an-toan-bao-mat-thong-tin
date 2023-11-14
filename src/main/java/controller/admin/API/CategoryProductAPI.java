package controller.admin.API;

import com.fasterxml.jackson.databind.ObjectMapper;
import controller.admin.IpAddress;
import dao.CategoryProDAO;
import model.CategoryProModel;
import model.Log;
import model.UserModel;
import util.HttpUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/api-admin-category-product"})
public class CategoryProductAPI extends HttpServlet {
    String name = "List-Category-Product";

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.INFO,currentUser.getId(),this.name + " DELETE","",0, IpAddress.getClientIpAddr(request));
        ObjectMapper mapper = new ObjectMapper();
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        CategoryProModel categoryPro =  HttpUtil.of(request.getReader()).toModel(CategoryProModel.class);
        log.setContent(CategoryProDAO.findByIds(categoryPro).toString());
        log.setLevel(Log.WARNING);
        CategoryProDAO.deletes(categoryPro);
        mapper.writeValue(response.getOutputStream(), "{}");
    }
}
