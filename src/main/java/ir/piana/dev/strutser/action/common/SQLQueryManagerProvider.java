package ir.piana.dev.strutser.action.common;

import ir.piana.dev.strutser.dynamic.sql.SQLModelManager;
import ir.piana.dev.strutser.dynamic.sql.SQLQueryManager;

import java.io.InputStream;

public class SQLQueryManagerProvider {
    private String[] jsonResources;
    private SQLQueryManager sqlQueryManager;
    private boolean debug;

    public void setJsonResources(String[] jsonResources) {
        this.jsonResources = jsonResources;
    }

    public void setDebug(boolean debug) {
        this.debug = debug;
    }

    public void init() throws Exception {
        sqlQueryManager = loadSQLQueryManager(jsonResources);
    }

    public SQLQueryManager loadSQLQueryManager(String[] jsonResources) throws Exception {
        InputStream[] inputStreams = new InputStream[jsonResources.length];
        for (int i = 0; i < jsonResources.length; i++) {
            inputStreams[i] = SQLQueryManagerProvider.class.getResourceAsStream(jsonResources[i]);
        }
        return SQLQueryManager.createSQLQueryManager(SQLModelManager.getNewInstance(inputStreams), debug);
    }

    public SQLQueryManager getSqlQueryManager() {
        if(debug) {
            try {
                return loadSQLQueryManager(jsonResources);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return sqlQueryManager;
    }
}
