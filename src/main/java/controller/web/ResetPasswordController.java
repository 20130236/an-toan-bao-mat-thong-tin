package controller.web;

import domain.Email;
import model.Post_Category;
import model.Introduce;
import model.Product_type;
import model.UserModel;
import service.PostService;
import service.IntroService;
import service.ProductService;
import service.UserService;
import util.EmailUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ResetPasswordController", urlPatterns = "/reset-password")
public class ResetPasswordController extends HttpServlet {

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
        RequestDispatcher rd = request.getRequestDispatcher("views/web/user-reset-password.jsp");
        rd.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String emailAddress = request.getParameter("email");
        String username = request.getParameter("username");
        UserModel user = UserService.findByUserAndEmail(username,emailAddress);
        if(user == null){
            request.setAttribute("error","Tên tài khoản hoặc email không đúng");
        } else {
            int id = user.getId();
            String token = UserService.createToken();
          /*  if(UserService.checkToken(token)){
                token = UserService.createToken();
            }*/
            Thread mailThread = new Thread(new Runnable() {
                @Override
                public void run() {
                    UserService.addToken(id, token);
                    Email email = new Email();
                    email.setFrom("happyhomenoithat@gmail.com");
                    email.setTo(emailAddress);
                    email.setFromPassword("smckqxzmhsecmqld");
                    email.setSubject("HappyHome - Đổi mật khẩu");
                    StringBuilder sb = new StringBuilder();
                    sb.append("<div style=\"font-size:16px;color:black;\">");
                    sb.append("<p style=\"font-size:24px;\">Thiết lập mật khẩu <p>");
                    sb.append("<span>Xin chào </span>").append(user.getFullName()).append("<br><br>");
                    sb.append("<span>Click vào đường dẫn dưới đây để thiết lập mật khẩu tài khoản của quý khách hàng tại").append("<strong> Nội Thất HappyHome</strong></span>").append("<br>");
                    sb.append("<span>Quý khách hàng có 10 phút để thay đổi mật khẩu, sau 10 phút đường dẫn sẽ không còn tồn tại.</span>").append("<br>");
                    sb.append("<span>Nếu quý khách hàng không có yêu cầu thay đổi mật khẩu, xin hãy xóa email này để bảo mật thông tin.</span>").append("<br><br>"); /*append(request.getContextPath())*/
                    sb.append("<button style=\"padding:20px 15px;color:#fff;background-color:#343a40;border-radius:4px;\"><a href=https://datng.name.vn/lab").append("/change-password?token=").append(token).append(" style=\"font-size:16px;text-decoration: none;color:#fff\">Thiết lập lại mật khẩu</a></button>").append("<br><br>");
                    sb.append("<span>Trân trọng!</span>").append("<br>");
                    sb.append("<span>Cảm ơn</span>");
                    email.setContent(sb.toString());
                    EmailUtil.send(email);
                }
            });
            request.setAttribute("message", "Link thiết lập lại mật khẩu đã được gửi vào email của bạn."
                    + "Vui lòng check email của bạn");
            mailThread.start();
        }
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
        request.getRequestDispatcher("views/web/user-reset-password.jsp").forward(request,response);
    }
}
