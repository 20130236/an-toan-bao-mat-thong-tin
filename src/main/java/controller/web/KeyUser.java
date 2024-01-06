package controller.web;

import controller.admin.IpAddress;
import digitalsignature.USERKEY.DSA;
import model.*;
import service.IntroService;
import service.PostService;
import service.ProductService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserKey", value = "/user_key")
public class KeyUser extends HttpServlet {
    String name = "Key-User";
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

        UserModel currentUser = (UserModel) request.getSession().getAttribute("user");
        Log log = new Log(Log.INFO, currentUser.getId(), this.name, "", 0, IpAddress.getClientIpAddr(request));
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        // Lấy user_id từ người dùng đang đăng nhập
        int user_id = currentUser.getId();
        DSA dsa = new DSA();
        if (dsa.getPublicKeyFromDatabase(user_id) == null) {
            // Người dùng chưa có public key, cho phép truy cập trang tạo key
            RequestDispatcher rd = request.getRequestDispatcher("views/web/user-key.jsp");
            rd.forward(request,response);
        } else {
            //Người dùng có public key
            // Chuyển hướng đến trang user-key.jsp
            RequestDispatcher rd = request.getRequestDispatcher("views/web/user-hasKey.jsp");
            rd.forward(request, response);
//            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You already have a public key.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
