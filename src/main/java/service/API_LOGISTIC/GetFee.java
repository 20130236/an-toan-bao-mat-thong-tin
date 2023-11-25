package service.API_LOGISTIC;


import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;

public class GetFee {
    public static Double calculateShippingFee(String token, String from_district_id, String from_ward_id, String to_district_id, String to_ward_id) throws IOException, IOException {
//        String urlAPI = "http://140.238.54.136/api/calculateFee";
//        String height = "100";
//        String length = "100";
//        String width = "100";
//        String weight = "100";
//        // Tạo yêu cầu tính phí vận chuyển đến API
//        CloseableHttpClient client = HttpClientBuilder.create().build();
//        HttpPost post = new HttpPost("http://140.238.54.136/api/calculateFee");
//        post.setHeader("Content-type", "application/json");
//        post.setHeader("Authorization", "Bearer " + token);
//        JSONObject json = new JSONObject();
//        json.put("from_district_id", from_district_id);
//        json.put("from_ward_id", from_ward_id);
//        json.put("to_district_id", to_district_id);
//        json.put("to_ward_id", to_ward_id);
//        json.put("height", height);
//        json.put("length", length);
//        json.put("width", width);
//        json.put("weight", weight);
//        StringEntity entity = new StringEntity(json.toString());
//        post.setEntity(entity);
//
//        // Gửi yêu cầu và nhận phản hồi từ API
//        HttpResponse apiResponse = client.execute(post);
//        HttpEntity apiResponseEntity = apiResponse.getEntity();
//        String apiResponseString = EntityUtils.toString(apiResponseEntity);
//        // Trích xuất giá trị phí vận chuyển từ phản hồi API
//        String val = apiResponseString;
//        JSONObject jsons = new JSONObject(val);
//        JSONArray data = jsons.getJSONArray("data");
//        JSONObject dataObject = data.getJSONObject(0);
//        Double formatted = dataObject.getDouble("service_fee");
        // Trích xuất giá trị phí vận chuyển từ phản hồi API
        // double serviceFee = Double.parseDouble(String.valueOf(apiResponseJson.getJSONArray("data").getJSONObject(0).getDouble("service_fee")));
        return 0.0;
    }

    public static void main(String[] args) throws IOException {
//        String token = Login_API.login();
//        try {
//            String from_district_id = "2264";
//            String from_ward_id = "90816";
//            String to_district_id = "2270";
//            String to_ward_id = "231013";
//
//            Double Fee = calculateShippingFee(token, from_district_id, from_ward_id, to_district_id, to_ward_id);
//            System.out.println("Phí vận chuyển: " + Fee);
//        } catch (IOException e) {
//            System.err.println("Error calculating fee: " + e.getMessage());
//        }
        System.out.println("Phí vận chuyển:");
    }

}