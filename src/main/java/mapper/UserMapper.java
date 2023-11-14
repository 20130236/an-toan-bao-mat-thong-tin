package mapper;

import model.UserModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserMapper implements RowMapper<UserModel>{

    @Override
    public UserModel mapRow(ResultSet rs) {
        try {
            UserModel user = new UserModel();
            user.setId(rs.getInt("uid"));
            user.setUserName(rs.getString("user_name"));
            user.setFullName(rs.getString("full_name"));
            user.setPassWord(rs.getString("password"));
            user.setEnable(rs.getInt("enable"));
            user.setAddress(rs.getString("address"));
            user.setEmail(rs.getString("email"));
            user.setGender(rs.getString("gender"));
            user.setRole(rs.getInt("role"));
            user.setRoleTitle(rs.getString("title"));
            user.setPhoneNum(rs.getString("phone_num"));
            return user;
        } catch (SQLException e) {
            return null;
        }
    }
}
