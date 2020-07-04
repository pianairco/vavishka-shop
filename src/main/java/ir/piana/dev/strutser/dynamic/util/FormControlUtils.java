package ir.piana.dev.strutser.dynamic.util;

import ir.piana.dev.strutser.dynamic.form.ElementControl;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.RandomStringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;

public class FormControlUtils {
    private static String getValue(String name, HttpServletRequest request, boolean noSession) {
        String value = request.getParameter(name);
        if(value == null)
            value = (String) request.getAttribute(name);
        if(value == null) {
            if (noSession)
                value = "";
            else
                value = request.getSession().getAttribute(name) != null ? request.getSession().getAttribute(name) + "" : "";

        }
        return value;
    }

    public static String getTextHidden(String name, HttpServletRequest request, boolean noSession) {
        String value = getValue(name, request, noSession);
        String input = "<input type='hidden' name='" + name + "' value='" + value + "' />";
        return input;
    }

    public static String getTextHidden(String name, String value) {
        String input = "<input type='hidden' name='" + name + "' value='" + value + "' />";
        return input;
    }

    public static String getSelect(String name,
                                   String selectDefaultItem,
                                   HttpServletRequest request,
                                   boolean noSession,
                                   Map items,
                                   boolean hasNothing,
                                   boolean hasAll,
                                   boolean multiSelect) {
        return getSelect(name, selectDefaultItem, request, noSession, items,hasNothing,hasAll,multiSelect,"","");

    }

    public static String getSelect(String name,
                                   String selectDefaultItem,
                                   HttpServletRequest request,
                                   boolean noSession,
                                   Map items,
                                   boolean hasNothing,
                                   boolean hasAll,
                                   boolean multiSelect,
                                   String width,String height){
        return getSelect(name, selectDefaultItem, request, noSession, items, hasNothing, hasAll, multiSelect, width, height,"");
    }

    public static String getSelect(String name,
                                   String selectDefaultItem,
                                   HttpServletRequest request,
                                   boolean noSession,
                                   Map items,
                                   boolean hasNothing,
                                   boolean hasAll,
                                   boolean multiSelect,
                                   String width,
                                   String height,
                                   String extended) {
        HttpSession session = request.getSession();
        String value = getValue(name, request, noSession);

        StringBuffer select = new StringBuffer();
        if (multiSelect) {
            String textHidden = getTextHidden(name, request, noSession);
            String nameClass = RandomStringUtils.random(32, true, false);
            select.append(textHidden + "\n")
                    .append("<select class='form-control multiple-select-control " + nameClass + "' multiple=\"true\" onchange='multiSelectCommaSeperated(\"" + nameClass + "\", \"" + name + "\")' name=\"").append("multiselect." + name).append("\"");
        } else
            select.append("<select class=\"form-control\" name=\"").append(name).append("\"") ;
        if (!width.equals("")){
            select.append(" STYLE=\"width:" );
            select.append(width );
            select.append(";\"");
        }
        if (!height.equals("")){
            select.append(" STYLE=\"height:" );
            select.append(height);
            select.append(";\"");
        }
        select.append(" " + extended + " ");
        select.append(">");
//        if (hasAll && items.size() > 1)
        select.append("<option value=''>").append(selectDefaultItem != null ? selectDefaultItem : "").append("</option>") ;
//        if (hasNothing)
//            select.append("<option value=''>هیچکدام</option>") ;

        for (Iterator iterator = items.keySet().iterator(); iterator.hasNext();) {
            String propertyValue = (String) iterator.next();
            try {
                String lablePropertyValue = (String) items.get(propertyValue);
                String selected = "";
                if (propertyValue!=null) {
                    if(multiSelect && Arrays.asList(value.split(",")).contains(propertyValue)) {
                        selected = "selected";
                    } else if(propertyValue.equals(value)) {
                        selected = "selected";
                    }
                }
                select. append("<option value=\"").
                        append(propertyValue).
                        append("\" ").
                        append(selected).
                        append(">").
                        append(lablePropertyValue).
                        append("</option>");

            } catch (Exception e) {
            }
        }
        select.append("</select>") ;
        return select.toString() ;
    }

    public static String getInput(String name, HttpServletRequest request, boolean noSession, String size, String Extended, boolean isDisable) {
        String value = getValue(name, request, noSession);
        String disabled = isDisable ? "disabled='true'" : "";
        String input = "<input class=\"form-control\" type='text' name='" + name + "' id='" + name.replace(".", "_") + "' size='" + size + "' value='" + value + "' " + Extended + disabled + " />";
        return input;
    }

