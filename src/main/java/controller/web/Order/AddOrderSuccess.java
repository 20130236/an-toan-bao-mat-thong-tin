package controller.web.Order;

import beans.Cart;
import digitalsignature.MD5;
import digitalsignature.RSA;
import model.*;
import service.*;
import service.API_LOGISTIC.Login_API;
import service.API_LOGISTIC.Province;
import service.API_LOGISTIC.Province_API;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "AddOrderSuccess", value = "/add_order_success")
public class AddOrderSuccess extends HttpServlet {

     RSA rsa = new RSA();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderService oderService = new OrderService();
        int orderid = oderService.getMaxMHD();
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/lab/login");
            return;
        }
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getTotal() == 0) {
            response.sendRedirect(request.getContextPath() + "/lab/home");
            return;
        }
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("paymentMethod");
        String address = request.getParameter("address");
        String message = request.getParameter("message");
        long totalAmount = cart.getTotal();
        Date orderDate = Date.valueOf(LocalDate.now());
        OrderService orderService = new OrderService();
        /*String shippingFee = request.getParameter("shippingFee");
        int fee = Integer.parseInt(shippingFee);*/
        int fee = 20000;
        //dia chi giao hang
        String provinceId = request.getParameter("province-id");
        String districtId = request.getParameter("district-id");
        String wardId = request.getParameter("ward-id");
        String valId = provinceId+":"+districtId+":"+wardId;
        //
        String provinceValue = request.getParameter("province-value");
        String districtValue = request.getParameter("district-value");
        String wardValue = request.getParameter("ward-value");
        String valAdd = wardValue +", "+ districtValue+", "+provinceValue;

        //API LOGISTIC
        Login_API login_api = new Login_API();
        String API_KEY = login_api.login();
        session.setAttribute("parameterName", API_KEY);

        String publicKey = UserService.getPublicKey(user.getId());
        String hashText = request.getParameter("hashText");
        String privateKey = request.getParameter("privateKey");

        String encryptText = null;
        try {
            rsa.loadPrivateKey(privateKey);
            encryptText = rsa.encrypt(hashText);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        String relativePath = UserService.getSignature(user.getId());
        ServletContext servletContext = getServletContext();
        // Get the real path of the font file within the web application
        String realPath = servletContext.getRealPath(relativePath);
        // Save the image to a file

        File file = new File(realPath);
        if(file.isFile()){
            System.out.println(file.getAbsolutePath());
        }

        try {
            if(!checkSignature(encryptText,file,publicKey)){

                PostService service = new PostService();
                ProductService productService = new ProductService();
                List<Post_Category> list = service.getListPostCategory();
                request.setAttribute("listAr", list);
                //Lay ra danh sach loai sp de chen vao header
                List<Product_type> listType = productService.getAllProduct_type();
                request.setAttribute("listType", listType);
                //Lay ra thong tin de chen vao footer
                IntroService intr = new IntroService();
                Introduce intro = intr.getIntro();
                request.setAttribute("info", intro);

                if (Objects.isNull(user)) {
                    response.sendRedirect("/login");
                } else if (Objects.isNull(cart)) {
                    response.sendRedirect("/home");

                } else if (!Objects.isNull(user)) {
                    UserModel userModel = UserService.findById(user.getId());
                    request.setAttribute("user", userModel);
                    request.setAttribute("message","Chữ ký sai!");
                    List<Province> provinces = Province_API.convert(API_KEY);
                    request.setAttribute("listProvinces", provinces);

                    RequestDispatcher rd = request.getRequestDispatcher("/views/web/product-checkout.jsp");
                    rd.forward(request, response);
                }
                return;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        try {
            Order order = new Order(orderid, user.getUserName(), totalAmount, fee, orderDate, paymentMethod, valId, 0, valAdd, message, phone);
            orderService.addOder(order);

            order.setOder_id(orderid);

            for (ProductInCart product : cart.getListProductInCart()) {
                Order_detail orderDetail = new Order_detail(0, order, product.getProduct().getProduct_id(), product.getProduct().getPrice_sell(), product.getQuantity(), 0, (product.getProduct().getPrice_sell() * product.getQuantity()));
                orderService.addOrderDetail(orderDetail);
            }

            session.removeAttribute("cart");
            cart = null;
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        response.sendRedirect("/lab/success");
//        RequestDispatcher rd = request.getRequestDispatcher("/views/web/order-success.jsp");
//        rd.forward(request, response);
    }

    public boolean checkSignature(String encryptText, File signature, String publicKey) throws Exception {
        String hashSignature = getHashFromFile(signature);
        rsa.loadPublicKey(publicKey);
        String decryptText = rsa.decrypt(encryptText);
        return decryptText.equals(hashSignature);
    }


    public String getHashFromFile(File file) throws Exception {
        MessageDigest messageDigest = MessageDigest.getInstance("MD5");
        if(file.isFile()) {
            DigestInputStream dis = new DigestInputStream(new BufferedInputStream(new FileInputStream(file)), messageDigest);
            byte [] read = new byte[1024];
            int i;
            do {
                i = dis.read(read);
            } while(i != -1);
            BigInteger num = new BigInteger(1,dis.getMessageDigest().digest());
            return num.toString(16);
        } else {
            System.out.println("wrong path");
        }
        return null;
    }
}
