package controller.admin.Order;

import controller.admin.Access;
import controller.admin.IpAddress;
import dao.LogDAO;
import dao.RoleDAO;
import model.Log;
import model.Order;
import model.Role;
import model.UserModel;
import service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderControllerCheck", value = "/admin-order-controller-check")
public class OrderControllerCheck extends HttpServlet {
    String name = "List-invoice";
    String ListAccess = "xem danh sách đơn hàng";
    String CheckAccess = "duyệt đơn hàng";
    String DetailAccess = "xem chi tiết đơn hàng";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserModel currentUser = (UserModel) request.getSession().getAttribute("auth");
        Role roleUser = RoleDAO.findById(currentUser.getRole());
        boolean access = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(ListAccess));
        if(!access){
            request.getRequestDispatcher("views/admin/no-permission.jsp").forward(request, response);
            return;
        }
        boolean checkPm = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(CheckAccess));
        boolean detailPm = Access.checkAccess(roleUser.getPermission(),RoleDAO.findIdPermissionByName(DetailAccess));
        Log log = new Log(Log.INFO,currentUser.getId(),this.name,"",0, IpAddress.getClientIpAddr(request));
        OrderService orderService = new OrderService();
        orderService.updateOrderStatusByTransportLeadTime();
        List<Order> listOrders = orderService.getAllOder();
        log.setContent(listOrders.toString());
        LogDAO.addLog(log);
        request.setAttribute("checkPm",checkPm);
        request.setAttribute("detailPm",detailPm);
        request.setAttribute("listOrders",listOrders);
        request.getRequestDispatcher("/views/admin/invoice-data-check.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}