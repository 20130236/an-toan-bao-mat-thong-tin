package digitalsignature.USERKEY;

import com.google.gson.Gson;
import dao.DBConnection;
import model.UserModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;

@WebServlet("/keyVerificationServlet")
@MultipartConfig
public class KeyVerificationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, UnsupportedEncodingException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null) {
            // Nếu không có người dùng, trả về trạng thái không được ủy quyền
            response.getWriter().println("Unauthorized access");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // Lấy tệp tin từ request
        Part filePart = request.getPart("privateKeyFile");

        // Lấy tên tệp tin (nếu bạn muốn lấy)
        String fileName = getFileName(filePart);
        // Đọc nội dung của tệp tin và chuyển đổi thành đối tượng PrivateKey
        PrivateKey privateKey = readPrivateKey(filePart);
        // In thông tin về private key
        System.out.println("Private Key Algorithm: " + privateKey.getAlgorithm());

        // Có thể thực hiện các xử lý khác tại đây
        PublicKey publicKey = getPublicKeyFromDatabase(user.getId());
        if (publicKey == null) {
            // Nếu không tìm thấy khóa công khai của người dùng, trả về thông báo
            response.getWriter().println("Không tìm thấy khóa công khai của người dùng");
            return;
        }

        // Kiểm tra xem private key và public key có khớp nhau không
        boolean keysMatch = false;
        try {
            keysMatch = verifyKeyPair(privateKey, publicKey);
        } catch (Exception e) {
            // Nếu có lỗi trong quá trình kiểm tra, trả về thông báo lỗi
            response.getWriter().println("Đã xảy ra lỗi trong quá trình kiểm tra khóa");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        System.out.println("Keys match: " + keysMatch);

        // Trả về kết quả trực tiếp cho trình duyệt
        response.getWriter().println("Keys match: " + keysMatch);
    }



    private PublicKey getPublicKeyFromDatabase(int uid) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = DBConnection.getConnection();

            // SQL query to retrieve the public key from the userkeys table
            String sql = "SELECT public_key FROM `key` WHERE user_id = ? AND status = 1";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, uid);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Retrieve the public key as a byte array from the database
                byte[] publicKeyBytes = resultSet.getBytes("public_key");

                // Convert the byte array to a PublicKey object
                X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);
                java.security.KeyFactory keyFactory = java.security.KeyFactory.getInstance("DSA");
                return keyFactory.generatePublic(keySpec);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources in the reverse order of their creation to avoid resource leaks
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return null; // Return null if the public key is not found or an error occurs
    }

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    //đọc private key từ file
    private PrivateKey readPrivateKey(Part filePart) throws IOException, ServletException {
        try (InputStream fileContent = filePart.getInputStream()) {
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();
            int nRead;
            byte[] data = new byte[16384];

            while ((nRead = fileContent.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }

            buffer.flush();
            byte[] privateKeyBytes = buffer.toByteArray();

            KeyFactory keyFactory = KeyFactory.getInstance("DSA");
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
            return keyFactory.generatePrivate(keySpec);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new ServletException("Error processing private key", e);
        }
    }

    //kiểm tra chữ ký
    private static boolean verifyKeyPair(PrivateKey privateKey, PublicKey publicKey) throws Exception {
        // Dữ liệu cần ký
        byte[] data = "Hello, World!".getBytes();

        // Tạo chữ ký bằng private key
        byte[] signature = signData(data, privateKey);

        // Xác minh chữ ký bằng public key
        boolean verified = verifySignature(data, signature, publicKey);

        return verified;
    }

    private static byte[] signData(byte[] data, PrivateKey privateKey) throws Exception {
        Signature signature = Signature.getInstance("DSA");
        signature.initSign(privateKey);
        signature.update(data);
        return signature.sign();
    }

    private static boolean verifySignature(byte[] data, byte[] signature, PublicKey publicKey) throws Exception {
        Signature verifier = Signature.getInstance("DSA");
        verifier.initVerify(publicKey);
        verifier.update(data);
        return verifier.verify(signature);
    }

}
