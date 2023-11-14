package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
//    static Connection connect;
//    public static Connection getConnection() throws SQLException, ClassNotFoundException {
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            String url = "jdbc:mysql://" + DBProperties.getDbHost() + ":" + DBProperties.getDbPort() + "/" + DBProperties.getDbName();
//            String user = DBProperties.getUsername();
//            String password = DBProperties.getPassword();
//            return DriverManager.getConnection(url, user, password);
//        } catch (ClassNotFoundException | SQLException e) {
//            return null;
//        }
//    }
static Connection connect;

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        if (connect != null && !connect.isClosed()) {
            return connect;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://" + DBProperties.getDbHost() + ":" + DBProperties.getDbPort() + "/" + DBProperties.getDbName();
            String user = DBProperties.getUsername();
            String password = DBProperties.getPassword();
            connect = DriverManager.getConnection(url, user, password);
            return connect;
        } catch (ClassNotFoundException | SQLException e) {
            return null;
        }
    }

    public static void resetConnection() {
        if (connect != null) {
            try {
                connect.close();
            } catch (SQLException e) {
                // Xử lý ngoại lệ nếu cần
            }
            connect = null;
        }
    }

    public static void main(String[] args) {
        resetConnection();
        try {
            System.out.println(getConnection());
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}

