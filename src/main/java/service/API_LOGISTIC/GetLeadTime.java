package service.API_LOGISTIC;


import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;

public class GetLeadTime {
    public static String getLeadTime(String token, String from_district_id, String from_ward_id, String to_district_id, String to_ward_id) throws IOException {
        String urlAPI = "http://140.238.54.136/api/leadTime";
        String height = "100";
        String length = "100";
        String width = "100";
        String weight = "100";
        // Tạo yêu cầu tính phí vận chuyển đến API
        CloseableHttpClient client = HttpClientBuilder.create().build();
        HttpPost post = new HttpPost("http://140.238.54.136/api/leadTime");
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
        JSONObject jsons = new JSONObject(val);
        JSONArray data = jsons.getJSONArray("data");
        JSONObject dataObject = data.getJSONObject(0);
        String formattedDate = dataObject.getString("formattedDate");
        return formattedDate;
    }

//    public static String getFormattedDateFromJson(String jsonString) throws JSONException {
//        JSONObject json = new JSONObject(jsonString);
//        JSONArray data = json.getJSONArray("data");
//        JSONObject dataObject = data.getJSONObject(0);
//        String formattedDate = dataObject.getString("formattedDate");
//        return formattedDate;
//    }


    public static void main(String[] args) throws IOException, JSONException, ParseException {
        String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTQwLjIzOC41NC4xMzYvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODIyMTg0MzEsImV4cCI6MTY4MjIxOTAzMSwibmJmIjoxNjgyMjE4NDMxLCJqdGkiOiJJcEZWS2lZMFd4RjRkdEY5Iiwic3ViIjoiODNjNGM1MWQ2N2Q1NGM0ODg4NWE4M2JjOGViYTJkZGMiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.ebGFaONmxIxrI_VsCjTEv0tBRD21wBMcDtPHK4rOejo";
        try {
            String from_district_id = "2264";
            String from_ward_id = "90816";
            String to_district_id = "2270";
            String to_ward_id = "231013";

            String leadTime = getLeadTime(token, from_district_id, from_ward_id, to_district_id, to_ward_id);
            System.out.println("Lead Time: " + leadTime);
        } catch (IOException e) {
            System.err.println("Error calculating lead time: " + e.getMessage());
        }

    }


}
