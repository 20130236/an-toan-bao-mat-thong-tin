package controller.admin.Order;

import model.Introduce;
import model.Order;
import model.Order_detail;
import service.API_LOGISTIC.Login_API;
import service.API_LOGISTIC.RegisterTransport;
import service.API_LOGISTIC.Transport;
import service.IntroService;
import service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckSuccess", value = "/check_success")
public class CheckSuccess extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String status = request.getParameter("status");
        String order_id = request.getParameter("order_id");
//        String address = request.getParameter("addressId");
//        String[] arr = address.split(":");
//        String value1 = arr[0]; // giá trị đầu tiên
//        String to_district_id = arr[1]; // giá trị thứ hai
//        String to_ward_id = arr[2]; // giá trị thứ ba
//        String from_district_id = "2264";
//        String from_ward_id = "90816";
        // Do something with the selected status
        OrderService orderService = new OrderService();
        int oid = Integer.parseInt(order_id);
        int st = Integer.parseInt(status);
        orderService.updateStatus(oid, st);
        int numTrans = orderService.getNumTrans(oid);
//        if (st == 1 && numTrans == 0) {
//            Order order = new Order();
//            order.setOder_id(oid);
//            Login_API login_api = new Login_API();
//            String API_KEY = login_api.login();
//            RegisterTransport register = new RegisterTransport();
//            Transport transport =
//            orderService.addTransport(transport);
//        }
        // Forward to another servlet
        response.sendRedirect("admin-check_order");
    }
}
