package mapper;

import model.ImportProduct;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ImportProductMapper implements RowMapper<ImportProduct> {

    @Override
    public ImportProduct mapRow(ResultSet rs) {
        try {
            ImportProduct product = new ImportProduct();
            //product.setName(rs.getString("name"));
            product.setPro_id(rs.getInt("product_id"));
            product.setUsername(rs.getString("user_name"));
            product.setQuantity(rs.getInt("quantity"));
            product.setDate(rs.getDate("date"));
            return product;
        } catch (SQLException e) {
            return null;
        }
    }
}
