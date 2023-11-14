package controller.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import model.Product;
import service.ProductService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "GetProductById", value = "/getProductById")
public class GetProductById extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ObjectMapper mapper = new ObjectMapper();
        int id_product = Integer.parseInt(request.getParameter("id_product"));
        Product product = ProductService.getProductById(id_product);
        response.setContentType("application/json");
        mapper.writeValue(response.getOutputStream(),product);
    }
}
