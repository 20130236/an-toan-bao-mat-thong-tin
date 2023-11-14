package dao;

import model.Log;
import model.LogStatistics;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class LogDAO {

    public static void addLog(Log log){
        PreparedStatement pst;
        String sql;
        try {
            sql = "INSERT INTO log(`level`, `user`, src, content, createAt, `status`,`ipAddress`)  VALUES(?,?,?,?,NOW(),?,?)";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, log.getLevel());
            pst.setInt(2, log.getUserId());
            pst.setString(3, log.getSrc());
            pst.setString(4, log.getContent());
            pst.setInt(5, log.getStatus());
            pst.setString(6,log.getIpAddress());
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<LogStatistics> countByBetween2days(Timestamp day1, Timestamp day2){
        PreparedStatement pst;
        ResultSet rs;
        String sql;
        List<LogStatistics> logs;
        try {
            logs = new ArrayList<>();
            sql = "select  user_name,`user`,count(id) as active_times from log INNER JOIN users on log.user = users.uid where createAt BETWEEN ? and ? and `user` <> -1 group by `user`";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setTimestamp(1,day1);
            pst.setTimestamp(2,day2);
            rs = pst.executeQuery();
            while (rs.next()){
                logs.add(new LogStatistics(rs.getString("user_name"),rs.getInt("user"),rs.getInt("active_times")));
            }
            return logs;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    public static List<LogStatistics> countBytoDay(){
        PreparedStatement pst;
        ResultSet rs;
        String sql;
        List<LogStatistics> logs;
        try {
            logs = new ArrayList<>();
            sql = "select  user_name,`user`,count(log.id) as active_times from log INNER JOIN users on log.user = users.uid where DAY(createAt) = DAY(NOW())   and `user` <> -1 group by `user`,user_name";
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()){
                logs.add(new LogStatistics(rs.getString("user_name"),rs.getInt("user"),rs.getInt("active_times")));
            }
            return logs;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<LogStatistics> countByDay(Timestamp day){
        PreparedStatement pst;
        ResultSet rs;
        String sql;
        List<LogStatistics> logs;
        try {
            logs = new ArrayList<>();
            sql = "select  user_name,`user`,count(id) as active_times from log INNER JOIN users on log.user = users.uid where DAY(createAt) = DAY(NOW())  and `user` <> -1 group by `user`";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setTimestamp(1,day);
            rs = pst.executeQuery();
            while (rs.next()){
                logs.add(new LogStatistics(rs.getString("user_name"),rs.getInt("user"),rs.getInt("active_times")));
            }
            return logs;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static  List<LogStatistics> countByIpAddress(){
        PreparedStatement pst;
        ResultSet rs;
        String sql;
        List<LogStatistics> logs;
        try {
            logs = new ArrayList<>();
            sql = "SELECT ipAddress,count(id) as active_times from log  group by ipAddress";
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()){
                logs.add(new LogStatistics(rs.getString("ipAddress"),rs.getInt("active_times")));
            }
            return logs;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }



    public static void main(String[] args) {
        System.out.println(countByIpAddress());
    }


    public static List<LogStatistics>  countThisMonth() {
        PreparedStatement pst;
        ResultSet rs;
        String sql;
        List<LogStatistics> logs;
        try {
            logs = new ArrayList<>();
            sql = "select  user_name,`user`,count(log.id) as active_times from log INNER JOIN users on log.user = users.uid where Month(createAt) = Month(NOW()) and `user` <> -1 group by `user`,user_name";
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()){
                logs.add(new LogStatistics(rs.getString("user_name"),rs.getInt("user"),rs.getInt("active_times")));
            }
            return logs;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static  Log findById(int id){
        PreparedStatement pst;
        ResultSet rs;
        String sql;
        Log log ;
        try {
            log = new Log();
            sql = "SELECT * from log";
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()){
               log.setId(rs.getInt("id"));
                log.setContent(rs.getString("content"));
                log.setSrc(rs.getString("src"));
                log.setLevel(rs.getInt("level"));
                log.setCreatAt(rs.getDate("createAt"));
            }
            return log;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<Log> getByIds(Log logModel) {
        List<Log> logs = new ArrayList<>();
        for (int id : logModel.getIds()) {
            logs.add(findById(id));
        }
        return logs;
    }

    public static void deletes(Log logModel) {
        for (int id : logModel.getIds()) {
            delete(id);
        }
    }

    public static void delete(int id){
        PreparedStatement pst;
        String sql;
        try {
            sql = "delete * from log where id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
