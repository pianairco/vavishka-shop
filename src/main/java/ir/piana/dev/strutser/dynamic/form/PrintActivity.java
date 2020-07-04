package ir.piana.dev.strutser.dynamic.form;

import ir.piana.dev.strutser.dynamic.sql.SQLExecuter;

import javax.servlet.http.HttpServletRequest;
import java.sql.Statement;

public interface PrintActivity {
    String print(SQLExecuter sqlExecuter, Statement statement, HttpServletRequest request);
}
