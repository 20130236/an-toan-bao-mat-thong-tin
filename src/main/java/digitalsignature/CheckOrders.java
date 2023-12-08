package digitalsignature;

import dao.DBConnection;
import model.Order;
import model.Order_detail;
import service.OrderService;
import service.UserService;

import java.io.FileOutputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.sql.Timestamp;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class CheckOrders {
    static Order order = null;

    //Hash nội dung
    public static String check(String data) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            byte[] output = md.digest(data.getBytes());
            BigInteger num = new BigInteger(1, output);
            return num.toString(16);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException();
        }
    }

    //Lấy danh sách order theo id người dùng
    public static Order getOderById(int id) {


        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "SELECT order_id,  user_name,  total_money,  fee,  date_order,  payment,  transport,  status,  address,  note, phoneNum FROM `orders` WHERE order_id = " + id;
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("date_order");

                // Chuyển đổi Timestamp thành LocalDateTime
                LocalDateTime dateOrder = null;
                if (timestamp != null) {
                    dateOrder = timestamp.toLocalDateTime();
                }
                order = new Order(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), dateOrder, rs.getString(6), rs.getString(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11));

            }

        } catch (ClassNotFoundException | SQLException e) {
            return null;

        }
        return order;
    }

    //lấy chi tiết đơn hàng theo id
    public static List<Order_detail> getOrderDById(int id) {
        List<Order_detail> od = new ArrayList<>();
        ResultSet rs;
        PreparedStatement ps;
        String sql = "SELECT id_product, price, amount, fee, total FROM order_detail WHERE id_oder = " + id;
        try {
            ps = DBConnection.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order_detail orderDetail = new Order_detail(0, new Order(order.oder_id, order.user_name, order.total_money, order.fee, order.getDate_order(), order.payment, order.transport, 0, order.address, order.note, order.phoneNum), rs.getInt(1), rs.getLong(2), rs.getInt(3), rs.getInt(4), rs.getLong(5));
                od.add(orderDetail);
            }
        } catch (Exception e) {
            return null;
        }
        return od;
    }

    //chuyển thành chuỗi string, ép status mặc điịnh =0
    public static String getListOrder(int id) {
        StringBuilder stringBuilder = new StringBuilder();
        try {
            Order order = getOderById(id);
            order.setStatus(0);
            List<Order_detail> order_details = getOrderDById(id);
            stringBuilder.append(order.toString());
            for (Order_detail order_detail : order_details) {
                stringBuilder.append(order_detail.toString());
            }
        } catch (Exception e) {
            return null;
        }

        return stringBuilder.toString();
    }

    //Ký đơn hàng
    public String signDocument2(PrivateKey priKey, String document) {
        try {

            // Ký số (Sign)
            Signature signer = Signature.getInstance("DSA");
            signer.initSign(priKey, new SecureRandom());

            // Chuyển chuỗi thành byte array
            byte[] documentBytes = document.getBytes();

            // Chèn dữ liệu vào đối tượng signer
            signer.update(documentBytes);
            byte[] signature = signer.sign();

          //  System.out.println("Sign document successfully");

            // Mã hóa signature thành chuỗi Base64
            String encodedSignature = Base64.getEncoder().encodeToString(signature);

            return encodedSignature;
        } catch (Exception e) {
            return null;
        }

    }
    //Kiểm tra chữ ký
    public static boolean verifySignature(PublicKey pubKey, String document, String encodedSignature) {
        try {
            // Tạo đối tượng kiểm tra chữ ký
            Signature verifier = Signature.getInstance("DSA");
            verifier.initVerify(pubKey);

            // Chuyển chuỗi thành byte array
            byte[] documentBytes = document.getBytes();

            // Chuyển chuỗi Base64 thành mảng byte
            byte[] signature = Base64.getDecoder().decode(encodedSignature);

            // Chèn dữ liệu vào đối tượng verifier
            verifier.update(documentBytes);

            // Kiểm tra chữ ký
            return verifier.verify(signature);
        } catch (Exception e) {
            return false;
        }


    }
    //get danh sách public key
    public static List<PublicKey> getPublicKeysFromDatabase(int uid) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        List<PublicKey> publicKeys = new ArrayList<>();

        try {
            connection = DBConnection.getConnection();

            // SQL query to retrieve the public keys from the userkeys table
            String sql = "SELECT public_key FROM `key` WHERE user_id = ? ";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, uid);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                // Retrieve the public key as a byte array from the database
                byte[] publicKeyBytes = resultSet.getBytes("public_key");

                // Convert the byte array to a PublicKey object
                X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);
                java.security.KeyFactory keyFactory = java.security.KeyFactory.getInstance("DSA");
                PublicKey publicKey = keyFactory.generatePublic(keySpec);

                // Add the public key to the list
                publicKeys.add(publicKey);
            }
        } catch (Exception e) {
            return null;
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

        return publicKeys; // Return the list of public keys
    }

    // Phương thức kiểm tra chữ ký với danh sách public keys
    public static boolean printSignatureValidationResult(ArrayList<PublicKey> publicKeys, String document, String encodedSignature) {
        boolean isAnySignatureValid = false;

        for (PublicKey publicKey : publicKeys) {
            if (verifySignature(publicKey, document, encodedSignature)) {
                isAnySignatureValid = true;
                break; // Nếu có ít nhất một chữ ký hợp lệ, thoát khỏi vòng lặp
            }
        }
        return isAnySignatureValid;
    }

    //dựa vào id đơn hàng kiểm tra xem đơn hàng có hợp lệ hay không
    public static boolean checkOrderIsNotChange(int id) {
        try {
            OrderService orderService = new OrderService();
            String data = orderService.getSignatureText(id);
            Order order = getOderById(id);
            int uid = UserService.getIdByUserName(order.getUser_name());
            String getListOrder = getListOrder(id);
            String hash = check(getListOrder);

            ArrayList<PublicKey> publicKeys = (ArrayList<PublicKey>) getPublicKeysFromDatabase(uid);


            return printSignatureValidationResult(publicKeys, hash, data);
        } catch (Exception e) {
            return false;
        }

    }


    public static void main(String[] args) {
        CheckOrders checkOrders = new CheckOrders();

        long startTime1 = System.currentTimeMillis();
        boolean result1 = checkOrders.checkOrderIsNotChange(31);
        long endTime1 = System.currentTimeMillis();

        System.out.println("Result 1: " + result1);
        System.out.println("Time taken by verifyAndPrintSignature: " + (endTime1 - startTime1) + " milliseconds");


    }
}

