package service.CheckOrders;

import dao.DBConnection;
import model.Order;
import model.Order_detail;

import javax.swing.*;
import java.io.FileOutputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CheckOrder {
    Order order = null;
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
    public Order getOderById(int id) {


        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "SELECT order_id,  user_name,  total_money,  fee,  date_order,  payment,  transport,  status,  address,  note, phoneNum FROM `orders` WHERE order_id = " + id;
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                order = new Order(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getDate(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11));

            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();

        }
        return order;
    }
    public List<Order_detail> getOrderDById(int id) {
        List<Order_detail> od = new ArrayList<>();
        ResultSet rs;
        PreparedStatement ps;
        String sql = "SELECT id_product, price, amount, fee, total FROM order_detail WHERE id_oder = " + id;
        try {
            ps = DBConnection.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order_detail orderDetail = new Order_detail(0, new Order(order.oder_id, order.user_name, order.total_money, order.fee, order.getDate_order(), order.payment, order.transport, order.status, order.address, order.note, order.phoneNum), rs.getInt(1), rs.getLong(2), rs.getInt(3), rs.getInt(4), rs.getLong(5));
                od.add(orderDetail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return od;
    }
    public String getListOrder(int id){
        StringBuilder stringBuilder = new StringBuilder();
        Order order = getOderById(id);
        List<Order_detail> order_details = getOrderDById(id);
        stringBuilder.append(order.toString());
        for (Order_detail order_detail : order_details) {
            stringBuilder.append(order_detail.toString());
        }
        return stringBuilder.toString();
    }
    public void generateAndSaveKeyPair() {
        try {
            SecureRandom sr = new SecureRandom();

            KeyPairGenerator kpg = KeyPairGenerator.getInstance("DSA");
            kpg.initialize(1024, sr);
            KeyPair keys = kpg.generateKeyPair();

            // Save private key
            PrivateKey privateKey = keys.getPrivate();
            FileOutputStream fos = new FileOutputStream("/src/main/resources/priKey.bin");
            fos.write(privateKey.getEncoded());
            fos.close();

            // Save public key
            PublicKey publicKey = keys.getPublic();
            fos = new FileOutputStream("/src/main/resources/pubKey.bin");
            fos.write(publicKey.getEncoded());
            fos.close();
            System.out.println("Keys generated and saved");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void signDocument(String privateKeyPath, String document, String signaturePath) {
        try {
            // Nạp private key từ file
            byte[] keyBytes = Files.readAllBytes(Paths.get(privateKeyPath));
            PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
            KeyFactory factory = KeyFactory.getInstance("DSA");
            PrivateKey priKey = factory.generatePrivate(spec);

            // Ký số (Sign)
            Signature signer = Signature.getInstance("DSA");
            signer.initSign(priKey, new SecureRandom());

            // Chuyển chuỗi thành byte array
            byte[] documentBytes = document.getBytes();

            // Chèn dữ liệu vào đối tượng signer
            signer.update(documentBytes);
            byte[] signature = signer.sign();

            // Lưu chữ ký số vào tệp tin
            try (FileOutputStream signatureOutputStream = new FileOutputStream(signaturePath)) {
                signatureOutputStream.write(signature);
            }

            System.out.println("Sign document successfully");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static void main(String[] args) {

        CheckOrder checkOrder = new CheckOrder();
//        System.out.println(checkOrder.getListOrder(38));
//        System.out.println(check(checkOrder.getListOrder(38)));
        checkOrder.generateAndSaveKeyPair();
    }
}
