package mapper;

import dao.CategoryProDAO;
import model.CategoryProModel;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CateProductMapper implements RowMapper<CategoryProModel>{
    @Override
    public CategoryProModel mapRow(ResultSet rs) {
        try {
            CategoryProModel categoryProModel = new CategoryProModel();
            categoryProModel.setId(rs.getInt("type_id"));
            categoryProModel.setName(rs.getString("type_name"));
            categoryProModel.setNumbOfPro(CategoryProDAO.countProByCateId(rs.getInt("type_id")));
            return categoryProModel;
        } catch (SQLException e){
            return null;
        }
    }
}
