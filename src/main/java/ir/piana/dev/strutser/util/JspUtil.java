package ir.piana.dev.strutser.util;

import java.util.Arrays;
import java.util.stream.Collectors;

public class JspUtil {
    public static String getStore(String storeName) {
        StringBuffer sb = new StringBuffer();
        sb.append("var " + ((storeName == null || storeName.isEmpty()) ? "store" : storeName) + "={\n" +
                "        state:{forms: Object},\n" +
                "        setToForms: function(formName, propertyName, property) {\n" +
                "            let obj = Object.assign({}, this.state.forms[formName]);\n" +
                "            obj[propertyName] = property;\n" +
                "            this.state.forms[formName] = obj;\n" +
                "        }\n" +
                "    }");
        return Arrays.stream(sb.toString().split("\n")).map(String::trim)
                .collect(Collectors.joining());
    }
}