    public static String getInput(ElementControl elementControl, HttpServletRequest request, boolean noSession, String prefix) {
        String value = getValue(prefix.concat(elementControl.getName()), request, noSession);
        String disabled = elementControl.isDisabled() ? "disabled='true'" : "";
        StringBuffer input = new StringBuffer("<input class=\"form-control\" name=\"" + prefix.concat(elementControl.getName()) + "\"")
                .append(" id=\"" + prefix.concat(elementControl.getName()).replace(".", "_") + "\" ");
        if(elementControl.getType().equals("date")) {
            input.append("type=\"text\" size=\"10\" maxlength=\"10\" ");
//            if(elementControl.getCopyOnBlur() != null && !elementControl.getCopyOnBlur().isEmpty()) {
//                input.append("onblur=\"setEndDate()\"");
//            }
            input.append("onkeypress=\"return autoMask(this,event,'" + Consts.DATE_MASK_STRING + "');\" ");
//            input.append("onblur=\"setEndDate()\" onkeypress=\"return autoMask(this,event,'" + Consts.DATE_MASK_STRING + "');\" ");
        }
        input.append("value=\"" + value + "\" ");
        input.append(disabled + " />");
        return input.toString();
    }

    public static String getInput(ElementControl elementControl, HttpServletRequest request, boolean noSession) {
        return getInput(elementControl, request, noSession, "");
    }

    public static String getInput(String name, HttpServletRequest request, boolean noSession, String size, boolean disabled) {
        String value = getValue(name, request, noSession);
        String input = "<input class=\"form-control\" type='text' name='" + name +"' size='" + size +  "' value='" + value + "'" ;
        if (disabled)
            input += " disabled='true'" ;
        input += " />";
        return input;
    }

    public static String getTextBox(String name, HttpServletRequest request, boolean noSession, String rows, String cols, boolean disabled) {
        String value = getValue(name, request, noSession);
        String input = "<textarea class=\"form-control\" rows=' " + rows + "' name='" + name +"' cols='" + cols +  "' ";
        if (disabled)
            input += " disabled='true'" ;
        input += " >" + value + "</textarea>";
        return input;
    }

    public static String getCheckBox(String name, HttpServletRequest request, boolean noSession, boolean disabled) {
        String value = getValue(name, request, noSession);
        String textHidden = null;
        if(value == null || value.isEmpty()) {
            value = "0";
            textHidden = getTextHidden(name, value);
        } else {
            textHidden = getTextHidden(name, request, noSession);
        }
        String checked = CommonUtils.isNull(value) || !"1".equals(value) ? "" : "checked";
        String checkName = "checkbox.".concat(name);
        String input = "<input class=\"form-control\" type='checkbox' name='" + checkName + "' value='1' onclick='checkboxClicked(\"" + name + "\")' " + checked;
        if (disabled)
            input += " disabled='true'" ;
        input += " />";
        return textHidden.concat("\n").concat(input);
    }

    public static String getCheckBox(ElementControl elementControl, HttpServletRequest request, boolean noSession) {
        return getCheckBox(elementControl, request, noSession, "");
    }

    public static String getCheckBox(ElementControl elementControl, HttpServletRequest request, boolean noSession, String prefix) {
        String value = getValue(prefix.concat(elementControl.getName()), request, noSession);
        String textHidden = null;
        String checked = "";
        if(!CommonUtils.isNull(value) && "1".equals(value)) {
            checked = "checked";
            value = "1";
        } else if(!CommonUtils.isNull(value) && "0".equals(value)) {
            value = "0";
        }
        else if(!CommonUtils.isNull(elementControl.getDefaultValue()) && elementControl.getDefaultValue().equals("checked")) {
            checked = "checked";
            value = "1";
        } else {
            value = "0";
        }
        textHidden = getTextHidden(prefix.concat(elementControl.getName()), value);
//        if(value == null || value.isEmpty()) {
//            value = "0";
//            textHidden = getTextHidden(elementControl.getName(), value);
//        } else {
//            textHidden = getTextHidden(elementControl.getName(), request, noSession);
//        }
        String checkName = "checkbox.".concat(prefix.concat(elementControl.getName()));
        String input = "<input class=\"form-control\" type='checkbox' name='" + checkName + "' value='1' onclick='checkboxClicked(\"" + prefix.concat(elementControl.getName()) + "\")' " + checked;
        if (elementControl.isDisabled())
            input += " disabled='true'" ;
        input += " />";
        return textHidden.concat("\n").concat(input);
    }

    public static String getStyle(String name) {
        if(name == null || name.isEmpty())
            return "";
        else {
            InputStream resourceAsStream = FormControlUtils.class.getResourceAsStream("/theme/".concat(name).concat(".css"));
            StringWriter writer = new StringWriter();
            try {
                IOUtils.copy(resourceAsStream, writer, StandardCharsets.UTF_8.name());
                String themeString = writer.toString();
                return "<style rel=\"stylesheet\">\n" + themeString + "</style>";
//                return "<link rel=\"stylesheet\" href=\"sql/theme-a.css\">";
            } catch (IOException e) {
//                log.error(e.getMessage());
                return "";
            }
        }
    }
}
