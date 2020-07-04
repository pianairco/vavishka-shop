package ir.piana.dev.strutser.dynamic.form;

import ir.piana.dev.strutser.dynamic.sql.SQLParamDef;
import ir.piana.dev.strutser.dynamic.sql.SelectDef;

import java.util.*;

/**
 * Created by mj.rahmati on 12/14/2019.
 */
public class FooterDef {
    private final String caption;
    int order;
    Map<String, String> columnMap;

    public FooterDef(String caption, int order, Map<String, String> columnMap) {
        this.caption = caption;
        this.order = order;
        this.columnMap = columnMap;
    }

    public String getCaption() {
        return caption;
    }

    public int getOrder() {
        return order;
    }

    public Map<String, String> getFooterColumnDefMap() {
        return Collections.unmodifiableMap(columnMap);
    }
}
