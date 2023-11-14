package dao;

import model.ImportProduct;
import service.ProductService;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ImportProductDAO {

    public static List<ImportProduct> findAll() {
        List<ImportProduct> products ;
        ResultSet rs;
        PreparedStatement pst;
        String sql;
        try {
            products = new ArrayList<>();
            sql = "select ip.product_id,user_name,quantity,date from import_products ip inner join products p on ip.product_id = p.product_id";
            pst = DBConnection.getConnection().prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                products.add(new ImportProduct(rs.getInt("product_id"),rs.getString("user_name"),rs.getInt("quantity"),rs.getDate("date")));
            }
            return products;
        }
        catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void importProducts(ImportProduct importProduct, String username) {
        int [] ids = importProduct.getIds();
        int [] quantities = importProduct.getQuantities();
        for(int i = 0 ; i < ids.length ; i ++){
            importProduct(ids[i],quantities[i],username);
            ProductService.updateQuantity(ids[i],quantities[i]);
        }
    }

    public static void importProduct(int id, int quantity , String username){
        PreparedStatement pst;
        String sql;
        try {
            sql = "insert into import_products (product_id,user_name,quantity,date) values (?,?,?,now())";
            pst = DBConnection.getConnection().prepareStatement(sql);
            pst.setInt(1,id);
            pst.setString(2,username);
            pst.setInt(3,quantity);
            pst.executeUpdate();
        }
        catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
