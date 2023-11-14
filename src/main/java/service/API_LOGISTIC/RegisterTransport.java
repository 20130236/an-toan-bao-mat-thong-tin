package service.API_LOGISTIC;

import model.Order;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

public class RegisterTransport {
    public static Transport registerTransport(String token, Order order,String from_district_id, String from_ward_id, String to_district_id, String to_ward_id) throws IOException {
        String height = "100";
        String length = "100";
        String width = "100";
        String weight = "100";
        // Tạo yêu cầu tính phí vận chuyển đến API
        CloseableHttpClient client = HttpClientBuilder.create().build();
        HttpPost post = new HttpPost("http://140.238.54.136/api/registerTransport");
        post.setHeader("Content-type", "application/json");
        post.setHeader("Authorization", "Bearer " + token);
        JSONObject json = new JSONObject();
        json.put("from_district_id", from_district_id);
        json.put("from_ward_id", from_ward_id);
        json.put("to_district_id", to_district_id);
        json.put("to_ward_id", to_ward_id);
        json.put("height", height);
        json.put("length", length);
        json.put("width", width);
        json.put("weight", weight);
        StringEntity entity = new StringEntity(json.toString());
        post.setEntity(entity);

        // Gửi yêu cầu và nhận phản hồi từ API
        HttpResponse apiResponse = client.execute(post);
        HttpEntity apiResponseEntity = apiResponse.getEntity();
        String apiResponseString = EntityUtils.toString(apiResponseEntity);
        // Trích xuất giá trị phí vận chuyển từ phản hồi API
        String val = apiResponseString;
        // Chuyển chuỗi JSON thành đối tượng JSONObject
        JSONObject jsonObject = new JSONObject(val);

        // Lấy ra giá trị của thuộc tính "id"
        String id = jsonObject.getJSONObject("Transport").getString("id");


        // Lấy ra giá trị của thuộc tính "created_at"
        String createdAt = jsonObject.getJSONObject("Transport").getString("created_at");

        // Lấy ra giá trị của thuộc tính "leadTime"
        long leadTime = jsonObject.getJSONObject("Transport").getLong("leadTime");
        Transport transport = new Transport(id, order,convertCreatedAt(createdAt), convertLeadTime(leadTime));
        return transport;

    }
    // Hàm chuyển đổi "leadTime" sang dd/mm/yyyy
    public static String convertLeadTime(long leadTime) {
        Date date = new Date(leadTime * 1000L); // chuyển giây thành mili giây
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        dateFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // set timezone
        return dateFormat.format(date);
    }

    // Hàm chuyển đổi "created_at" sang dd/mm/yyyy
    public static String convertCreatedAt(String createdAt) {
        SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'");
        inputDateFormat.setTimeZone(TimeZone.getTimeZone("UTC")); // set timezone
        try {
            Date date = inputDateFormat.parse(createdAt);
            SimpleDateFormat outputDateFormat = new SimpleDateFormat("dd/MM/yyyy");
            return outputDateFormat.format(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }



    public static void main(String[] args) throws IOException, JSONException, ParseException {
        String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTQwLjIzOC41NC4xMzYvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODIyMjk4MTYsImV4cCI6MTY4MjIzMDQxNiwibmJmIjoxNjgyMjI5ODE2LCJqdGkiOiJuZEtUU3pRZ1JacUtNa0R1Iiwic3ViIjoiODNjNGM1MWQ2N2Q1NGM0ODg4NWE4M2JjOGViYTJkZGMiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.4Szj5kC8JjsHAEh4GPiEJtTC7cEWwrssofLb51fWiDE";
        try {
            String from_district_id = "2264";
            String from_ward_id = "90816";
            String to_district_id = "2270";
            String to_ward_id = "231013";
            Order order = new Order();
            Transport transport = registerTransport(token,order, from_district_id, from_ward_id, to_district_id, to_ward_id);
            System.out.println("Transport: " + transport.toString());
        } catch (IOException e) {
            System.err.println("Error calculating transport: " + e.getMessage());
        }

    }
}
