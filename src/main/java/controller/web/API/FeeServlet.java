package controller.web.API;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import service.API_LOGISTIC.GetFee;
import service.API_LOGISTIC.Login_API;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(name = "FeeServlet", urlPatterns = "/FeeServlet")
public class FeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String provinceId = request.getParameter("province");
        String districtId = request.getParameter("district");
        String wardId = request.getParameter("ward");
        // Xử lý dữ liệu ở đây
//        int pId = Integer.parseInt(provinceId);
//        int dId = Integer.parseInt(districtId);
//        int wId = Integer.parseInt(wardId);
        Login_API login_api = new Login_API();
        String API_KEY = login_api.login();
        //
        String ProvinceID = "202";
        String DistrictID = "3695";
        String WardCode = "90737";
        String height = "100";
        String length = "100";
        String width = "100";
        String weight = "100";

     //   calculateShippingFee(String token, String from_district_id, String from_ward_id, String to_district_id, String to_ward_id)
        double shippingFee = GetFee.calculateShippingFee(API_KEY, DistrictID, WardCode, districtId, wardId);

        // Trả về phí chuyển hàng dưới dạng chuỗi
        String shippingFeeStr = String.valueOf(shippingFee);
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(shippingFeeStr);
    }


}
