package ir.piana.dev.strutser.dynamic.sql;

/**
 * Created by mj.rahmati on 12/16/2019.
 */
public enum SQLType {
    UNKNOWN(""),
    SELECT("select"),
    SELECT_FOR_INT("select-for-int"),
    UPDATE("update"),
    INSERT("insert"),
    DELETE("delete");

    private String name;

    SQLType(String name) {
        this.name = name;
    }

    public static SQLType fromName(String name) {
        for(SQLType sqlType : SQLType.values()) {
            if(sqlType.name.equals(name))
                return sqlType;
        }
        return UNKNOWN;
    }
}
