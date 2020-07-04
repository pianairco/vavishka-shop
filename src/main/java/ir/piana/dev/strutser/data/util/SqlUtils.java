package ir.piana.dev.strutser.data.util;

import java.util.Iterator;
import java.util.Map;

public class SqlUtils {
    private static SqlUtils _instance = new SqlUtils();

    private SqlUtils() {
    }

    public static SqlUtils getInstance() {
        return _instance;
    }

    public static String getInsertStatement(String table, Map values) {
        String s1 = "(";
        String s2 = "(";
        for (Iterator iterator = values.keySet().iterator(); iterator.hasNext(); ) {
            String key = (String) iterator.next();
            Object value = values.get(key);
            String valueString;
            if (value == null ||
                    value instanceof Integer ||
                    value instanceof Long ||
                    //todo use a sign like $$$ or a simple class
                    value.toString().toUpperCase().indexOf(".NEXTVAL") != -1
            ) {
                valueString = value + "";
            } else {
                valueString = "'" + value + "'";
            }
            s1 += key;
            s2 += valueString;
            if (iterator.hasNext()) {
                s1 += ", ";
                s2 += ", ";
            } else {
                s1 += ") ";
                s2 += ") ";
            }
        }
        String sql = "INSERT INTO " + table + s1 + " VALUES " + s2;
        return sql;
    }

    public static String getUpdateStatement(String table, Map values, String column, String value, String oprand) {
        String condition = column + " " + oprand + " ( " + value + " ) ";
        return getUpdateStatement(table, values, condition);
    }

    public static String getUpdateStatement(String table, Map values, String column, String value) {
        String condition = column + "=" + value;
        return getUpdateStatement(table, values, condition);
    }

    public static String getUpdateStatement(String table, Map values, String condition) {
        String sql = "update " + table + " set ";
        for (Iterator iterator = values.keySet().iterator(); iterator.hasNext(); ) {
            String key = (String) iterator.next();
            Object newValue = values.get(key);
            String valueString;
            if (newValue == null ||
                    newValue instanceof Integer ||
                    newValue instanceof Long ||
                    newValue.toString().toUpperCase().indexOf(".NEXTVAL") != -1
            ) {
                valueString = newValue + "";
            } else {
                valueString = "'" + newValue + "'";
            }
            sql += key + "=" + valueString;
            if (iterator.hasNext()) {
                sql += ", ";
            }
        }
        sql += " where " + condition;
        return sql;
    }

    public static String getDeleteStatement(String table, String column, String value, String oprand) {
        String sql = "delete from " + table;
        sql += (" where " + column + " " + oprand + " ( " + value + " ) ");
        return sql;
    }

    public static String getDeleteStatement(String table, String column, String value) {
        String sql = "delete from " + table;
        sql += " where " + column + "=" + value;
        return sql;
    }
}
