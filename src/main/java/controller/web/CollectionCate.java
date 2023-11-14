package controller.web;


import model.Collection.Collectionss;
import model.Introduce;
import model.Post_Category;
import model.Product;
import model.Product_type;
import service.CollectionssService;
import service.IntroService;
import service.PostService;
import service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CollectionCate", value = "/collection")
public class CollectionCate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("cid");
        int pid = Integer.parseInt(id);
        CollectionssService collectionssService = new CollectionssService();
        List<Collectionss> collectionssList = collectionssService.getCollecttion();
        List<Product> products = collectionssService.getListCol(pid);
        request.setAttribute("collectionssList", collectionssList);
        request.setAttribute("list", products);

        String name = collectionssService.getNameCol(pid);
        request.setAttribute("typeName", name);
        //Lay ra danh sach loai bai viet
        PostService service = new PostService();
        ProductService productService = new ProductService();
        List<Post_Category> list = service.getListPostCategory();
        request.setAttribute("listAr", list);
        //Lay ra danh sach loai sp de chen vao header
        List<Product_type> listType = productService.getAllProduct_type();
        request.setAttribute("listType",listType);
        //Lay ra thong tin de chen vao footer
        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);
        request.getRequestDispatcher("/views/web/collection.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
