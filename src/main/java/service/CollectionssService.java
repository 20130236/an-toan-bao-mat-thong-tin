package service;

import dao.DBConnection;
import model.Collection.Collectionss;
import model.Collection.Collection_detail;
import model.Product;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CollectionssService {
    public List<Collectionss> getCollecttion() {
        List<Collectionss> collectionsses = new ArrayList<>();
        String sql = "SELECT id, name FROM collection";
        try (PreparedStatement pst = DBConnection.getConnection().prepareStatement(sql)) {
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    collectionsses.add(new Collectionss(rs.getInt(1), rs.getString(2)));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return collectionsses;
    }
    public String getNameCol(int id) {
        String result = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "SELECT  name FROM collection WHERE id like ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
               result = rs.getString(1);
            }

        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        return result;

    }
    public List<Product> getListCol(int id) {
        List<Product> products = new ArrayList<>();
        List<Collection_detail> collection_details = new ArrayList<>();
        Collection_detail collectionDetail = null;
        Product product = null;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            sql = "SELECT id_detail, id_collection,id_product  FROM collection_detail WHERE id_collection like ?";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                collectionDetail = new Collection_detail(rs.getInt(1), rs.getInt(2), rs.getInt(3));
                collection_details.add(collectionDetail);
            }
            for (Collection_detail c : collection_details) {
                product = ProductService.getProductById(c.getId_product());
                products.add(product);
            }

        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        return products;

    }

    public static void main(String[] args) {
    CollectionssService service = new CollectionssService();
        //System.out.println(service.getNameCol(1));
    }
}
