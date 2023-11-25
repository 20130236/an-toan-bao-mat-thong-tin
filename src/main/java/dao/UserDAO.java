package dao;

import digitalsignature.API.KeyModel;
import model.UserModel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;

public class UserDAO {

    public static UserModel findLogin(String username, String password) {
        UserModel user = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select uid,user_name,password,role,enable,email from users where user_name = ? and password = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, password);
            rs = pst.executeQuery();
            while (rs.next()) {
                user = new UserModel(rs.getInt("uid"), rs.getString("user_name"), rs.getString("password"), rs.getInt("role"), rs.getInt("enable"));
                user.setEmail(rs.getString("email"));
            }
            if(user != null){
                user.setIdPms(RoleDAO.findById(user.getRole()).getIdPermissions());
            }
            return user;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static UserModel findByUser(String username) {
        UserModel user = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select enable from users where user_name = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, username);
            rs = pst.executeQuery();
            while (rs.next()) {
                user = new UserModel();
                user.setEnable(rs.getInt("enable"));
            }
            return user;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static UserModel findById(int id) {
        UserModel user = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select * from users where uid = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                user = new UserModel(rs.getInt("uid"), rs.getString("user_name"),rs.getString("password"), rs.getInt("role"),
                        rs.getString("full_name"), rs.getString("phone_num"), rs.getString("email"), rs.getString("address"), rs.getInt("enable"), rs.getString("gender"));
                user.setSignature(rs.getString("signature_text"));
            }
            return user;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static UserModel findByUserAndEmail(String username, String email) {
        UserModel user = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select * from users where user_name = ? and email = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, email);
            rs = pst.executeQuery();
            while (rs.next()) {
                user = new UserModel(rs.getInt("uid"), rs.getString("user_name"),rs.getString("password"), rs.getInt("role"),
                        rs.getString("full_name"), rs.getString("phone_num"), rs.getString("email"), rs.getString("address"), rs.getInt("enable"),rs.getString("gender"));
                user.setSignature(rs.getString("signature"));
            }
            return user;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void changePassword(int id, String newPassword){
        PreparedStatement pst;
        String sql;
        try {
            sql = "update users set password = ? where uid = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, newPassword);
            pst.setInt(2, id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void updateUserWeb(int id, String full_name, String phone_num, String email, String address, String gender, String signature_text) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "update users set full_name = ?, phone_num = ?, email = ?, address = ?, gender = ?, signature_text = ? where uid = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, full_name);
            pst.setString(2, phone_num);
            pst.setString(3, email);
            pst.setString(4, address);
            pst.setString(5, gender);
            pst.setString(6, signature_text);
            pst.setInt(7, id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void addUser(String user_name, String password, String full_name, String email, String gender) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "insert into users (user_name,password,full_name,email,gender,role,enable,num_log_in) values(?,?,?,?,?,?,?,?)";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, user_name);
            pst.setString(2, password);
            pst.setString(3, full_name);
            pst.setString(4, email);
            pst.setString(5, gender);
            pst.setInt(6, 0);
            pst.setInt(7, 0);
            pst.setInt(8, 0);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean checkUserName(String user_name){
        return check("user_name",user_name);
    }

    public static boolean checkEmail(String email){
        return check("user_name",email);
    }

    private static boolean check(String col, String value) {
        PreparedStatement pst;
        String sql;
        ResultSet rs;
        try {
            sql = "select * from users where " + col + " = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, value);
            rs = pst.executeQuery();
            if(rs.next()) return true;
            return false;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<UserModel> findAll() {
        List<UserModel> users = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            users = new ArrayList<>();
            sql = "select * from users";
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                users.add(new UserModel(rs.getInt("uid"), rs.getString("user_name"),rs.getString("password"), rs.getInt("role"),
                        rs.getString("full_name"), rs.getString("phone_num"), rs.getString("email"), rs.getString("address"), rs.getInt("enable"), rs.getString("gender")));
            }
            return users;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void save(UserModel user) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "insert into USER (user_name,password,full_name,role,email,enable) values(?,?,?,?,?,?)";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, user.getUserName());
            pst.setString(2, user.getPassWord());
            pst.setString(3, user.getFullName());
            pst.setInt(4, user.getRole());
            pst.setString(5, user.getEmail());
            pst.setInt(6, 1);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void updateUserAdmin(UserModel user) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "update users set full_name = ?, email = ?,role = ?, enable = ? where uid = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, user.getFullName());
            pst.setString(2, user.getEmail());
            pst.setInt(3, user.getRole());
            pst.setInt(4, user.getEnable());
            pst.setInt(5, user.getId());
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void detele(int id) {
        PreparedStatement pst;
        String sql;
        try {
            deleteUserForgetPassword(id);
            sql = "delete from users where uid = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

  /*  private static void deteleUserOrder(String username){

    }*/

    /*private static int selectIdOrderByUser(String username){
        int result;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "SELECT order_id from `order` where username = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,username);
            rs = pst.executeQuery();
            while (rs.next()) {

            }
            return users;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }*/

    public static void updateToken(int id, String token) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "update forget_password set token = ? where user_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,token);
            pst.setInt(2,id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean checkToken(String token){
        PreparedStatement pst;
        String sql;
        ResultSet rs;
        try {
            sql = "select * from forget_password where token = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,token);
            rs = pst.executeQuery();
            if(rs.next()) return true;
            return false;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void addToken(int id, String token, Timestamp create_date, Timestamp token_expiry) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "insert  into forget_password (uid,token,token_expiry,created_date) values (?,?,?,?)";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            pst.setString(2,token);
            pst.setTimestamp(3,token_expiry);
            pst.setTimestamp(4,create_date);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean checkTokenExpiry(int id, String token) {
        PreparedStatement pst;
        ResultSet rs;
        String sql;
        try {
            sql = "SELECT * from forget_password where token_expiry >= now() and uid = ? and token = ? ";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            pst.setString(2,token);
            rs = pst.executeQuery();
            if(rs.next()) return true;
            return false;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static UserModel findByToken(String token) {
        UserModel user = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "select * from forget_password where token = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, token);
            rs = pst.executeQuery();
            while (rs.next()) {
                user = new UserModel(rs.getInt("uid"),"","",0,
                        1);
            }
            return user;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void deleteToken(int id, String token) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "delete from forget_password where  uid = ? and token = ? ";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            pst.setString(2,token);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    private static void deleteUserForgetPassword(int id) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "delete from forget_password where  uid = ? ";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static UserModel findByRdData(String rdData) {
        UserModel user = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "SELECT * from users u INNER JOIN verify v on u.uid = v.uid where token = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, rdData);
            rs = pst.executeQuery();
            user = new UserModel();
            while (rs.next()) {
                user.setId(rs.getInt("uid"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
            }
            return user;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void deleteVerify(String rdData) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "delete from verify where token = ? ";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,rdData);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void addVerify(int user_id, String rdData, Timestamp create_date, Timestamp verify_expiry) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "insert into verify (uid,token,created_date,token_expiry) values (?,?,?,?)";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,user_id);
            pst.setString(2,rdData);
            pst.setTimestamp(3,create_date);
            pst.setTimestamp(4,verify_expiry);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static UserModel checkVerify(String rdData) {
        PreparedStatement pst;
        String sql;
        ResultSet rs;
        UserModel user = null;
        try {
            sql = "select u.enable,u.uid from verify v inner join users u on v.uid = u.uid where token_expiry >= now() and token = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,rdData);
            rs = pst.executeQuery();
            while (rs.next()) {
                user = new UserModel();
                user.setId(rs.getInt("uid"));
                user.setEnable(rs.getInt("enable"));
            }
            return user;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void setVerified(String randomData) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "update users u inner join verify v on u.uid = v.uid  set enable = 1 where token = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,randomData);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void updateStatus(int status,String username) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "update users set enable = ? where user_name = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,status);
            pst.setString(2,username);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean checkNumLogin(String username) {
        PreparedStatement pst;
        String sql;
        ResultSet rs;
        int number = 0;
        try {
            sql = "select num_log_in from users where user_name =  ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,username);
            rs = pst.executeQuery();
            while(rs.next()){
                number = rs.getInt("num_log_in");
            }
            return number > 5;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void updateNumLogin(String username) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "update users set num_log_in = num_log_in + 1 where user_name = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,username);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deletes( UserModel userModel) {
        for(int i : userModel.getIds()){
            detele(i);
        }
    }

    public static List<UserModel> getByIds(UserModel user) {
        List<UserModel> users = new ArrayList<>();
        for(int i : user.getIds()){
            users.add(findById(i));
        }
        return users;
    }

    public static String getPublicKey(int id) {
        PreparedStatement pst;
        ResultSet rs;
        String sql;
        String result = null;
        try {
            sql = "SELECT public_key from `key` where user_id = ? and `status` = 1";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            rs = pst.executeQuery();
            while(rs.next()){
                result = rs.getString("public_key");
            }
            return result;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void saveSignature(String path, String username){
        PreparedStatement pst;
        String sql;
        try {
            sql = "update users set signature = ? where user_name = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,path);
            pst.setString(2,username);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static String getSignature(int uid) {
        PreparedStatement pst;
        String sql;
        ResultSet rs;
        String result = null;
        try {
            sql = "select signature from users where uid =  ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,uid);
            rs = pst.executeQuery();
            while(rs.next()){
                result = rs.getString("signature");
            }
            return result;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void createKey(KeyModel keyModel, int id) {
        if(selectKey(id) == null){
            insertKey(keyModel,id);
        } else{
            updateKey(keyModel,id);
        }
    }

    private static void insertKey(KeyModel keyModel,int id){
        PreparedStatement pst;
        String sql;
        try {
            sql = "insert into `key` (user_id,public_key,status) values(?,?,?,?)";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, id);
            pst.setString(2, keyModel.getPublicKey());
            pst.setInt(3, 1);;
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    private static void updateKey(KeyModel keyModel,int id){
        PreparedStatement pst;
        String sql;
        try {
            sql = "update `key` set public_key = ? where user_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,keyModel.getPublicKey());
            pst.setInt(2,id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    private static String selectKey(int id){
        PreparedStatement pst;
        String sql;
        ResultSet rs;
        String result = null;
        try {
            sql = "select public_key from `key` where user_id = ? and status = 1";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            rs = pst.executeQuery();
            while(rs.next()){
                result = rs.getString("public_key");
            }
            return result;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
