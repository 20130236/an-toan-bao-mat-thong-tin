package controller.admin;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import model.Product;
import service.ProductService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "SearchProductName", value = "/searchProductName")
public class SearchProductName extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ObjectMapper mapper = new ObjectMapper();
        String txtSearch = request.getParameter("txtSearch");
        ProductService service = new ProductService();
        List<Product> products = service.getProductByName(txtSearch);
        response.setContentType("application/json");
        /*PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        String json = gson.toJson(products);
        out.print(json);
        out.flush();*/
        mapper.writeValue(response.getOutputStream(), products);
    }
}
