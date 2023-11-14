package mapper;

import model.Log;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LogMapper implements RowMapper<Log>{
    @Override
    public Log mapRow(ResultSet rs) {
        try {
            Log log = new Log();
            log.setId(rs.getInt("id"));
            log.setUserId(rs.getInt("user"));
            log.setSrc(rs.getString("src"));
            log.setLevel(rs.getInt("level"));
            log.setContent(rs.getString("content"));
            log.setStatus(rs.getInt("status"));
            log.setCreatAt(rs.getDate("createAt"));
            log.setIpAddress(rs.getString("ipAddress"));
            return log;
        } catch (SQLException e){
            return null;
        }
    }
}
