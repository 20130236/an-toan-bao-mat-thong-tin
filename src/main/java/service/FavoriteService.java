package service;

import dao.DBConnection;
import model.Favorite;
import model.Product;
import org.apache.taglibs.standard.lang.jstl.test.beans.Factory;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FavoriteService {
    public List<Favorite> getFavById(String uname) {
        List<Favorite> fav = new ArrayList<>();
        String sql = "SELECT favorite_product_id, user_name, product_id FROM favorites WHERE user_name = ?";
        try (PreparedStatement pst = DBConnection.getConnection().prepareStatement(sql)) {
            pst.setString(1, uname);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    fav.add(new Favorite(rs.getInt(1), rs.getString(2), rs.getInt(3)));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return fav;
    }


    public List<Product> getAllProductFav(String uname) {
        List<Product> products = new ArrayList<>();
        List<Favorite> fav = new ArrayList<>();
        Favorite f = null;
        Product product = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "SELECT favorite_product_id, user_name, product_id  FROM favorites WHERE user_name like ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setString(1, uname);
            rs = pst.executeQuery();
            while (rs.next()) {
                f = new Favorite(rs.getInt(1), rs.getString(2), rs.getInt(3));
                fav.add(f);
            }
            for (Favorite favorite : fav) {
                product = ProductService.getProductById(favorite.getProduct_id());
                products.add(product);
            }

        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        return products;

    }

    public boolean isProductInFavoriteList(String user_name, int product_id) {
        String sql = "SELECT * FROM favorites WHERE user_name = ? AND product_id = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = DBConnection.getConnection().prepareStatement(sql);
            ps.setString(1, user_name);
            ps.setInt(2, product_id);
            rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void addFav(Favorite fav) {
        if (!isProductInFavoriteList(fav.getUser_name(), fav.getProduct_id())) {
            String sql = "INSERT INTO favorites (user_name, product_id) VALUES(?,?)";
            PreparedStatement ps = null;
            int rs = 0;
            try {
                ps = DBConnection.getConnection().prepareStatement(sql);
                ps.setString(1, fav.getUser_name());
                ps.setInt(2, fav.getProduct_id());
                rs = ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void deleteFav(String user_name, int product_id) {
        String sql = "DELETE FROM favorites WHERE user_name=? AND product_id=?";
        PreparedStatement ps = null;
        int rs = 0;
        try {
            ps = DBConnection.getConnection().prepareStatement(sql);
            ps.setString(1, user_name);
            ps.setInt(2, product_id);
            rs = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public static void main(String[] args) {
        FavoriteService f = new FavoriteService();
        Favorite ff = new Favorite(100, "huyen", 2);
        //   f.addFav(ff);
        System.out.println(f.getFavById("huyen"));
        //    System.out.println(f.getAllProductFav("huyen"));
        f.deleteFav("huyen", 5);
        System.out.println(f.getFavById("huyen"));
    }
}
