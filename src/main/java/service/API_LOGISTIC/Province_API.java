package service.API_LOGISTIC;

import com.google.gson.*;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class Province_API {
    public static List<Province> convert(String key) {
        String responseData = null;
        String apiUrl = "http://140.238.54.136/api/province";
        String accessToken = key;

        try {
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Authorization", "Bearer " + accessToken);

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                StringBuilder response = new StringBuilder();

                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();
                responseData = String.valueOf(response);
            } else {
                System.out.println("Error: " + responseCode);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
//CONVERT
        List<Province> provinces = new ArrayList<>();

        Gson gson = new Gson();
        JsonParser jsonParser = new JsonParser();
        JsonObject jsonObject = jsonParser.parse(responseData).getAsJsonObject();

        if (jsonObject.has("original")) {
            JsonObject originalJson = jsonObject.getAsJsonObject("original");
            if (originalJson.has("data") && originalJson.get("data").isJsonArray()) {
                JsonArray jsonArray = originalJson.getAsJsonArray("data");
                for (JsonElement jsonElement : jsonArray) {
                    JsonObject provinceJson = jsonElement.getAsJsonObject();
                    int id = provinceJson.get("ProvinceID").getAsInt();
                    String name = provinceJson.get("ProvinceName").getAsString();
                    Province province = new Province(id, name);
                    provinces.add(province);
                }
            }
        }

        return provinces;


    }

    public static void main(String[] args) {
        String key = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTQwLjIzOC41NC4xMzYvYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2ODIwODY5NDEsImV4cCI6MTY4MjA4NzU0MSwibmJmIjoxNjgyMDg2OTQxLCJqdGkiOiJhcUdxTFZ3eEs5Mk4zc2daIiwic3ViIjoiODNjNGM1MWQ2N2Q1NGM0ODg4NWE4M2JjOGViYTJkZGMiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.ILAQprBaiBbOBRlYjJOkxPAr7jBnWWqHtfHrxxfH8So";
        List<Province> provinces = Province_API.convert(key);
        for (Province province : provinces) {
            System.out.println(province.getId() + ": " + province.getName());
        }

    }

}
