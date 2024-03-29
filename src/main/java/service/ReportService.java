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
        String sql = "INSERT INTO reports (user_id, user_name, phoneNum, email, date_report, detail, date_key, status) VALUES (?,?,?,?,?,?,?,0)";
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
            ps.setTimestamp(7, Timestamp.valueOf(r.getDate_key()));

            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Report> getReportsByUserId(int user_id) {
        List<Report> reports = new ArrayList<>();
        PreparedStatement pst;
        String sql;
        try {
            sql = "SELECT report_id, date_report, detail, date_key, status FROM `reports` WHERE user_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, user_id);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
//                Timestamp timestamp = rs.getTimestamp("date_report");
//                Timestamp timestamp1 = rs.getTimestamp("date_key");
//
//                // Chuyển đổi Timestamp thành LocalDateTime
//                LocalDateTime dateReport = null;
//                LocalDateTime dateKey = null;
//                if (timestamp != null & timestamp1 != null) {
//                    dateReport = timestamp.toLocalDateTime();
//                    dateKey = timestamp1.toLocalDateTime();
//                }

                // Tạo đối tượng Report và thêm vào danh sách
                int report_id = rs.getInt("report_id");
                LocalDateTime date_report = rs.getTimestamp("date_report").toLocalDateTime();
                String detail = rs.getString("detail");
                LocalDateTime date_key = rs.getTimestamp("date_key").toLocalDateTime();
                int status = rs.getInt("status");

                Report report = new Report(report_id, date_report, detail, date_key, status);
                reports.add(report);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return reports;
    }

    public List<Report> getAllReport() {
        List<Report> re = new ArrayList<>();
        ResultSet rs;
        PreparedStatement ps;
        String sql = "SELECT  user_id,  user_name,  email,  report_id,  date_report,  detail, date_key,  status FROM `reports`";
        try {
            ps = DBConnection.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("date_report");
                Timestamp timestamp1 = rs.getTimestamp("date_key");

                // Chuyển đổi Timestamp thành LocalDateTime
                LocalDateTime dateReport = null;
                LocalDateTime dateKey = null;
                if (timestamp != null) {
                    dateReport = timestamp.toLocalDateTime();
                }
                if (timestamp1 != null) {
                    dateKey = timestamp1.toLocalDateTime();
                }

                Report report = new Report();
                report.setUser_id(rs.getInt("user_id"));
                report.setUser_name(rs.getString("user_name"));
                report.setEmail(rs.getString("email"));
                report.setReport_id(rs.getInt("report_id"));
                report.setDate_report(dateReport);
                report.setDetail(rs.getString("detail"));
                report.setDate_key(dateKey);
                report.setStatus(rs.getInt("status"));

                re.add(report);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return re;
    }

    public Report getReportById(int id) {
        Report reports = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "SELECT report_id, user_name, email, phoneNum, user_id, date_report, detail, date_key, status FROM `reports` WHERE report_id = " + id;
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("date_report");
                Timestamp timestamp1 = rs.getTimestamp("date_key");

                // Chuyển đổi Timestamp thành LocalDateTime
                LocalDateTime dateReport = null;
                LocalDateTime dateKey = null;
                if (timestamp != null) {
                    dateReport = timestamp.toLocalDateTime();
                }
                if (timestamp1 != null) {
                    dateKey = timestamp1.toLocalDateTime();
                }
                reports = new Report(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), dateReport, rs.getString(7), dateKey, rs.getInt(9));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return reports;
    }

    public List<Report> getAllReportNotCheck() {
        List<Report> re = new ArrayList<>();
        ResultSet rs;
        PreparedStatement ps;
        String sql = "SELECT  user_id,  user_name,  email,  report_id,  date_report,  detail, date_key,  status FROM `reports` where status = 0 ";
        try {
            ps = DBConnection.getConnection().prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("date_report");
                Timestamp timestamp1 = rs.getTimestamp("date_key");

                // Chuyển đổi Timestamp thành LocalDateTime
                LocalDateTime dateReport = null;
                LocalDateTime dateKey = null;
                if (timestamp != null) {
                    dateReport = timestamp.toLocalDateTime();
                }
                if (timestamp1 != null) {
                    dateKey = timestamp1.toLocalDateTime();
                }

                Report report = new Report();
                report.setUser_id(rs.getInt("user_id"));
                report.setUser_name(rs.getString("user_name"));
                report.setEmail(rs.getString("email"));
                report.setReport_id(rs.getInt("report_id"));
                report.setDate_report(dateReport);
                report.setDetail(rs.getString("detail"));
                report.setDate_key(dateKey);
                report.setStatus(rs.getInt("status"));

                re.add(report);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return re;
    }


    public void updateStatus(int report_id, int status) {
        String sql = "UPDATE `reports` SET status = ? WHERE report_id = ?";
        PreparedStatement pst = null;
        int rs = 0;
        try {
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, status);
            pst.setInt(2, report_id);
            rs = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
