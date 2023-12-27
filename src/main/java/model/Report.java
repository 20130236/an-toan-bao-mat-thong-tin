package model;

import service.OrderService;
import service.ReportService;

import java.io.IOException;
import java.sql.Date;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Locale;

public class Report {
    public int report_id;
    public String user_name;
    public String phoneNum;
    public String email;
    public LocalDateTime date_report;
    public String detail;
    public int status;

    public Report(String user_name, String phoneNum, String email, LocalDateTime date_report, String detail, int status) {

        this.user_name = user_name;
        this.phoneNum = phoneNum;
        this.email = email;
        this.date_report  = date_report;
        this.detail = detail;
        this.status = status;
    }

    public Report() {

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

    public String toString() {
        return "Report{" +
                "report_id=" + report_id +
                "user_name=" + user_name +
                "phoneNum=" + phoneNum +
                "email=" + email +
                ", date_report=" + date_report +
                "detail=" + detail +
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
                nameStatus = "Đã phê duyệt";
                break;
            case 2:
                nameStatus = "Không phê duyệt";
                break;
            case 3:
                nameStatus = " Đang xử lý";
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
}
