package controller.web;

import model.Post_Category;
import model.Introduce;
import model.Product_type;
import model.UserModel;
import service.PostService;
import service.IntroService;
import service.ProductService;
import service.UserService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {

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
        String login = request.getParameter("login")==null?"":request.getParameter("login");
        if(login.equals("google")){
            String userName = request.getParameter("username");
            String passWord = request.getParameter("password");
            String email = request.getParameter("email");
            String full_name = request.getParameter("full_name");
            if(UserService.checkLogin(userName,passWord) == null){
                UserService.register(userName,passWord,email,full_name,"null");
            }
            UserModel user = UserService.findByUserAndEmail(userName,email);
            user.setPassWord(passWord);
            request.getSession().setAttribute("user",user);
            response.sendRedirect("account");
            return;
        }
        RequestDispatcher rd = request.getRequestDispatcher("views/web/user-login.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login = request.getParameter("login")==null?"":request.getParameter("login");
        if(login.equals("google")){
            String userName = request.getParameter("username");
            String passWord = request.getParameter("password");
            String email = request.getParameter("email");
            String full_name = request.getParameter("full_name");
            if(UserService.checkLogin(userName,passWord) == null){
                UserService.register(userName,passWord,email,full_name,"null");
            }
            UserModel user = new UserModel();
            user.setUserName(userName);
            user.setPassWord(passWord);
            request.getSession().setAttribute("user", user);
            response.sendRedirect("account");
            return;
        }
        String userName = request.getParameter("username");
        String passWord = request.getParameter("password");
        UserModel user = UserService.checkLogin(userName, passWord);
            if (user != null) {
                if(user.getEnable() == 0 ) {
                    request.setAttribute("error", "Tài khoản của bạn chưa được xác thực");
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
                    request.getRequestDispatcher("views/web/user-login.jsp").forward(request, response);
                    return;
                }
                if(user.getEnable() == 2 ) {
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
                    request.setAttribute("error", "Tài khoản của bạn đã bị khoá");
                    request.getRequestDispatcher("views/web/user-login.jsp").forward(request, response);
                    return;
                }
                user.setPassWord(passWord);
                request.getSession().setAttribute("user", user);
                response.sendRedirect("account");
            } else {

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

                user = UserService.findByUserName(userName);
                if(user.getEnable() == 2){
                    request.setAttribute("error", "Tài khoản này đã bị khoá.");
                } else {
                    UserService.updateNumLogin(userName);
                    UserService.lockUser(userName);
                    request.setAttribute("error", "Thông tin đăng nhập không hợp lệ.");
                }
                request.getRequestDispatcher("views/web/user-login.jsp").forward(request, response);
        }
    }
}
