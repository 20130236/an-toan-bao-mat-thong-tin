package dao;

import model.CategoryProModel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryProDAO {

    public static void addCate(String name) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "insert into product_type (type_name) values(?)";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,name);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteCate(int id) {
        PreparedStatement pst;
        String sql;
        deleteCateInProduct(id);
        try {
            sql = " delete from product_type where type_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    private static void deleteCateInProduct(int id){
        PreparedStatement pst;
        String sql;
        try {
            sql = "delete from products where type_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void updateCate(int id,String name) {
        PreparedStatement pst;
        String sql;
        try {
            sql = "update product_type set type_name = ? where type_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1,name);
            pst.setInt(2,id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static int countProByCateId(int id) {
        int result = 0;
        PreparedStatement pst;
        String sql;
        ResultSet rs;
        try {
            sql = "select count(*) as numOfPro from products where product_type = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            rs = pst.executeQuery();
            while (rs.next()){
               result = rs.getInt("numOfPro");
            }
            return result;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public static  List<CategoryProModel> findAll(){
        List<CategoryProModel> list;
        PreparedStatement pst;
        String sql;
        ResultSet rs;
        try {
            list = new ArrayList<>();
            sql = "select * from product_type";
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()){
                list.add(new CategoryProModel(rs.getInt("type_id"),rs.getString("type_name"),countProByCateId(rs.getInt("type_id"))));
            }
            return list;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static CategoryProModel findById(int id) {
        CategoryProModel cate = null;
        PreparedStatement pst;
        String sql;
        ResultSet rs;
        try {
            sql = "select * from product_type where type_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            rs = pst.executeQuery();
            while (rs.next()){
                cate = new CategoryProModel(rs.getInt("type_id"),rs.getString("type_name"),countProByCateId(rs.getInt("type_id")));
            }
            return cate;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void deletes(CategoryProModel categoryPro) {
        for (int id:categoryPro.getIds()) {
            deleteCate(id);
        }
    }

    public static List<CategoryProModel> findByIds(CategoryProModel categoryPro) {
        List<CategoryProModel> categoryProModels = new ArrayList<>();
        for (int id: categoryPro.getIds()) {
            categoryProModels.add(findById(id));
        }
        return categoryProModels;
    }
}
