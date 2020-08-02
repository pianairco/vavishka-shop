package ir.piana.dev.strutser.util;

import java.util.Arrays;
import java.util.stream.Collectors;

public class JspUtil {
    public static String getStore(String storeName) {
        StringBuffer sb = new StringBuffer();
        sb.append("var " + ((storeName == null || storeName.isEmpty()) ? "store" : storeName) + "={\n" +
                "        state:{forms: Object},\n" +
                "        setToForm: function(formName, propertyName, property) {\n" +
                "            let obj = Object.assign({}, this.state.forms[formName]);\n" +
                "            obj[propertyName] = property;\n" +
                "            this.state.forms[formName] = obj;\n" +
                "        },\n" +
                "        getFromForm: function(formName, propertyName) {\n" +
                "            return this.state.forms[formName][propertyName];\n" +
                "        }\n" +
                "    };");
        return Arrays.stream(sb.toString().split("\n")).map(String::trim)
                .collect(Collectors.joining());
    }

    public static String getStore(String storeName, String... forms) {
        StringBuffer sb = new StringBuffer();
        sb.append("var " + ((storeName == null || storeName.isEmpty()) ? "store" : storeName) + "={\n" +
                "        state:{forms: {");
                if(forms.length > 0) {
                    for (String form : forms)
                        sb.append(form).append(": {},");
                    sb.deleteCharAt(sb.length() - 1);
                }
                sb.append("}},\n" +
                "        setToForm: function(formName, propertyName, property) {\n" +
                "            let obj = Object.assign({}, this.state.forms[formName]);\n" +
                "            obj[propertyName] = property;\n" +
                "            this.state.forms[formName] = obj;\n" +
                "        },\n" +
                "        getFromForm: function(formName, propertyName) {\n" +
                "            return this.state.forms[formName][propertyName];\n" +
                "        },\n" +
                "        setToFormProperty: function(formName, propertyName, key, value) {\n" +
                "            this.state.forms[formName][propertyName][key] = value;\n" +
                "        }\n" +
                "    };");
        return Arrays.stream(sb.toString().split("\n")).map(String::trim)
                .collect(Collectors.joining());
    }
}
