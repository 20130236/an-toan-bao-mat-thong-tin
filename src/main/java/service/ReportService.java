package service;

import dao.DBConnection;
import model.Order;
import model.Report;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReportService {

    public void addReport(Report r, int user_id) {
        String sql = "INSERT INTO reports (user_id, user_name, phoneNum, email, date_report, detail, status) VALUES (?,?,?,?,?, ?, 0)";
        PreparedStatement ps = null;

        try {
            ps = DBConnection.getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, user_id);
            ps.setString(2, r.getUser_name());
            ps.setString(3, r.getPhoneNum());
            ps.setString(4, r.getEmail());
            // Chuyển đổi LocalDateTime thành Timestamp
            ps.setTimestamp(5, Timestamp.valueOf(r.getDate_report()));
            ps.setString(6, r.getDetail());

            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateReportStatusByTransportLeadTime() {
        ResultSet rs;
        PreparedStatement ps;
        String sql = "UPDATE reports SET status = ? WHERE date_report <= NOW() AND status = 0";
        try {
            ps = DBConnection.getConnection().prepareStatement(sql);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Report> getReportsByUserId(int user_id) {
        List<Report> reports = new ArrayList<>();
        PreparedStatement pst;
        String sql;
        try {
            sql = "SELECT report_id, date_report, detail, status FROM `reports` WHERE user_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, user_id);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("date_report");

                // Chuyển đổi Timestamp thành LocalDateTime
                LocalDateTime dateReport = null;
                if (timestamp != null) {
                    dateReport = timestamp.toLocalDateTime();
                }

                // Tạo đối tượng Report và thêm vào danh sách
                Report report = new Report();
                report.setReport_id(rs.getInt("report_id"));
                report.setDate_report(dateReport);
                report.setDetail(rs.getString("detail"));
                report.setStatus(rs.getInt("status"));

                reports.add(report);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return reports;
    }
}
