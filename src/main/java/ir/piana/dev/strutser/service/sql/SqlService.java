package ir.piana.dev.strutser.service.sql;

import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SqlService {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    SqlProperties sqlProperties;

    @Autowired
    public SqlService(SqlProperties properties) {
        sqlProperties = properties;
    }

    public long insert(String group, String sequenceName, Object[] sqlParams) {
        Long id = jdbcTemplate.queryForObject("select " + sequenceName + ".nextval from dual", Long.class);
        jdbcTemplate.update(sqlProperties.getGroups().get(group).getInsert(), ArrayUtils.addAll(new Object[] {id}, sqlParams));
        return id == null ? 0 : id;
    }

    public void update(String group, Object[] sqlParams) {
        jdbcTemplate.update(sqlProperties.getGroups().get(group).getUpdate(), sqlParams);
    }

    public List<Map<String, Object>> list(String group) {
        return jdbcTemplate.queryForList(sqlProperties.getGroups().get(group).getSelect());
    }
}
