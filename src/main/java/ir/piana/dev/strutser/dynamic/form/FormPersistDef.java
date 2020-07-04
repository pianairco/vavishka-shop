package ir.piana.dev.strutser.dynamic.form;

/**
 * Created by mj.rahmati on 12/4/2019.
 */
public class FormPersistDef extends FormDef {
    String queryUpdateName;
    String queryInsertName;

    public FormPersistDef() {
    }

    public String getQueryUpdateName() {
        return queryUpdateName;
    }

    public String getQueryInsertName() {
        return queryInsertName;
    }
}
