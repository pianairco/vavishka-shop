package ir.piana.dev.strutser.data.dao;

import ir.piana.dev.strutser.data.util.JdbcRowMapper;
import ir.piana.dev.strutser.data.util.SqlUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.DependsOn;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

//@Component
//@DependsOn({"dataSource", "jdbcTemplate"})
//@Transactional
@Slf4j
public class GenericJdbcDAOImpl extends JdbcDaoSupport implements GenericJdbcDAO {
    private String getLimitedSql(String sql, int startFrom, int perPage) {
        String q = "SELECT * FROM ( SELECT x$x.*, ROWNUM r FROM ( " + sql + " ) x$x " +
                "WHERE ROWNUM <= " + (startFrom+perPage) + " ) WHERE r > " + startFrom;
        return q;
    }

    @Override
    public void executeSQL(String sql, String username, String ip) {
        getJdbcTemplate().execute(sql);
    }

    @Override
    public void executeSQLs(List sqls, String username, String ip) {
        for (Iterator iterator = sqls.iterator(); iterator.hasNext();) {
            String sql = (String) iterator.next();
            executeSQL(sql, username, ip);
        }
    }

    @Override
    public int update(String sql, Object[] params) {
        return getJdbcTemplate().update(sql, params);
    }

    @Override
    public List listEntities(String sql, int startFrom, int perPage) {
        return getJdbcTemplate().queryForList(getLimitedSql(sql, startFrom, perPage));
    }

    @Override
    public List queryForList(String sql, Object[] params) {
        return getJdbcTemplate().queryForList(sql, params);
    }

    @Override
    public long queryForLong(String sql) {
        return getJdbcTemplate().queryForObject(sql, Long.class);
    }

    @Override
    public long queryForLong(String sql, Object[] params) {
        return getJdbcTemplate().queryForObject(sql, params, Long.class);
    }

    @Override
    public int queryForInt(String sql) {
        return getJdbcTemplate().queryForObject(sql, Integer.class);
    }

    @Override
    public int queryForInt(String sql, Object[] params) {
        return getJdbcTemplate().queryForObject(sql, params, Integer.class);
    }

    @Override
    public String queryForString(String sql) {
        return getJdbcTemplate().queryForObject(sql, String.class);
    }

    @Override
    public String queryForString(String sql,Object[] params) {
        return getJdbcTemplate().queryForObject(sql, params, String.class);
    }

    @Override
    public Object queryForObject(String sql){
        return getJdbcTemplate().queryForObject(sql, Object.class);
    }

    @Override
    public List listEntities(final String sql) {
        return listEntities(sql, null);
    }

    @Override
    public List listEntities(final String sql, String mapToClass) {

//    int maxResults = queryForInt("select param_value from app_param where param_code='QUERY_MAX_RESULTS'");
//        int maxResults = (int) ((BigDecimal)dataCache.getDefault().APP_PARAM.get("QUERY_MAX_RESULTS").get("PARAM_VALUE")).doubleValue();
        int maxResults = 1000;
        if (maxResults == 0) {
            maxResults = 1000;
        }
//    return getJdbcTemplate().query(sql, new JdbcRowMapper(mapToClass));
        return listEntities(sql, mapToClass, maxResults);
    }

    @Override
    public List listEntities(final String sql, String mapToClass, int maxResults) {
        String limitedSql = getLimitedSql(sql, 0, maxResults);
        if (mapToClass != null) {
            return getJdbcTemplate().query(limitedSql, new JdbcRowMapper(mapToClass));
        } else {
            return getJdbcTemplate().queryForList(limitedSql);
        }
    }

