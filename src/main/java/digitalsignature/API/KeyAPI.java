package digitalsignature.API;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.stream.JsonReader;
import digitalsignature.RSA;
import model.UserModel;
import org.json.JSONObject;
import service.UserService;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.security.NoSuchAlgorithmException;

@WebServlet("/api/user/key")
public class KeyAPI extends HttpServlet {
    private RSA rsa = new RSA();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//            BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
//            String jsonString = reader.readLine();
//            JSONObject obj = new JSONObject(jsonString);
//            String pageName = obj.getString("keySize");
//
//            // Extract the value of the 'keySize' parameter
//            Integer keySize = obj.getInt("keySize");
//            UserModel userModel = (UserModel) request.getSession().getAttribute("user");
//            try {
//                rsa.setKeySize(keySize);
//                rsa.createKey();
//            } catch (NoSuchAlgorithmException e) {
//                throw new RuntimeException(e);
//            }
//            String privateKey =  rsa.getPrivateKey();
//            String publicKey  = rsa.getPublicKey();
//            KeyModel keyModel = new KeyModel();
//            keyModel.setPublicKey(publicKey);
//            keyModel.setPrivateKey(privateKey);
//            UserService.createKey(keyModel,userModel.getId());
//
//            String filePath = createFilePrivateKey(userModel.getUserName(),privateKey);
//            System.out.println(filePath);
            JSONObject json = new JSONObject();
//            json.put("path", filePath);
            // Set response content type
            response.setContentType("application/json");
            // Send the JSON response
            response.getWriter().write(json.toString());
    }

    private String createFilePrivateKey(String username, String privateKey){
        String currentTime = String.valueOf(System.currentTimeMillis());
        String fileName = currentTime + "-" + username + ".txt";
        ServletContext servletContext = getServletContext();
        String relativePath = "/privateKey/" + fileName;
        String realPath = servletContext.getRealPath(relativePath);
        File outputFile = new File(realPath);
        try {
            outputFile.createNewFile();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {
            writer.write(privateKey);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return relativePath;
    }
}
