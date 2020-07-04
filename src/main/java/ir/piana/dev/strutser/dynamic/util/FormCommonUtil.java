package ir.piana.dev.strutser.dynamic.util;

import com.google.common.base.CaseFormat;
import ir.piana.dev.strutser.dynamic.form.FooterDef;
import ir.piana.dev.strutser.dynamic.form.FormSelectDef;
import ir.piana.dev.strutser.dynamic.form.FunctionType;
import ir.piana.dev.strutser.dynamic.sql.SQLModelManager;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.BiFunction;
import java.util.stream.Collectors;

public class FormCommonUtil {
    public static Map<String, BigDecimal> evalFooter(Object listObj, FooterDef footerDef) {
        List<Map<String, BigDecimal>> list = (List<Map<String, BigDecimal>>) listObj;
        Map<String, BigDecimal> resultMap = new LinkedHashMap<>();
        list.forEach(map -> {
            footerDef.getFooterColumnDefMap().keySet().forEach(key -> {
                String functionName = footerDef.getFooterColumnDefMap().get(key);
                if(footerDef.getFooterColumnDefMap().get(key).contains("("))
                    functionName = functionName.substring(0, footerDef.getFooterColumnDefMap().get(key).indexOf("("));
                FunctionType functionType = FunctionType.typeFromName(functionName);
                BiFunction biFunction = FunctionType.fromName(functionName);
                if(resultMap.containsKey(key)) {
                    if(functionType == FunctionType.DIFF) {
                        List<String> attrs = Arrays.asList(footerDef.getFooterColumnDefMap().get(key)
                                .substring(footerDef.getFooterColumnDefMap().get(key).indexOf("(") + 1,
                                        footerDef.getFooterColumnDefMap().get(key).indexOf(")")).split(",")).stream()
                                .map(String::trim).map(k -> CaseFormat.LOWER_CAMEL.to(CaseFormat.UPPER_UNDERSCORE, k))
                                .collect(Collectors.toList());
                        resultMap.replace(key, (BigDecimal) biFunction.apply(resultMap.get(key),
                                map.get(attrs.get(0)).subtract(map.get(attrs.get(1)))));
                    } else {
                        resultMap.replace(key, (BigDecimal) biFunction.apply(resultMap.get(key),
                                map.get(CaseFormat.LOWER_CAMEL.to(CaseFormat.UPPER_UNDERSCORE, key))));
                    }
                } else {
                    if(functionType == FunctionType.DIFF) {
                        List<String> attrs = Arrays.asList(footerDef.getFooterColumnDefMap().get(key)
                                .substring(footerDef.getFooterColumnDefMap().get(key).indexOf("(") + 1,
                                        footerDef.getFooterColumnDefMap().get(key).indexOf(")")).split(",")).stream()
                                .map(String::trim).map(k -> CaseFormat.LOWER_CAMEL.to(CaseFormat.UPPER_UNDERSCORE, k))
                                .collect(Collectors.toList());
                        resultMap.put(key, (BigDecimal) biFunction.apply(new BigDecimal(0),
                                map.get(attrs.get(0)).subtract(map.get(attrs.get(1)))));
                    } else {
                        resultMap.put(key, (BigDecimal) biFunction.apply(new BigDecimal(0),
                                map.get(CaseFormat.LOWER_CAMEL.to(CaseFormat.UPPER_UNDERSCORE, key))));
                    }
                }
            });
        });
        return resultMap;
    }

    public static Map<String, String> createFooter(FormSelectDef formDef, FooterDef footerDef, String forFundType){
        Map<String, String> spans = new LinkedHashMap<>();
        int colSpan = 0;
        boolean isCaption = true;
        for(String key : formDef.getFormSelectColumnDefMap().keySet()) {
            if(!footerDef.getFooterColumnDefMap().containsKey(key)) {
                if (formDef.getFormSelectColumnDefMap().get(key).getForFundType() == null ||
                        (formDef.getFormSelectColumnDefMap().get(key).getForFundType() != null &&
                                formDef.getFormSelectColumnDefMap().get(key).getForFundType().equalsIgnoreCase(forFundType)))
                colSpan++;
            } else {
                if(isCaption) {
                    spans.put(key.concat(":").concat(String.valueOf(colSpan)),
                            "@".concat(footerDef.getCaption()));
                    isCaption = false;
                }
                spans.put(key.concat(":").concat(String.valueOf(1)), key);
                colSpan = 0;
            }
        }
        if(colSpan > 0)
            spans.put("final".concat(":").concat(String.valueOf(colSpan)), null);
        return spans;
    }

    public static Map<Object,List<Object>> fork(List<Map<String, Object>> mapList, String groupOn) {
        if(mapList == null)
            return new LinkedHashMap<>();
        Map<Object,List<Object>> collect = mapList.stream().collect(Collectors.groupingBy(map -> ((Map)map).get(groupOn)));
        return collect;
    }

    public static String createSourceFlowAsTree(SQLModelManager.SourceFlow sourceFlow, boolean isHead) {
        StringBuffer sb = new StringBuffer();
        if(isHead) {
            sb.append("<ul class=\"mb-1 pl-3 pb-2\" style=\"text-align: left\">\n");
        }
        sb.append("<li>\n");

        if(sourceFlow.subSources != null && !sourceFlow.subSources.isEmpty()) {
            sb.append("<i class=\"fas fa-angle-right rotate\"></i>");
            String url = "sqlViewer.do?method=sqlView&sql=" + sourceFlow.name + "&type=select";
            sb.append("<span style='padding-left: 10px; color: red;'>" + "<a style='background-color: inherit; padding-left: 0px !important;' href='" + url + "'>" + sourceFlow.name + "</a>" + "</span>\n");
            sb.append("<ul class=\"nested\">\n");
            for(SQLModelManager.SourceFlow subSourceFlow : sourceFlow.subSources)
                sb.append(createSourceFlowAsTree(subSourceFlow, false));
            sb.append("</ul>\n");
        } else {
            sb.append("<li>" + sourceFlow.name + "</li>");
        }

        sb.append("</li>");
        if(isHead) {
            sb.append("</ul>\n");
        }
        return sb.toString();
    }

    public static String createSourceParents(List<String> sourceParents) {
        StringBuffer sb = new StringBuffer();
        if(sourceParents != null && !sourceParents.isEmpty()) {
            String url = "sqlViewer.do?method=sqlView&type=select&sql=";
            for(String parent : sourceParents)
                sb.append("<a type=\"button\" class=\"badge badge-pill badge-success\" style=\"margin:0px 4px;\" href=\"" + url.concat(parent) + "\">" + parent + "</a>");
        }
        return sb.toString();
    }
}
