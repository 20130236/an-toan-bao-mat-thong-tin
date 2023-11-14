package service.API_LOGISTIC;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

public class Login_API {
    public static String login() throws IOException {
        String email = "dat@20130013";
        String password = "123456";
        // Tạo yêu cầu đăng nhập đến API
        HttpClient client = HttpClientBuilder.create().build();
        HttpPost post = new HttpPost("http://140.238.54.136/api/auth/login");
        post.setHeader("Content-type", "application/json");
        JSONObject json = new JSONObject();
        json.put("email", email);
        json.put("password", password);
        StringEntity entity = new StringEntity(json.toString());
        post.setEntity(entity);

        // Gửi yêu cầu và nhận phản hồi từ API
        HttpResponse apiResponse = client.execute(post);
        HttpEntity apiResponseEntity = apiResponse.getEntity();
        String apiResponseString = EntityUtils.toString(apiResponseEntity);
        JSONObject apiResponseJson = new JSONObject(apiResponseString);

        // Lưu trữ access token trong phiên đăng nhập của người dùng
        String accessToken = apiResponseJson.getString("access_token");
        return accessToken;
    }

    public static void main(String[] args) throws IOException {

        String accessToken = Login_API.login();
        System.out.println(accessToken);
    }
}