    @Override
    public List<Map<String, String>> listAllEntitiesMap(final String sql, boolean... isNewTransaction) {
        List<Map<String, String>> result = new ArrayList<Map<String, String>>();
        Connection connection = null;
        boolean isNewTrans = isNewTransaction.length > 0 && isNewTransaction[0];
        try {
            connection = isNewTrans ? getDataSource().getConnection() : DataSourceUtils.getConnection(getJdbcTemplate().getDataSource());
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            ResultSetMetaData metaData = rs.getMetaData();
            int cc = metaData.getColumnCount();
            String[] cnames = new String[cc];
            for (int i = 0; i < cnames.length; i++) {
                cnames[i] = metaData.getColumnName(i+1);
            }
            while (rs.next()) {
                Map<String, String> row = new HashMap<String, String>();
                for (int i = 0; i < cc; i++) {
                    row.put(cnames[i], rs.getString(i+1));
                }
                result.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (isNewTrans)
                try {
                    connection.close();
                } catch (Exception e) {
                }
            else
                DataSourceUtils.releaseConnection(connection, getJdbcTemplate().getDataSource());
        }
        return result;
    }

    @Override
    public Map<String, Map<String, String>> listAllEntitiesMap2(final String sql, boolean... isNewTransaction) {
        Map<String, Map<String, String>> result = new HashMap<String, Map<String, String>>();
        Connection connection = null;
        boolean isNewTrans = isNewTransaction.length > 0 && isNewTransaction[0];
        try {
            connection = isNewTrans ? getDataSource().getConnection() : DataSourceUtils.getConnection(getJdbcTemplate().getDataSource());
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            ResultSetMetaData metaData = rs.getMetaData();
            int cc = metaData.getColumnCount();
            String[] cnames = new String[cc];
            for (int i = 0; i < cnames.length; i++) {
                cnames[i] = metaData.getColumnName(i+1);
            }
            while (rs.next()) {
                Map<String, String> row = new HashMap<String, String>();
                for (int i = 0; i < cc; i++) {
                    row.put(cnames[i], rs.getString(i+1));
                }
                result.put(rs.getString(1), row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (isNewTrans)
                try {
                    connection.close();
                } catch (Exception e) {
                }
            else
                DataSourceUtils.releaseConnection(connection, getJdbcTemplate().getDataSource());
        }
        return result;
    }

    @Override
    public List listEntitiesAllResult(final String sql) {
        return  listEntities(sql, null, 100000);
    }

    @Override
    public List generateTransactionReport(final String sql, String mapToClass, String username, String ip) {
        executeSQL(sql, username, ip);
        return getJdbcTemplate().query(sql, new JdbcRowMapper(mapToClass));
    }

    @Override
    public Map findFirstRowBySql(String sql) {
//    log.debug(sql);
        List rows = null;
        try {
//      rows = getJdbcTemplate().queryForList(sql);
            rows = listEntities(sql);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        if (rows != null && rows.size() > 0) {
            return (Map) rows.get(0);
        }
        return null;
    }

    @Override
    public List findRowsByValue(String table, String column, String value) {
        String sql = "select * from " + table + " where " + column + "=" + value;
        List rows = null;
        try {
//      rows = getJdbcTemplate().queryForList(sql);
            rows = listEntities(sql);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        return rows;
    }

    @Override
    public void updateRowsByValue(String table, Map values, String column, String value, String username, String ip) {
        // 1386/12/21 shahram >>
/*
		try {
			Connection conn = getConnection();
			oracle.jdbc.internal.OracleConnection ioc = (oracle.jdbc.internal.OracleConnection) conn;
			ioc.setApplicationContext("CLIENTCONTEXT", "username", username);
			ioc.setApplicationContext("CLIENTCONTEXT", "ip", ip);

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
*/
        // 1386/12/21 shahram <<

        String sql = SqlUtils.getUpdateStatement(table, values, column, value);
        getJdbcTemplate().execute(sql);
    }

    @Override
    public void deleteRowsByValue(String table, String column, String value, String username, String ip) {
        // 1386/12/21 shahram >>
/*
		try {
			Connection conn = getConnection();
			oracle.jdbc.internal.OracleConnection ioc = (oracle.jdbc.internal.OracleConnection) conn;
			ioc.setApplicationContext("CLIENTCONTEXT", "username", username);
			ioc.setApplicationContext("CLIENTCONTEXT", "ip", ip);

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
*/
        // 1386/12/21 shahram <<

        String sql = SqlUtils.getDeleteStatement(table, column, value);
        getJdbcTemplate().execute(sql);
    }

    @Override
    public void addRow(String table, Map values, String username, String ip) {
        // 1386/12/21 shahram >>
/*
		try {
			Connection conn = getConnection();
			oracle.jdbc.internal.OracleConnection ioc = (oracle.jdbc.internal.OracleConnection) conn;
			ioc.setApplicationContext("CLIENTCONTEXT", "username", username);
			ioc.setApplicationContext("CLIENTCONTEXT", "ip", ip);

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
*/
        // 1386/12/21 shahram <<

        String sql = SqlUtils.getInsertStatement(table, values);
        getJdbcTemplate().update(sql);
    }

    @Override
    public void addRows(String table, List rowValues, String username, String ip) {
        for (Iterator iterator = rowValues.iterator(); iterator.hasNext();) {
            Map values = (Map) iterator.next();
            addRow(table, values, username, ip);
        }
    }

    @Override
    public void executeBatch(String sql, final List<Object[]> paramValues) {
        int[] updateCounts = getJdbcTemplate().batchUpdate(sql,
                new BatchPreparedStatementSetter() {
                    public void setValues(PreparedStatement ps, int i) throws SQLException {
                        Object[] values = paramValues.get(i);
                        for (int j = 0; j < values.length; j++) {
                            Object value = values[j];
                            if (value instanceof Long) {
                                ps.setLong(j+1, (Long) value);
                            } else if (value instanceof String) {
                                ps.setString(j+1, (String) value);
                            } else if (value instanceof Double) {
                                ps.setDouble(j + 1, (Double) value);
                            } else {
                                ps.setNull(j + 1, Types.INTEGER);
                            }
                        }
                    }

                    public int getBatchSize() {
                        return paramValues.size();
                    }
                });
    }

    @Override
    public void executeBatch3(String sql, List<Object[]> paramValues) {
        try {
            long t1 = System.currentTimeMillis();
            DataSource ds = getJdbcTemplate().getDataSource();
            Connection connection = ds.getConnection();
//      connection.setAutoCommit(false);
            PreparedStatement ps = connection.prepareStatement(sql);
            final int batchSize = 1000;
            int count = 0;

            for (Iterator<Object[]> iterator = paramValues.iterator(); iterator.hasNext(); ) {
                Object[] values = iterator.next();
                for (int j = 0; j < values.length; j++) {
                    Object value = values[j];
                    if (value instanceof Long) {
                        ps.setLong(j+1, (Long) value);
                    } else if (value instanceof String) {
                        ps.setString(j+1, (String) value);
                    }
                }
                ps.addBatch();
                if(++count % batchSize == 0) {
                    ps.executeBatch();
//          ps.clearBatch();
                }
            }

            ps.executeBatch(); // insert remaining records
//      ps.clearBatch();
//      connection.commit();
            ps.close();
//      connection.setAutoCommit(true);
            long t2 = System.currentTimeMillis();
            System.out.println("insert "+paramValues.size()+" records took " + (t2-t1) + " milliseconds");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public long getNextId(String sequenceName) {
//    synchronized(lockGetNextId) {
        String sql = "select " + sequenceName + ".NEXTVAL nextValue from dual ";
        long nextId = getJdbcTemplate().queryForObject(sql, Long.class);
        return nextId;
//    }
    }

    @Override
    public void callStoredProcedure(String callStatement) throws SQLException {
        CallableStatement cs;
        cs = getDataSource().getConnection().prepareCall(callStatement);
        cs.execute();
    }

    @Override
    public <T> T callStoredProcedure(String callStatement, Class<T> outputType, Object... inputParams)
            throws SQLException {
        CallableStatement cs;
        cs = getDataSource().getConnection().prepareCall(callStatement);
        int index = 1;
        if (Number.class.equals(outputType))
            cs.registerOutParameter(index++, Types.INTEGER);
        else if (String.class.equals(outputType))
            cs.registerOutParameter(index++, Types.VARCHAR);

        for (Object inputParam : inputParams) {
            if (inputParam == null)
                cs.setNull(index++, Types.NULL);
            else if (inputParam instanceof Integer)
                cs.setInt(index++, (Integer) inputParam);
            else if (inputParam instanceof Long)
                cs.setLong(index++, (Long) inputParam);
            else if (inputParam instanceof String)
                cs.setString(index++, (String) inputParam);
            else if (inputParam instanceof BigDecimal)
                cs.setBigDecimal(index++, (BigDecimal) inputParam);
            else if (inputParam instanceof Double)
                cs.setDouble(index++, (Double) inputParam);
        }
        cs.execute();
        if (Number.class.equals(outputType))
            return (T) Long.valueOf(cs.getLong(1));
        else if (String .class.equals(outputType))
            return (T) cs.getString(1);
        return null;
    }
}
