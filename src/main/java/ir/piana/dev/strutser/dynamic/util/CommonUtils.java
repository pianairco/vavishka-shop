package ir.piana.dev.strutser.dynamic.util;

public class CommonUtils {
    public static boolean isNumber(String s) {
        try {
            Long.parseLong(s);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isNull(String str){
        return (str == null || "".equals(str) || "null".equals(str));
    }

    public static boolean isNull(Object obj){
        if (obj == null)
            return true;
        String str = obj.toString();
        return (str == null || "".equals(str) || "null".equals(str));
    }
}
