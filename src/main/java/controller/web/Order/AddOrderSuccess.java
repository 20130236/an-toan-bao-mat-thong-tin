package controller.web.Order;

import beans.Cart;
import digitalsignature.RSA;
import digitalsignature.USERKEY.DSA;
import model.UserModel;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import service.API_LOGISTIC.Login_API;
import service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "AddOrderSuccess", value = "/add_order_success")
@MultipartConfig
public class AddOrderSuccess extends HttpServlet {

    RSA rsa = new RSA();
    DSA dsa = new DSA();
    private ServletFileUpload uploader = null;

    public void init() throws ServletException {
        DiskFileItemFactory fileFactory = new DiskFileItemFactory();
        File filesDir = (File) getServletContext().getAttribute("javax.servlet.context.tempdir");
        fileFactory.setRepository(filesDir);
        this.uploader = new ServletFileUpload(fileFactory);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
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

        //
        String provinceValue = request.getParameter("province-value");
        String districtValue = request.getParameter("district-value");
        String wardValue = request.getParameter("ward-value");


        //API LOGISTIC
        Login_API login_api = new Login_API();
        String API_KEY = login_api.login();
        session.setAttribute("parameterName", API_KEY);
//
////        String publicKey = UserService.getPublicKey(user.getId());
//        String hashText = request.getParameter("hashText");


        // Lấy tệp tin từ request
        Part filePart = request.getPart("privateKeyFile");

        // Lấy tên tệp tin (nếu bạn muốn lấy)
        String fileName = dsa.getFileName(filePart);
        System.out.println(fileName);
        // Đọc nội dung của tệp tin và chuyển đổi thành đối tượng PrivateKey
        PrivateKey privateKey = dsa.readPrivateKey(filePart);
        // In thông tin về private key
//        System.out.println("Private Key Algorithm: " + privateKey.getAlgorithm());

        // Có thể thực hiện các xử lý khác tại đây
        PublicKey publicKey = dsa.getPublicKeyFromDatabase(user.getId());
        if (publicKey == null) {
            // Nếu không tìm thấy khóa công khai của người dùng, trả về thông báo
            response.getWriter().println("Không tìm thấy khóa công khai của người dùng");
            return;
        }

        // Kiểm tra xem private key và public key có khớp nhau không
        boolean keysMatch = false;
        try {
            keysMatch = dsa.verifyKeyPair(privateKey, publicKey);
        } catch (Exception e) {
            // Nếu có lỗi trong quá trình kiểm tra, trả về thông báo lỗi
            response.getWriter().println("Đã xảy ra lỗi trong quá trình kiểm tra khóa");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

//        System.out.println("Keys match: " + keysMatch);

        // Trả về kết quả trực tiếp cho trình duyệt
        response.getWriter().println("Keys match: " + keysMatch);


        try {
            List<FileItem> fileItemsList = uploader.parseRequest(request);
            for (FileItem fileItem : fileItemsList) {
                String fieldName = fileItem.getFieldName();
                System.out.println(fieldName);
                if( fieldName.equals("phone")){
                    phone = fileItem.getString("UTF-8");
                } else if(fieldName.equals("paymentMethod")){
                    paymentMethod = fileItem.getString("UTF-8");
                } else if(fieldName.equals("address")){
                    address = fileItem.getString("UTF-8");
                } else if(fieldName.equals("message")){
                    message = fileItem.getString("UTF-8");
                } else if(fieldName.equals("province-id")){
                    provinceId = fileItem.getString();
                } else if(fieldName.equals("district-id")){
                    districtId = fileItem.getString();
                } else if(fieldName.equals("ward-id")){
                    wardId = fileItem.getString();
                } else if(fieldName.equals("province-value")){
                    provinceValue = fileItem.getString();
                } else if(fieldName.equals("district-value")){
                    districtValue = fileItem.getString();
                } else if(fieldName.equals("ward-value")){
                    wardValue = fileItem.getString();
                }
//                else if(fieldName.equals("hashText")){
//                    hashText = fileItem.getString();
//                } else if(fieldName.equals("privateKeyFile")){
//                    privateKey = getPrivateKeyFromFile(fileItem);
//                }

            }
        } catch (FileUploadException e) {
            throw new RuntimeException(e);
        }

//
//        String valAdd = wardValue + ", " + districtValue + ", " + provinceValue;
//        String valId = provinceId + ":" + districtId + ":" + wardId;

        String encryptText = null;
//        try {
//            rsa.loadPrivateKey(privateKey);
//            encryptText = rsa.encrypt(hashText);
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }

//        String relativePath = UserService.getSignature(user.getId());
//        ServletContext servletContext = getServletContext();
//        // Get the real path of the font file within the web application
//        String realPath = servletContext.getRealPath(relativePath);
//        // Save the image to a file
//

        //fix trên trước :v


//        File file = new File(realPath);
//        if(file.isFile()){
//            System.out.println(file.getAbsolutePath());
//        }
//
//        try {
//            if(!checkSignature(encryptText,file,publicKey)){
//                PostService service = new PostService();
//                ProductService productService = new ProductService();
//                List<Post_Category> list = service.getListPostCategory();
//                request.setAttribute("listAr", list);
//                //Lay ra danh sach loai sp de chen vao header
//                List<Product_type> listType = productService.getAllProduct_type();
//                request.setAttribute("listType", listType);
//                //Lay ra thong tin de chen vao footer
//                IntroService intr = new IntroService();
//                Introduce intro = intr.getIntro();
//                request.setAttribute("info", intro);
//
//                if (Objects.isNull(user)) {
//                    response.sendRedirect("/login");
//                } else if (Objects.isNull(cart)) {
//                    response.sendRedirect("/home");
//
//                } else if (!Objects.isNull(user)) {
//                    UserModel userModel = UserService.findById(user.getId());
//                    request.setAttribute("user", userModel);
//                    request.setAttribute("message","Chữ ký sai!");
//                    List<Province> provinces = Province_API.convert(API_KEY);
//                    request.setAttribute("listProvinces", provinces);
//
//                    RequestDispatcher rd = request.getRequestDispatcher("/views/web/product-checkout.jsp");
//                    rd.forward(request, response);
//                }
//                return;
//            }
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//
//        try {
//            Order order = new Order(orderid, user.getUserName(), totalAmount, fee, orderDate, paymentMethod, valId, 0, valAdd, message, phone);
//            orderService.addOder(order);
//
//            order.setOder_id(orderid);
//
//            for (ProductInCart product : cart.getListProductInCart()) {
//                Order_detail orderDetail = new Order_detail(0, order, product.getProduct().getProduct_id(), product.getProduct().getPrice_sell(), product.getQuantity(), 0, (product.getProduct().getPrice_sell() * product.getQuantity()));
//                orderService.addOrderDetail(orderDetail);
//            }
//
//            session.removeAttribute("cart");
//            cart = null;
//        } catch (Exception e) {
//            response.sendRedirect(request.getContextPath() + "/home");
//            return;
//        }
        if (keysMatch) {
            // Nếu khớp nhau, chuyển hướng đến trang success
            response.sendRedirect(request.getContextPath() + "/lab/success");
        }
        else {
            // Nếu không khớp, in ra thông báo lỗi và forward lại trang hiện tại
            System.out.println("Keys do not match. Forwarding to the current page.");
            request.setAttribute("error", "Private key and public key do not match.");
            // Set the error message in the session to access it in the JavaScript
            session.setAttribute("errorMessage", "Private key and public key do not match.");

            response.sendRedirect(request.getContextPath() + "/lab/checkout");
        }
    }

