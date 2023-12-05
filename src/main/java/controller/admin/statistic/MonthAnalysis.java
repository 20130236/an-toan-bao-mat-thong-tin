package controller.admin.statistic;

import com.google.gson.Gson;
import dao.DBConnection;
import model.Introduce;
import model.Order;
import model.Order_detail;
import model.Statics.ProductSellNum;
import org.json.JSONArray;
import org.json.JSONObject;
import service.IntroService;
import service.OrderService;
import service.ServiceStatistics;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "MonthAnalysis", value = "/month_analysis")
public class MonthAnalysis extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ request
        DBConnection.resetConnection();
        String selectedMonth = request.getParameter("selectedMonth");
        // Tách chuỗi thành tháng và năm
        String[] parts = selectedMonth.split("/");
        int month = Integer.parseInt(parts[0]);
        int year = Integer.parseInt(parts[1]);
        ServiceStatistics serviceStatistics = new ServiceStatistics();
        //lấy doanh thu theo tháng
        long total = serviceStatistics.getRevenueByMonthYear(month, year);
        //lấy số đơn hàng theo tháng
        int orderNum = serviceStatistics.getOrderNumByMonthYear(month, year);
        //lấy số sản phẩm đã bán theo tháng
        int productNum = serviceStatistics.getNumProductByMonthYear(month, year);
        //lấy đơn hàng theo tháng đang vận chuyển
        int orderNumShipping = serviceStatistics.getTransByMonthYear(month, year);
        //Chuyển sang kiểu String
        String totalString = String.valueOf(total);
        String orderNumString = String.valueOf(orderNum);
        String productNumString = String.valueOf(productNum);
        String orderNumShippingString = String.valueOf(orderNumShipping);
        //Lấy ra sp bán chạy
        ArrayList<ProductSellNum> productSellNums = (ArrayList<ProductSellNum>) serviceStatistics.getTopSellingProducts(month, year);
        // Tạo một đối tượng JSONArray để lưu trữ danh sách sản phẩm
        JSONArray jsonArray = new JSONArray();

        // Duyệt qua danh sách và tạo JSON object cho mỗi sản phẩm
        if(!productSellNums.isEmpty()){
            for (ProductSellNum product : productSellNums) {
                JSONObject productJson = new JSONObject();
                String productID = String.valueOf(product.getId());
                String productURL = "/view_product?pid="+productID;
                productJson.put("id", product.getId());
                productJson.put("name", product.getName());
                productJson.put("price", product.getPrice());
                productJson.put("image", product.getImage());
                productJson.put("amountSell", product.getAmountSell());
                productJson.put("url", productURL);
                // Thêm JSON object sản phẩm vào mảng
                jsonArray.put(productJson);
            }
        }else {
            JSONObject productJson = new JSONObject();
            productJson.put("id", 0);
            productJson.put("name", "Không có sản phẩm nào");
            productJson.put("price", 0);
            productJson.put("image", "https://i.imgur.com/c20RsyT.jpeg");
            productJson.put("amountSell", 0);
            productJson.put("url", "productURL");
            // Thêm JSON object sản phẩm vào mảng
            jsonArray.put(productJson);
        }
        //Lấy ra đơn hàng theo tháng
        List<Order> orders = serviceStatistics.getOrdersByMonth(month, year);
        // Tạo một đối tượng JSONArray để lưu trữ danh sách sản phẩm
        JSONArray jsonArrayOrder = new JSONArray();
        if(!orders.isEmpty()){
            for (Order order : orders) {
                JSONObject orderJson = new JSONObject();
                String date = String.valueOf(order.getDate_order());
                String convertDate = order.convertDateTime(date);
                long totalMoney = order.getTotal_money();
                int fee = order.getFee();
                String formatTotalMoney = order.formatCurrency(totalMoney + fee);
                orderJson.put("id", order.getOder_id());
                orderJson.put("name", order.getFullName(order.getUser_name()));
                orderJson.put("phone", order.getPhoneNum());
                orderJson.put("date", convertDate);
                orderJson.put("totalMoney", formatTotalMoney);
                // Thêm JSON object sản phẩm vào mảng
                jsonArrayOrder.put(orderJson);
            }
        } else {
            JSONObject orderJson = new JSONObject();
            orderJson.put("id", 0);
            orderJson.put("name", "Không có đơn hàng nào");
            orderJson.put("phone", "0");
            orderJson.put("date", "dd/MM/yyyy");
            orderJson.put("totalMoney", "0");
            // Thêm JSON object sản phẩm vào mảng
            jsonArrayOrder.put(orderJson);
        }

        //Nhập sản phẩm
        ArrayList<ProductSellNum> importProduct = (ArrayList<ProductSellNum>) serviceStatistics.getTopImportProducts(month, year);
        // Tạo một đối tượng JSONArray để lưu trữ danh sách sản phẩm
        JSONArray jsonArrayImport = new JSONArray();

        // Duyệt qua danh sách và tạo JSON object cho mỗi sản phẩm
        if(!importProduct.isEmpty()){
            for (ProductSellNum product : importProduct) {
                JSONObject productJson = new JSONObject();
                productJson.put("id", product.getId());
                productJson.put("name", product.getName());
                productJson.put("image", product.getImage());
                productJson.put("amountSell", product.getAmountSell());
                // Thêm JSON object sản phẩm vào mảng
                jsonArrayImport.put(productJson);
            }
        }else {
            JSONObject productJson = new JSONObject();
            productJson.put("id", 0);
            productJson.put("name", "Không có sản phẩm nào");
            productJson.put("image", "https://i.imgur.com/c20RsyT.jpeg");
            productJson.put("amountSell", 0);
            // Thêm JSON object sản phẩm vào mảng
            jsonArrayImport.put(productJson);
        }


        // Tạo đối tượng JSON chứa kết quả
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", totalString);
        jsonObject.put("orderNum", orderNumString);
        jsonObject.put("productNum", productNumString);
        jsonObject.put("orderNumShipping", orderNumShippingString);
        jsonObject.put("products", jsonArray);
        jsonObject.put("orders", jsonArrayOrder);
        jsonObject.put("importProduct", jsonArrayImport);

        // Gửi dữ liệu JSON về phía client
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonObject.toString());

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
