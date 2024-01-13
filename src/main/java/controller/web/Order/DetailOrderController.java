package controller.web.Order;

import model.*;
import service.*;
import service.API_LOGISTIC.Transport;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "DetailOrderController", urlPatterns = "/user_order")
public class DetailOrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Lay ra danh sach loai bai viet
        PostService service = new PostService();
        ProductService productService = new ProductService();
        List<Post_Category> list = PostService.getListPostCategory();
        request.setAttribute("listAr", list);
        //Lay ra danh sach loai sp de chen vao header
        List<Product_type> listType = productService.getAllProduct_type();
        request.setAttribute("listType",listType);
        //Lay ra thong tin de chen vao footer
        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);
        //
        String idd = request.getParameter("id");
        int aid = Integer.parseInt(idd);
        //
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
            //
            Order od = orderService.getOderById(aid);
            request.setAttribute("order", od);
            List<Order_detail> detailList = orderService.getOrderDById(aid);
            request.setAttribute("orderDetails", detailList);
            Transport transport = orderService.getTransportId(aid);
            int idStatus = od.getStatus();
            if(transport != null){
                request.setAttribute("transport", transport);
            } if(transport == null && idStatus ==5) {
                Transport transport1 = new Transport("Đơn hàng bị huỷ", new Order(), "Đơn hàng bị huỷ", "Đơn hàng bị huỷ");
                request.setAttribute("transport", transport1);
            } if(transport == null && idStatus ==6) {
                Transport transport1 = new Transport("Đơn hàng bị huỷ", new Order(), "Đơn hàng bị huỷ", "Đơn hàng bị huỷ");
                request.setAttribute("transport", transport1);
            }

            else if(transport == null) {
                Transport transport1 = new Transport("Đơn hàng đang chờ xử lý", new Order(), "Đơn hàng đang chờ xử lý", "Đơn hàng đang chờ xử lý");
                request.setAttribute("transport", transport1);
            }

            //
            RequestDispatcher rd = request.getRequestDispatcher("views/web/user-order-detail.jsp");
            rd.forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

}