    public boolean checkSignature(String encryptText, File signature, String publicKey) throws Exception {
        String hashSignature = getHashFromFile(signature);
        rsa.loadPublicKey(publicKey);
        String decryptText = rsa.decrypt(encryptText);
        return decryptText.equals(hashSignature);
    }


    public String getHashFromFile(File file) throws Exception {
        MessageDigest messageDigest = MessageDigest.getInstance("MD5");
        if (file.isFile()) {
            DigestInputStream dis = new DigestInputStream(new BufferedInputStream(new FileInputStream(file)), messageDigest);
            byte[] read = new byte[1024];
            int i;
            do {
                i = dis.read(read);
            } while (i != -1);
            BigInteger num = new BigInteger(1, dis.getMessageDigest().digest());
            return num.toString(16);
        } else {
            System.out.println("wrong path");
        }
        return null;
    }

    //    private String getPrivateKeyFromFile(FileItem fileItem){
//        String privateKey = null;
//        try {
//                        //InputStream fileInputStream = fileItem.getInputStream();
//                        //BufferedReader reader = new BufferedReader(new InputStreamReader(fileInputStream));
//                        byte[] fileContent = fileItem.get();
//                        privateKey = new String(fileContent, StandardCharsets.UTF_8);
//                        privateKey = privateKey.replaceAll("\\n", "")
//                                .replaceAll("\\r", "")
//                                .replaceAll("\\s", "");
//                        System.out.println("privateKey" + privateKey);
//                    } catch (Exception ex) {
//                throw new RuntimeException(ex);
//        }
//        return privateKey;
//    }
//
//    private String getFileExtension(String fileName) {
//        int dotIndex = fileName.lastIndexOf('.');
//        if (dotIndex > 0 && dotIndex < fileName.length() - 1) {
//            return fileName.substring(dotIndex + 1).toLowerCase();
//        }
//        return "";
//    }
    public static String getCurrentTimestamp() {
        LocalDateTime currentDateTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return currentDateTime.format(formatter);
    }
}
