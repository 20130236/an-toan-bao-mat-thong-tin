package controller.web;

import model.*;
import service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "ListFavorite", value = "/favorite")
public class ListFavorite extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PostService service = new PostService();

        List<Post_Category> list = service.getListPostCategory();
        request.setAttribute("listAr", list);

        List<Post> newA = service.getNewPost();
        request.setAttribute("newest", newA);

        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);
        //Loai sp
        ProductService productService = new ProductService();
        List<Product_type> listType = productService.getAllProduct_type();
        request.setAttribute("listType", listType);

        UserModel user = (UserModel) request.getSession().getAttribute("user");
        FavoriteService favser = new FavoriteService();

        if (Objects.isNull(user)) {
            response.sendRedirect("/lab/home");
        } else if (!Objects.isNull(user)) {
            UserModel userModel = UserService.findById(user.getId());
            request.setAttribute("user", userModel);
            String uname = userModel.getUserName();
            List<Product> li = favser.getAllProductFav(uname);
            request.setAttribute("listProduct", li);


            request.getRequestDispatcher("/views/web/user-wishlist.jsp").forward(request, response);
        }





    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
