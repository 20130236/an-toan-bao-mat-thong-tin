package mapper;

import model.Product;
import model.UserModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductMapper implements RowMapper<Product> {

    @Override
    public Product mapRow(ResultSet rs) {
        try {
            Product product = new Product();
            product.setProduct_id(rs.getInt("product_id"));
            product.setName(rs.getString("name"));
            product.setPrice(rs.getInt("price"));
            product.setPrice_sell(rs.getInt("price_sell"));
            product.setInfo(rs.getString("info"));
            product.setCode(rs.getString("code"));
            product.setBrand(rs.getString("brand"));
            product.setStatus(rs.getInt("status"));
            product.setProduct_type(rs.getInt("product_type"));
            return product;
        } catch (SQLException e) {
            return null;
        }
    }
}
