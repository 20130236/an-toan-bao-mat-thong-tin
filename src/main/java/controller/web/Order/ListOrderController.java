package controller.web.Order;

import domain.Email;
import model.*;
import service.*;
import util.EmailUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "ListOrderController", urlPatterns = "/list_order")
public class ListOrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        OrderService orderService = new OrderService();
        orderService.updateOrderStatusByTransportLeadTime();
        UserModel oldUser = (UserModel)request.getSession().getAttribute("user");
        if(oldUser == null){
            response.sendRedirect(request.getContextPath() + "/login");
        } else{
            UserModel user = UserService.findById(oldUser.getId());
            request.setAttribute("user",user);
            List<Order> orders = orderService.getOderByUname(user.getUserName());
            request.setAttribute("od", orders);
            RequestDispatcher rd = request.getRequestDispatcher("views/web/user-order.jsp");
            rd.forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

}
