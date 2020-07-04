package ir.piana.dev.strutser.data.dao;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface GenericJdbcDAO {
    DataSource getDataSource();

    void executeSQL(String sql, String username, String ip);

    void executeSQLs(List sqls, String username, String ip);

    int update(String sql, Object[] params);

    List listEntities(String sql, int startFrom, int perPage);

    List queryForList(String sql, Object[] params);

    long queryForLong(String sql);

    long queryForLong(String sql, Object[] params);

    int queryForInt(String sql);

    int queryForInt(String sql, Object[] params);

    String queryForString(String sql);

    String queryForString(String sql,Object[] params);

    Object queryForObject(String sql);

    List listEntities(final String sql);

    List listEntities(final String sql, String mapToClass);

    List listEntities(final String sql, String mapToClass, int maxResults);

    List<Map<String, String>> listAllEntitiesMap(final String sql, boolean... isNewTransaction);

    Map<String, Map<String, String>> listAllEntitiesMap2(final String sql, boolean... isNewTransaction);

    List listEntitiesAllResult(final String sql);

    List generateTransactionReport(final String sql, String mapToClass, String username, String ip);

    Map findFirstRowBySql(String sql);

    List findRowsByValue(String table, String column, String value);

    void updateRowsByValue(String table, Map values, String column, String value, String username, String ip);

    void deleteRowsByValue(String table, String column, String value, String username, String ip);

    void addRow(String table, Map values, String username, String ip);

    void addRows(String table, List rowValues, String username, String ip);

    void executeBatch(String sql, final List<Object[]> paramValues);

    void executeBatch3(String sql, List<Object[]> paramValues);

    long getNextId(String sequenceName);

    void callStoredProcedure(String callStatement) throws SQLException;

    <T> T callStoredProcedure(String callStatement, Class<T> outputType, Object... inputParams) throws SQLException;
}
