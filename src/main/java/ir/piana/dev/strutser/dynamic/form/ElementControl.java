package ir.piana.dev.strutser.dynamic.form;

/**
 * Created by mj.rahmati on 12/26/2019.
 */
public class ElementControl {
    String name;
    String title;
    boolean disabled;
    boolean required;
    String type;
    String defaultValue;
    String items;
    String queryName;
    String optionValue;
    String optionTitle;
    String searchBox;
    String selectDefaultItem;
    String copyOnBlur;
    String forFundType;

    public ElementControl(String name, String title, boolean disabled, boolean required, String type, String items,
                          String queryName, String optionValue, String optionTitle, String defaultValue,
                          String searchBox, String selectDefaultItem, String copyOnBlur, String forFundType) {
        this.name = name;
        this.title = title;
        this.disabled = disabled;
        this.required = required;
        this.type = type;
        this.items = items;
        this.queryName = queryName;
        this.optionValue = optionValue;
        this.optionTitle = optionTitle;
        this.defaultValue = defaultValue;
        this.searchBox = searchBox;
        this.selectDefaultItem = selectDefaultItem;
        this.copyOnBlur = copyOnBlur;
        this.forFundType = forFundType;
        if(this.forFundType == null)
            this.forFundType = "";
    }

    public String getName() {
        return name;
    }

    public String getTitle() {
        return title;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public boolean isDisabled() {
        return disabled;
    }

    public boolean isRequired() {
        return required;
    }

    public String getType() {
        return type;
    }

    public String getItems() {
        return items;
    }

    public String getQueryName() {
        return queryName;
    }

    public String getOptionValue() {
        return optionValue;
    }

    public String getOptionTitle() {
        return optionTitle;
    }

    public String getSearchBox() {
        return searchBox;
    }

    public String getSelectDefaultItem() {
        return selectDefaultItem;
    }

    public String getCopyOnBlur() {
        return copyOnBlur;
    }

    public String getForFundType() {
        return forFundType;
    }
}
