package controller.admin.API;

import com.fasterxml.jackson.databind.ObjectMapper;
import controller.admin.IpAddress;
import dao.ProductSearchDAO;
import model.Log;
import model.Product;
import model.UserModel;
import service.LogService;
import service.ProductService;
import util.HttpUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/api-admin-product"})
public class ProductAPI  extends HttpServlet {
    String name = "List-Product";
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.WARNING,currentUser.getId(),this.name + " DELETE ","",0, IpAddress.getClientIpAddr(request));
        ObjectMapper mapper = new ObjectMapper();
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        Product product =  HttpUtil.of(request.getReader()).toModel(Product.class);
        log.setContent(ProductService.getByIds(product).toString());
        log.setLevel(Log.WARNING);
        ProductSearchDAO.deletes(product);
        LogService.addLog(log);
        mapper.writeValue(response.getOutputStream(), "{}");
    }
}
