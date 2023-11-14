package controller.web;

import model.Post_Category;
import model.Introduce;
import model.ProductSearchModel;
import model.Product_type;
import service.PostService;
import service.IntroService;
import service.ProductService;
import service.ProductSearchService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchProductController", value = "/search")
public class SearchProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Lay ra danh sach loai bai viet
        PostService service = new PostService();
        ProductService productService = new ProductService();
        List<Post_Category> listt = service.getListPostCategory();
        request.setAttribute("listAr", listt);
        //Lay ra danh sach loai sp de chen vao header
        List<Product_type> listType = productService.getAllProduct_type();
        request.setAttribute("listType",listType);
        //Lay ra thong tin de chen vao footer
        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);
        String textSearch = request.getParameter("search");

        int limit = 5;
        int page = 1;
        int totalItem = 0;
        int totalPage;
        String display = "grid";
        String orderBy = "";
        String sortBy = "";
        List<ProductSearchModel> list;

        if(request.getParameter("display") != null && request.getParameter("display") != ""){
            display = request.getParameter("display");
        }
        if(request.getParameter("page") != null && request.getParameter("page") != ""){
            page = Integer.parseInt(request.getParameter("page"));
        }
        int offset = (page-1) * limit;
            if(request.getParameter("orderBy") != null && request.getParameter("orderBy") != ""){
                orderBy = request.getParameter("orderBy");
                sortBy =  request.getParameter("sortBy");
                if(orderBy.equals("onsale")){
                    list = ProductSearchService.searchByNameOnSale(textSearch, offset, limit);
                    if(list != null)totalItem = list.size();
                } else{
                    list = ProductSearchService.searchByNameOderBy(textSearch, offset, limit,orderBy,sortBy);
                    if(list != null)totalItem = list.size();
                }
            } else {
                list = ProductSearchService.searchByName(textSearch, offset, limit);
                if(list != null)totalItem = list.size();
            }
        totalPage = (int)(Math.ceil((double) totalItem/limit));
        request.setAttribute("totalItem",totalItem);
        request.setAttribute("textSearch",textSearch);
        request.setAttribute("listPro",list);
        request.setAttribute("display",display);
        request.setAttribute("page",page);
        request.setAttribute("totalPage",totalPage);
        request.setAttribute("orderBy",orderBy);
        request.setAttribute("sortBy",sortBy);
        RequestDispatcher rd = request.getRequestDispatcher("views/web/search.jsp");
        rd.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
