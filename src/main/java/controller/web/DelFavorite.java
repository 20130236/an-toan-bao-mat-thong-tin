package controller.web;

import model.Favorite;
import model.UserModel;
import service.FavoriteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

@WebServlet(name = "DelFavorite", value = "/favorite/del")
public class DelFavorite extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        UserModel user = (UserModel) request.getSession().getAttribute("user");
        FavoriteService favser = new FavoriteService();

        String id = request.getParameter("id");

        int pid = Integer.parseInt(id);
        if (Objects.isNull(user)) {
            response.sendRedirect("/login");
        } else if (!Objects.isNull(user)) {
            try {
                String userName = user.getUserName();
                favser.deleteFav(userName, pid);
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            response.sendRedirect("/lab/favorite");
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
