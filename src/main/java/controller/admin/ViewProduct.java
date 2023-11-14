package controller.admin;

import dao.ProductSearchDAO;
import model.Product;
import service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewProduct", value = "/view_product")
public class ViewProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //lay ra id tu request
        String id = request.getParameter("pid");
        int aid = Integer.parseInt(id);
        //lay ra san pham tuong ung
        ProductService service = new ProductService();
        Product p = service.getProductById(aid);
        request.setAttribute("product", p);
        request.getRequestDispatcher("/views/admin/view-product.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
