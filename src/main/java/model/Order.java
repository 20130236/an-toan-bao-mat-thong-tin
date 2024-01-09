package model;


import dao.DBConnection;
import service.OrderService;

import java.io.IOException;
import java.sql.*;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Locale;

public class Order {
    public int oder_id;
    public String user_name;
    public long total_money;
    public int fee;
    public LocalDateTime date_order;
    public String payment;
    public String transport;
    public int status;
    public String address;
    public String note;
    public String phoneNum;
    public String digitalSignature;

    public Order(int oder_id, String user_name, long total_money, int fee, LocalDateTime date_order, String payment, String transport, int status, String address, String note, String phoneNum) {
        this.oder_id = oder_id;
        this.user_name = user_name;
        this.total_money = total_money;
        this.fee = fee;
        this.date_order = date_order;
        this.payment = payment;
        this.transport = transport;
        this.status = status;
        this.address = address;
        this.note = note;
        this.phoneNum = phoneNum;
    }

    public int getOder_id() {
        return oder_id;
    }

    public void setOder_id(int oder_id) {
        this.oder_id = oder_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public long getTotal_money() {
        return total_money;
    }

    public void setTotal_money(long total_money) {
        this.total_money = total_money;
    }

    public int getFee() {
        return fee;
    }

    public void setFee(int fee) {
        this.fee = fee;
    }

    public LocalDateTime getDate_order() {
        return date_order;
    }

    public void setDate_order(LocalDateTime date_order) {
        this.date_order = date_order;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public String getTransport() {
        return transport;
    }

    public void setTransport(String transport) {
        this.transport = transport;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public Date getDateCurrent() {
        Date current = Date.valueOf(LocalDate.now());
        return current;
    }

    public String getDigitalSignature() {
        OrderService orderService = new OrderService();
        String data = orderService.getSignatureText(oder_id);
        String result = "Đơn hàng chưa được ký";
        // Kiểm tra xem chuỗi có phải là Base64 hay không
        if (isBase64(data)) {
            byte[] decodedData = Base64.getDecoder().decode(data);
            String decodedDataString = new String(decodedData);
            if(decodedDataString.isEmpty()){
                return result;
            }
            return result = "Đơn hàng đã được ký";
        } else {
            return result ;
        }
    }

    public void setDigitalSignature(String digitalSignature) {
        this.digitalSignature = digitalSignature;
    }

    public Order() {

    }

    @Override
    public String toString() {
        return "Order{" +
                "oder_id=" + oder_id +
                ", user_name='" + user_name + '\'' +
                ", total_money=" + total_money +
                ", fee=" + fee +
                ", date_order=" + date_order +
                ", payment='" + payment + '\'' +
                ", transport='" + transport + '\'' +
                ", status=" + status +
                ", address='" + address + '\'' +
                ", note='" + note + '\'' +
                '}';


    }

    public String getFullName(String userName) {
        String sql = "SELECT full_name FROM users WHERE user_name = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, userName);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getString("full_name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public String formatCurrency(double amount) {
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
        return currencyVN.format(amount);
    }

    public String statusOrder(int id) {
        String nameStatus = "Lỗi";
        switch (id) {
            case 0:
                nameStatus = "Chờ xác nhận";
                break;
            case 1:
                nameStatus = "Đang vận chuyển";
                break;
            case 2:
                nameStatus = "Đã giao";
                break;
            case 3:
                nameStatus = "Đã huỷ đơn hàng";
                break;
            case 4:
                nameStatus = "Giao hàng thất bại";
                break;
            case 5:
                nameStatus = "Đơn hàng bị huỷ";
                break;
            case 6:
                nameStatus = "Đơn hàng bị huỷ - và hoàn tiền";
                break;
            case 7:
                nameStatus = "Đơn hàng bị huỷ do lộ Private Key";
                break;
        }
        return nameStatus;
    }

    public static String convertDate(String dateString) {
        LocalDate date = LocalDate.parse(dateString);
        return date.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public static String convertDateTime(String dateTimeString) {
        // Chuyển đổi chuỗi thành LocalDateTime
        LocalDateTime dateTime = LocalDateTime.parse(dateTimeString, DateTimeFormatter.ISO_LOCAL_DATE_TIME);

        // Định dạng lại LocalDateTime theo định dạng mong muốn
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss dd/MM/yyyy");
        return dateTime.format(formatter);
    }
    // Hàm kiểm tra xem chuỗi có phải là Base64 hay không
    private static boolean isBase64(String str) {
        try {
            Base64.getDecoder().decode(str);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public static void main(String[] args) throws IOException {
        Order o = new Order();
        OrderService orderService = new OrderService();
        o = orderService.getOderById(30);
//        System.out.println(o.getUser_name());
//        System.out.println(o.toString());
//        System.out.println(o.getFullName(o.getUser_name()));
//        System.out.println(o.getDate_order());
//        System.out.println(convertDateTime("2023-12-05T21:52:28"));
        //System.out.println(o.getDigitalSignature());
    }
}