package service;

import dao.DBConnection;
import model.Order;
import model.Report;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReportService {

    public void addReport(Report r) {
        String sql = "INSERT INTO reports (user_name, phoneNum, email, date_report, detail, status) VALUES (?,?,?,?,?, 0)";
        PreparedStatement ps = null;
//        int rs = 0;
        try {
            ps = DBConnection.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, r.getUser_name());
            ps.setString(2, r.getPhoneNum());
            ps.setString(3, r.getEmail());
            // Chuyển đổi LocalDateTime thành Timestamp
            ps.setTimestamp(4, Timestamp.valueOf(r.getDate_report()));
            ps.setString(5, r.getDetail());
//            rs = ps.executeUpdate();
            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Report getReportById(int i) {
        return null;
    }
}
