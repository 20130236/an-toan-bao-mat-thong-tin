package controller.web;

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


@WebServlet(name = "AccountController", urlPatterns = "/account")
public class AccountController extends HttpServlet {

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
            response.sendRedirect(request.getContextPath() + "/lab/login");
        } else{
            UserModel user = UserService.findById(oldUser.getId());
            request.setAttribute("user",user);
            List<Order> orders = orderService.getOderByUname(user.getUserName());
            request.setAttribute("od", orders);
            RequestDispatcher rd = request.getRequestDispatcher("views/web/user-acount.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String emailAddress = request.getParameter("email");
        String full_name  = request.getParameter("full_name");
        String phone_num = request.getParameter("phone_num");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        int id = Integer.parseInt(request.getParameter("id"));
        UserService.updateUserWeb(id,full_name,phone_num,emailAddress,address,gender);
        request.setAttribute("success","Cập nhật thông tin thành công");
        response.sendRedirect(request.getContextPath() + "/account");
        Email email = new Email();
        email.setFrom("happyhomenoithat@gmail.com");
        email.setTo(emailAddress);
        email.setFromPassword("smckqxzmhsecmqld");
        email.setSubject("Nội Thất HappyHome - Cập nhật tài khoản khách hàng");
        StringBuilder sb = new StringBuilder();
        sb.append("<div style=\"font-size:16px;color:black\">");
        sb.append("<span>Xin chào ").append(full_name).append("</span><br>");
        sb.append("<span>Tài khoản của quý khách hàng đã được cập nhật thành công.</span>").append("<br><br>");
        sb.append("<span>Họ và tên: ").append(full_name).append("</span>").append("<br>");
        sb.append("<span>Giới tính: ").append(gender).append("</span>").append("<br>");
        sb.append("<span>Email: ").append(emailAddress).append("</span>").append("<br>");
        sb.append("<span>Sđt: ").append(phone_num).append("</span>").append("<br>");
        if(address != null)sb.append("<span>Địa chỉ: ").append(address).append("</span>").append("<br><br>");
        sb.append("<span>Trân trọng!</span>").append("<br>");
        sb.append("<span>Cảm ơn </span>");
        sb.append("</div>");
        email.setContent(sb.toString());
        EmailUtil.send(email);
    }

}
