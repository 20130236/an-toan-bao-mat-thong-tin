package controller.web;

import model.Post_Category;
import model.Introduce;
import model.Product;
import model.Product_type;
import service.PostService;
import service.IntroService;
import service.ProductService;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
@WebServlet(name = "ProductDetail", value = "/product_detail")
public class ProductDetail extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //lay ra id cua san pham tu request
        String id = request.getParameter("pid");
        int aid = Integer.parseInt(id);
        //goi service
        ProductService service = new ProductService();
        //lay ra sp va dua vao request
        Product p = service.getProductById(aid);
        request.setAttribute("pro", p);
        //lay ra loai sp
        List<Product_type> listType = service.getAllProduct_type();
        request.setAttribute("listType",listType);

        List<Post_Category> list = PostService.getListPostCategory();
        request.setAttribute("listAr", list);
        //
        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);
        //
        List<Product> same = service.selectSameProduct(p.product_type);
        request.setAttribute("sameProduct",same);
        request.getRequestDispatcher("/views/web/product-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
