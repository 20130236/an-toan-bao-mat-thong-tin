package digitalsignature.USERKEY;

import dao.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class DSA {
    //Tạo key và lưu public key vào database
    public KeyPair generateKeyPair() throws NoSuchAlgorithmException {
        SecureRandom sr = new SecureRandom();
        KeyPairGenerator kpg = KeyPairGenerator.getInstance("DSA");
        kpg.initialize(1024, sr);
        return kpg.generateKeyPair();
    }

    public void savePublicKeyToDatabase(PublicKey publicKey, int uid) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        PreparedStatement updateStatement = null;

        try {
            // Lấy thời gian hiện tại ở định dạng chuỗi (yyyy-MM-dd HH:mm:ss)
            String currentTimestamp = getCurrentTimestamp();

            // SQL để cập nhật trạng thái của các bản ghi trước đó thành 0
            String updateSql = "UPDATE `key` SET status = 0 WHERE user_id = ?";
            connection = DBConnection.getConnection();
            updateStatement = connection.prepareStatement(updateSql);
            updateStatement.setInt(1, uid);
            updateStatement.executeUpdate();

            // SQL để chèn dữ liệu vào bảng
            String insertSql = "INSERT INTO `key` (user_id, public_key, time_create, status) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(insertSql);

            // Thiết lập các tham số trong câu lệnh SQL
            preparedStatement.setInt(1, uid);
            preparedStatement.setBytes(2, publicKey.getEncoded());
            preparedStatement.setString(3, currentTimestamp);
            preparedStatement.setInt(4, 1); // Hoặc giá trị trạng thái mong muốn

            // Thực hiện câu lệnh INSERT
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Dữ liệu đã được chèn vào cơ sở dữ liệu thành công.");
            } else {
                System.out.println("Không có dữ liệu nào được chèn vào cơ sở dữ liệu.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng các tài nguyên
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (updateStatement != null) {
                    updateStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public PublicKey getPublicKeyFromDatabase(int uid) {
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

    public String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    //đọc private key từ file
    public PrivateKey readPrivateKey(Part filePart) throws IOException, ServletException {
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
    public static boolean verifyKeyPair(PrivateKey privateKey, PublicKey publicKey) throws Exception {
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

    public static String getCurrentTimestamp() {
        // Lấy múi giờ của Việt Nam
        ZoneId vietnamTimeZone = ZoneId.of("Asia/Ho_Chi_Minh");

        // Lấy thời điểm hiện tại trong múi giờ của Việt Nam
        LocalDateTime currentDateTime = LocalDateTime.now(vietnamTimeZone);

        // Định dạng thời gian
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        // Chuyển đổi và trả về chuỗi thời gian
        return currentDateTime.format(formatter);
    }
    public static Date convertStringToDate(String timestampString) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = dateFormat.parse(timestampString);
        return date;
    }

    public static void main(String[] args) {
        String currentTimestamp = getCurrentTimestamp();
        System.out.println(currentTimestamp);
    }
}
