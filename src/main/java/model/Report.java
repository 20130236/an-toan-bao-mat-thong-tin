package model;

import dao.DBConnection;
import service.OrderService;
import service.ReportService;

import java.io.IOException;
import java.sql.*;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Locale;

public class Report {
    public int report_id;
    public int user_id;
    public String user_name;
    public String phoneNum;
    public String email;
    public LocalDateTime date_report;
    public String detail;
    public LocalDateTime date_key;
    public int status;

    public Report(String user_name, String phoneNum, String email, LocalDateTime date_report, String detail, LocalDateTime date_key, int status) {

        this.user_name = user_name;
        this.phoneNum = phoneNum;
        this.email = email;
        this.date_report  = date_report;
        this.detail = detail;
        this.date_key = date_key;
        this.status = status;
    }

    public Report() {

    }

    public Report(int reportId, String user_name, String email, int user_id, String detail, int status) {
        this.report_id = reportId;
        this.user_name = user_name;
        this.email = email;
        this.user_id = user_id;
        this.detail = detail;
        this.status = status;
    }

    public Report(int report_id, String user_name, String email, String phoneNum, int user_id, LocalDateTime date_report, String detail, LocalDateTime date_key, int status) {
        this.report_id = report_id;
        this.user_name = user_name;
        this.email = email;
        this.phoneNum = phoneNum;
        this.user_id = user_id;
        this.date_report  = date_report;
        this.detail = detail;
        this.date_key = date_key;
        this.status = status;
    }

    public Report(int report_id, LocalDateTime date_report, String detail, LocalDateTime date_key, int status) {
        this.report_id = report_id;
        this.date_report  = date_report;
        this.detail = detail;
        this.date_key = date_key;
        this.status = status;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getReport_id() {
        return report_id;
    }

    public void setReport_id(int report_id) {
        this.report_id = report_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDateTime getDate_report() {
        return date_report;
    }

    public void setDate_report(LocalDateTime date_report) {
        this.date_report = date_report;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getDateCurrent() {
        Date current = Date.valueOf(LocalDate.now());
        return current;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public LocalDateTime getDate_key() {
        return date_key;
    }

    public void setDate_key(LocalDateTime date_key) {
        this.date_key = date_key;
    }

    public String toString() {
        return "Report{" +
                "user_id=" + user_id +
                "report_id=" + report_id +
                "user_name=" + user_name +
                "phoneNum=" + phoneNum +
                "email=" + email +
                ", date_report=" + date_report +
                "detail=" + detail +
                "date_key=" + date_key +
                ", status=" + status +
                '}';
    }

    public String statusReport(int id) {
        String nameStatus = "Lỗi";
        switch (id) {
            case 0:
                nameStatus = "Chờ phê duyệt";
                break;
            case 1:
                nameStatus = "Duyệt yêu cầu";
                break;
            case 2:
                nameStatus = "Từ chối yêu cầu";
                break;
            case 3:
                nameStatus = "Đang xử lý";
                break;
            case 4:
                nameStatus = "Đã xử lý";
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

    public static String convertDateTime1(String dateTime) {
        // Chuyển đổi chuỗi thành LocalDateTime
        LocalDateTime date = LocalDateTime.parse(dateTime, DateTimeFormatter.ISO_LOCAL_DATE_TIME);

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            return date.format(formatter);
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
        Report r = new Report();
//        ReportService reportService = new ReportService();
//        r = reportService.getReportById(30);
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
}
