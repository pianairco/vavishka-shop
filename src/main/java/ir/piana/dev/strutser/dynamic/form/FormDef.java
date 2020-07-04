package ir.piana.dev.strutser.dynamic.form;

import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 * Created by mj.rahmati on 12/28/2019.
 */
public abstract class FormDef {
    String name;
    String parameterPrefix;
    List<String> permissions;
    String queryName;
    String theme;
    String title;
    Properties properties;
    List<ElementInitialSelect> selects;
    int controlInRow;
    List<ElementControl> controls;
    List<ElementButton> buttons;
    List<PrintButton> printButtons;
    List<ElementInRowButton> inRowButtons;
    Map<String, ElementInRowButton> inRowButtonMap;
    Map<String, ElementActivity> activityMap;
    List<ElementActivity> activities;

    public String getName() {
        return name;
    }

    public String getParameterPrefix() {
        return parameterPrefix;
    }

    public String getQueryName() {
        return queryName;
    }

    public String getTheme() {
        return theme;
    }

    public String getTitle(){
        return title;
    }


    public Properties getProperties() {
        return properties;
    }

    public String getPropertyValue(String key) {
        return properties != null ? (properties.containsKey(key) ? properties.getProperty(key) : key) : key;
    }

    public List<String> getPermissions() {
        return permissions;
    }

    public List<ElementInitialSelect> getInitialSelects(){
        return selects;
    }

    public int getControlInRow(){
        return controlInRow;
    }

    public List<ElementControl> getControls(){
        return controls;
    }

    public List<ElementButton> getButtons(){
        return buttons;
    }

    public List<PrintButton> getPrintButtons(){
        return printButtons;
    }

    public List<ElementActivity> getActivities() {
        return activities;
    }

    public Map<String, ElementActivity> getActivityMap() {
        return activityMap;
    }

    public List<ElementInRowButton> getInRowButtons() {
        return inRowButtons;
    }

    public Map<String, ElementInRowButton> getInRowButtonMap() {
        return inRowButtonMap;
    }
}
