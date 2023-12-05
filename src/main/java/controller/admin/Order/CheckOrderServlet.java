package controller.admin.Order;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.DBConnection;
import digitalsignature.CheckOrders;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CountDownLatch;

@WebServlet("/checkOrderEndpoint")
public class CheckOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin đơn hàng từ request
            String orderId = request.getParameter("orderId");

            // Sử dụng CountDownLatch để đồng bộ hóa
            CountDownLatch latch = new CountDownLatch(1);
            boolean[] orderIsChanged = {false};

            // Thực hiện kiểm tra đơn hàng bất đồng bộ
            Thread thread = new Thread(() -> {
                try {
                    DBConnection.resetConnection();
                    // Thực hiện kiểm tra đơn hàng, ví dụ: sử dụng hàm CheckOrders.checkOrderIsChange
                    orderIsChanged[0] = CheckOrders.checkOrderIsNotChange(Integer.parseInt(orderId));
                } catch (Exception e) {
                    // Xử lý ngoại lệ và kết thúc luồng khi có lỗi
                    e.printStackTrace(); // Thay bằng xử lý thích hợp
                    return;
                } finally {
                    latch.countDown();
                }
            });
            thread.start();

            try {
                // Đợi cho quá trình kiểm tra đơn hàng kết thúc
                latch.await();
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                // Xử lý ngoại lệ InterruptedException (nếu cần)
                e.printStackTrace(); // Thay bằng xử lý thích hợp
            }

            // Chuẩn bị dữ liệu kết quả
            Map<String, Object> result = new HashMap<>();
            result.put("orderIsChanged", orderIsChanged[0]);

            // Chuyển đối tượng kết quả thành JSON
            String jsonResult = new ObjectMapper().writeValueAsString(result);

            // Thiết lập các thông số cho response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Gửi kết quả về client
            response.getWriter().write(jsonResult);

        } catch (NumberFormatException e) {
            // Xử lý ngoại lệ NumberFormatException (nếu tham số orderId không phải là số)
            e.printStackTrace(); // Thay bằng xử lý thích hợp
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid orderId parameter");
        } catch (Exception e) {
            // Xử lý các ngoại lệ khác mà bạn muốn đối mặt
            e.printStackTrace(); // Thay bằng xử lý thích hợp
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Server Error");
        }
    }
}