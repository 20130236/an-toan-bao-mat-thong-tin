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

@WebServlet(name = "ListProduct", value = "/list_product")
public class ListProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Goi service de thuc hien getAll
        ProductService service = new ProductService();
        //phan trang
        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);


        List<Product> list = service.pagingProduct(index);
        int count = service.getTotalProduct();
        int endPage = count / 15; //moi trang 15 sp
        if (count % 15 != 0) {
            endPage++;
        }
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);
        request.setAttribute("num", count);
        request.setAttribute("indexPage", indexPage);

        List<Post_Category> listAr = PostService.getListPostCategory();
        request.setAttribute("listAr", listAr);
        // lay ra list product
        //   List<Product> list = service.getAllProduct();
        List<Product_type> listType = service.getAllProduct_type();
        request.setAttribute("listType", listType);
        request.setAttribute("list", list);

        Product_type name = new Product_type(500, "Tất cả sản phẩm");
        request.setAttribute("typeName", name);
        //lay ra dl de chen vao footer
        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);

        request.getRequestDispatcher("/views/web/table.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
