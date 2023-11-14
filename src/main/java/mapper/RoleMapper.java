package mapper;


import dao.RoleDAO;
import model.Role;

import java.sql.ResultSet;
import java.sql.SQLException;

public class RoleMapper implements RowMapper<Role>{
    @Override
    public Role mapRow(ResultSet rs) {
        try {
            Role role = new Role();
            role.setId(rs.getInt("id"));
            role.setName(rs.getString("title"));
            role.setNumUser(RoleDAO.countUser(rs.getInt("id")));
            return role;
        } catch (SQLException e){
            return null;
        }
    }
}
