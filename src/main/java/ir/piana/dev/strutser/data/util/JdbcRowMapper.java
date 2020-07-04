package ir.piana.dev.strutser.data.util;

import ir.piana.dev.strutser.data.model.Sms;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class JdbcRowMapper implements RowMapper {
    private String type;

    public JdbcRowMapper(String type) {
        this.type = type;
    }

    @Override
    public Object mapRow(ResultSet resultSet, int i) throws SQLException {
        if (type.equals("Sms")) {
            Sms sms = new Sms();
            sms.setSmsId(new Long(resultSet.getLong("sms_id")));
            sms.setContent(resultSet.getString("content"));
            sms.setFromNumber(resultSet.getString("from_number"));
            sms.setToNumber(resultSet.getString("to_number"));
            sms.setResponse(resultSet.getString("response"));
            return sms;
        }
        return null;
    }
}
