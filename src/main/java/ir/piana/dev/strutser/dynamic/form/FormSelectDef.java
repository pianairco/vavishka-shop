package ir.piana.dev.strutser.dynamic.form;

import ir.piana.dev.strutser.dynamic.sql.SQLParamDef;
import ir.piana.dev.strutser.dynamic.sql.SelectDef;

import java.util.*;

/**
 * Created by mj.rahmati on 12/14/2019.
 */
public class FormSelectDef extends FormDef {
    SelectDef selectDef;
    String decorator;
    String tableActivity;
    boolean separateTab;
    String sortProperty;
    String sortOrder;
    String actionURL;
    String actionMethod;
    String rowPerPage;
    List<String> searchParams;
    List<SQLParamDef> searchSQLParamDefs;
    Map<String, FormSelectColumnDef> formSelectColumnDefMap;
    List<FormSelectColumnDef> formSelectColumnDefs;
    List<FooterDef> footerDefs;

    public FormSelectDef() {
    }

    public FormSelectDef(String queryName) {
        this.queryName = queryName;
    }

    public FormSelectDef(SelectDef selectDef) {
        this.queryName = selectDef.getName();
        this.selectDef = selectDef;
    }

    public String getDecorator() {
        return decorator;
    }

    public String getTableActivity() {
        return tableActivity;
    }

    public boolean isSeparateTab() {
        return separateTab;
    }

    public Map<String, FormSelectColumnDef> getFormSelectColumnDefMap() {
        return Collections.unmodifiableMap(formSelectColumnDefMap);
    }

    public List<FormSelectColumnDef> getFormSelectColumnDefs() {
        return Collections.unmodifiableList(formSelectColumnDefs);
    }

    public List<FooterDef> getFooterDefs() {
        return Collections.unmodifiableList(footerDefs);
    }

    public String getSortProperty() {
        return this.selectDef.getParamMap().get(sortProperty).getKey();
    }

    public String getSortOrder() {
        return this.selectDef.getParamMap().get(sortOrder).getKey();
    }

    public String getActionURL() {
        return actionURL;
    }

    public String getActionMethod() {
        return actionMethod;
    }

    public String getRowPerPage() {
        return this.selectDef.getParamMap().get(rowPerPage).getKey();
    }

    public List<SQLParamDef> getSearchParams() {
        if(searchSQLParamDefs == null) {
            List<SQLParamDef> searchParams = new ArrayList<>();
            for (String searchParam : this.searchParams) {
                if (selectDef.getParamMap().containsKey(searchParam))
                    searchParams.add(selectDef.getParamMap().get(searchParam));
            }
            searchSQLParamDefs = Collections.unmodifiableList(searchParams);
        }
        return searchSQLParamDefs;
    }
}
