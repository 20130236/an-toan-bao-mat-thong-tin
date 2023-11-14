package dao;

import model.ImgProductSearchModel;
import model.Product;
import model.ProductSearchModel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductSearchDAO {

    public static List<ProductSearchModel> searchByName(String txtSearch, int offset, int limit) {
        List<ProductSearchModel>  list;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            list = new ArrayList<>();
            sql = "select * from products where name like ? limit ?,?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, "%" + txtSearch + "%");
            pst.setInt(2, offset);
            pst.setInt(3, limit);
            rs = pst.executeQuery();
            while (rs.next()) {
                list.add(new ProductSearchModel(rs.getInt("product_id"),rs.getString("name"),rs.getInt("price"),
                        rs.getInt("price_sell"),rs.getString("info"),rs.getInt("status"),findImg(rs.getInt("product_id"))));

            }
            return list.isEmpty()?null:list;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<ProductSearchModel> searchByNameOderBy(String txtSearch, int offset, int limit, String col, String value) {
        List<ProductSearchModel> list ;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            list = new ArrayList<>();
            sql = "select * from products where name like ? order by " + col + " " + value + " limit ?,?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, "%" + txtSearch + "%");
            pst.setInt(2, offset);
            pst.setInt(3, limit);
            rs = pst.executeQuery();
            while (rs.next()) {
                list.add(new ProductSearchModel(rs.getInt("product_id"),rs.getString("name"),rs.getInt("price"),
                        rs.getInt("price_sell"),rs.getString("info"),rs.getInt("status"),findImg(rs.getInt("product_id"))));

            }
            return list.isEmpty()?null:list;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<ImgProductSearchModel> findImg(int id){
        List<ImgProductSearchModel>  list ;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            list = new ArrayList<>();
            sql = "select * from images where product_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                list.add(new ImgProductSearchModel(rs.getString("img_url")));
            }
            return list.isEmpty()?null:list;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void updateImgs(int id,String [] url){
        deleteAllImg(id);
        for(String st : url){
            addImg(id,st);
        }
    }

    public static void addImg(int id,String url){
        PreparedStatement pst;
        String sql;
        try {
            sql = "insert into images (product_id,img_url) values(?,?)";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, id);
            pst.setString(2, url);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteAllImg(int id){
        PreparedStatement pst;
        String sql;
        try {
            sql = "delete from images where product_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<ProductSearchModel> searchByNameOnSale(String txtSearch, int offset, int limit) {
        List<ProductSearchModel> list = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            list = new ArrayList<>();
            sql = "select * from products  where name like ? and price_sell < price limit ?,?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, "%" + txtSearch + "%");
            pst.setInt(2, offset);
            pst.setInt(3, limit);
            rs = pst.executeQuery();
            while (rs.next()) {
                list.add(new ProductSearchModel(rs.getInt("product_id"),rs.getString("name"),rs.getInt("price"),
                        rs.getInt("price_sell"),rs.getString("info"),rs.getInt("status"),findImg(rs.getInt("product_id"))));
            }
            return list.isEmpty()?null:list;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        System.out.println(searchByName("ghế",1,2));
    }

    public static void deletes(Product product) {
        for(int i : product.getIds()){
            detele(i);
        }
    }
    public static void detele(int id){
        PreparedStatement pst;
        String sql;
        try {
            sql = "delete from products where product_id = ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, id);
            pst.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
