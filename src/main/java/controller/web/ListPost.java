package controller.web;

import model.Post;
import model.Post_Category;
import model.Introduce;
import model.Product_type;
import service.PostService;
import service.IntroService;
import service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListAllPost", value = "/list_posts")
public class ListPost extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String indexPage = request.getParameter("index");
        if (indexPage == null) {
            indexPage = "1";
        }
        int index = Integer.parseInt(indexPage);

        PostService service = new PostService();
        List<Post> list = service.pagingPost(index);
        int count = service.getTotalPost();
        int endPage = count / 3; //moi trang 3 bai
        if (count % 3 != 0) {
            endPage++;
        }
        List<Post_Category> listArCategory = service.getListPostCategory();
        request.setAttribute("listAr", listArCategory);
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);

        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);
        request.setAttribute("list", list);
        //Loai sp
        ProductService productService = new ProductService();
        List<Product_type> listType = productService.getAllProduct_type();
        request.setAttribute("listType",listType);

        request.getRequestDispatcher("/views/web/blog-list-sidebar-left.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
