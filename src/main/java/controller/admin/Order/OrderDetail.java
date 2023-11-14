package controller.admin.Order;

import controller.admin.IpAddress;
import dao.LogDAO;
import model.*;
import service.API_LOGISTIC.Transport;
import service.IntroService;
import service.OrderService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderDetail", value = "/order_detail")
public class OrderDetail extends HttpServlet {
    String name = "Order-Detail";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0, IpAddress.getClientIpAddr(request));
        String idd = request.getParameter("id");
        int aid = Integer.parseInt(idd);
        OrderService orderService = new OrderService();
        Order od = orderService.getOderById(aid);
        request.setAttribute("order", od);
        List<Order_detail> detailList = orderService.getOrderDById(aid);
        request.setAttribute("orderDetails", detailList);
        //lay ra thong tin cua hang
        IntroService intr = new IntroService();
        Introduce intro = intr.getIntro();
        request.setAttribute("info", intro);
        Transport transport = orderService.getTransportId(aid);
        if(transport != null){
            request.setAttribute("transport", transport);
        } else {
            Transport transport1 = new Transport("Đơn hàng đang chờ xử lý", new Order(), "Đơn hàng đang chờ xử lý", "Đơn hàng đang chờ xử lý");
            request.setAttribute("transport", transport1);
        }
        log.setContent(od.toString());
        LogDAO.addLog(log);
        request.getRequestDispatcher("/views/admin/invoice-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
