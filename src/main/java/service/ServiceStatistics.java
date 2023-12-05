package service;

import dao.DBConnection;
import model.Order;
import model.Product;
import model.Statics.ProductSellNum;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ServiceStatistics {

    public List<ProductSellNum> getTopSellingProducts(int month, int year) {
        List<ProductSellNum> productSellNums = new ArrayList<>();
        String sql = "SELECT od.id_product, SUM(od.amount) AS total_amount " +
                "FROM order_detail od " +
                "JOIN `orders` o ON od.id_oder = o.order_id " +
                "WHERE MONTH(o.date_order) = ? " +
                "AND YEAR(o.date_order) = ? " +
                "GROUP BY od.id_product " +
                "ORDER BY total_amount DESC " +
                "LIMIT 10";
        try (PreparedStatement statement = DBConnection.getConnection().prepareStatement(sql)) {
            statement.setInt(1, month);
            statement.setInt(2, year);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    int idProduct = resultSet.getInt("id_product");
                    int amountSell = resultSet.getInt("total_amount");
                    ProductSellNum productSellNum = new ProductSellNum(idProduct, amountSell);
                    productSellNums.add(productSellNum);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return productSellNums;
    }

    public long getRevenueByMonthYear(int month, int year) {
        long revenues = 0;
        String sql = "SELECT SUM(total_money) AS `Revenue` " +
                "FROM orders " +
                "WHERE MONTH(date_order) = ? AND YEAR(date_order) = ?";
        try (PreparedStatement statement = DBConnection.getConnection().prepareStatement(sql)) {
            statement.setInt(1, month);
            statement.setInt(2, year);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    revenues = resultSet.getInt("Revenue");

                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return revenues;
    }

    public int getOrderNumByMonthYear(int month, int year) {
        int revenues = 0;
        String sql = "SELECT COUNT(order_id) AS `Revenue` " +
                "FROM orders " +
                "WHERE MONTH(date_order) = ? AND YEAR(date_order) = ?";
        try (PreparedStatement statement = DBConnection.getConnection().prepareStatement(sql)) {
            statement.setInt(1, month);
            statement.setInt(2, year);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    revenues = resultSet.getInt("Revenue");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return revenues;
    }

    public int getNumProductByMonthYear(int month, int year) {
        int num = 0;
        String sql = "SELECT SUM(od.amount)  FROM order_detail od JOIN orders o ON o.order_id = od.id_oder WHERE MONTH(o.date_order) = ? AND YEAR(o.date_order) = ?";
        try (PreparedStatement statement = DBConnection.getConnection().prepareStatement(sql)) {
            statement.setInt(1, month);
            statement.setInt(2, year);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    num = resultSet.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return num;
    }

    public int getTransByMonthYear(int month, int year) {
        int trans = 0;
        String sql = "SELECT COUNT(order_id)  FROM orders o WHERE MONTH(o.date_order) = ? AND YEAR(o.date_order) = ? AND o.status = 1;";
        try (PreparedStatement statement = DBConnection.getConnection().prepareStatement(sql)) {
            statement.setInt(1, month);
            statement.setInt(2, year);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    trans = resultSet.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return trans;
    }

    public List<Order> getOrdersByMonth(int month, int year) {
        List<Order> od = new ArrayList<>();
        Order order = null;
        PreparedStatement ps;
        String sql = "SELECT  order_id,  user_name,  total_money,  fee,  date_order,  payment,  transport,  status,  address,  note, phoneNum FROM orders o WHERE MONTH(o.date_order) = ? AND YEAR(o.date_order) = ? ORDER BY date_order DESC";
        try (PreparedStatement statement = DBConnection.getConnection().prepareStatement(sql)) {
            statement.setInt(1, month);
            statement.setInt(2, year);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Timestamp timestamp = rs.getTimestamp("date_order");

                    // Chuyển đổi Timestamp thành LocalDateTime
                    LocalDateTime dateOrder = null;
                    if (timestamp != null) {
                        dateOrder = timestamp.toLocalDateTime();
                    }
                    order = new Order(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), dateOrder, rs.getString(6), rs.getString(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11));
                    od.add(order);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return od;
    }
    public List<ProductSellNum> getTopImportProducts(int month, int year) {
        List<ProductSellNum> productSellNums = new ArrayList<>();
        String sql = "SELECT product_id, SUM(quantity) FROM import_products WHERE MONTH(date) = ? AND YEAR(date) = ? GROUP BY product_id ORDER BY SUM(quantity) DESC LIMIT 10";
        try (PreparedStatement statement = DBConnection.getConnection().prepareStatement(sql)) {
            statement.setInt(1, month);
            statement.setInt(2, year);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    int idProduct = resultSet.getInt(1);
                    int amountSell = resultSet.getInt(2);
                    ProductSellNum productSellNum = new ProductSellNum(idProduct, amountSell);
                    productSellNums.add(productSellNum);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return productSellNums;
    }

    public static void main(String[] args) {
        ServiceStatistics serviceStatistics = new ServiceStatistics();
//        ArrayList<ProductSellNum> orders = (ArrayList<ProductSellNum>) serviceStatistics.getTopImportProducts(5, 2023);
//        for (ProductSellNum order : orders) {
//            System.out.println(order.getName());
//            System.out.println(order.getAmountSell());
//        }
////        String date = orders.get(0).getDate_order().toString();
//        System.out.println(date);
//        System.out.println(orders.get(0).convertDate(date));
        System.out.println(serviceStatistics.getRevenueByMonthYear(12, 2023));
        ArrayList<Order> orders = (ArrayList<Order>) serviceStatistics.getOrdersByMonth(12, 2023);
        for (Order order : orders) {
            System.out.println(order);
        }

    }

}
