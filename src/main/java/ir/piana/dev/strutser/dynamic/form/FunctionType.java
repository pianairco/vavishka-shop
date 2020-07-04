package ir.piana.dev.strutser.dynamic.form;

import java.math.BigDecimal;
import java.util.function.BiFunction;

public enum FunctionType {
    SUM("sum", (Object a, Object b) -> ((BigDecimal)a).add((BigDecimal)b)),
    DIFF("diff", (Object a, Object b) -> SUM.function.apply(a, b));

    private String name;
    private BiFunction function;

    FunctionType(String name, BiFunction function) {
        this.name = name;
        this.function = function;
    }

    public static BiFunction fromName(String name) {
        for (FunctionType functionType : FunctionType.values()) {
            if (functionType.name.equals(name))
                return functionType.function;
        }
        throw new RuntimeException("not exist!");
    }

    public static FunctionType typeFromName(String name) {
        for (FunctionType functionType : FunctionType.values()) {
            if (functionType.name.equals(name))
                return functionType;
        }
        throw new RuntimeException("not exist!");
    }
}
