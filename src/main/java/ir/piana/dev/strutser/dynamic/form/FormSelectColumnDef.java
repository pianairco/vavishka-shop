package ir.piana.dev.strutser.dynamic.form;

/**
 * Created by mj.rahmati on 12/14/2019.
 */
public class FormSelectColumnDef {
    String property;
    String title;
//    String titleKey;
    String styleClass;
    boolean sortable;
    String width;
    String forFundType;
    boolean tooltip;

    public FormSelectColumnDef(String property, String title, String styleClass, boolean sortable, String width, String forFundType, boolean tooltip) {
        this.property = property;
        this.title = title;
        this.styleClass = styleClass;
        this.sortable = sortable;
        this.width = width;
        this.forFundType = forFundType;
        this.tooltip = tooltip;
    }

    public String getProperty() {
        return property;
    }

    void setProperty(String property) {
        this.property = property;
    }

    public String getTitle() {
        return title;
    }

    void setTitle(String title) {
        this.title = title;
    }

    public String getStyleClass() {
        return styleClass;
    }

    void setStyleClass(String styleClass) {
        this.styleClass = styleClass;
    }

    public boolean isSortable() {
        return sortable;
    }

    void setSortable(boolean sortable) {
        this.sortable = sortable;
    }

    public String getWidth() {
        return width;
    }

    public void setWidth(String width) {
        this.width = width;
    }

    public String getForFundType() {
        return forFundType;
    }

    public void setForFundType(String forFundType) {
        this.forFundType = forFundType;
    }

    public boolean isTooltip() {
        return tooltip;
    }

    public void setTooltip(boolean tooltip) {
        this.tooltip = tooltip;
    }
}
