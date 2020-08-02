package ir.piana.dev.strutser.service.storage.business;

import ir.piana.dev.strutser.service.sql.SqlService;
import ir.piana.dev.strutser.service.storage.AfterSaveImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Component("sampleSessionImageBusiness")
public class SampleSessionImageBusiness implements AfterSaveImage {
    @Autowired
    private SqlService sqlService;

    @Override
    public ResponseEntity doWork(HttpServletRequest request, String path) {
        Object sessionId = getValueObject(request.getHeader("sessionId"));
        Object orders = getValueObject(request.getHeader("orders"));

        sqlService.insertByQueryName("insert-session-image", "vavishka_seq",
                new Object[]{ path, sessionId, orders });
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("sessionId", sessionId);
        map.put("orders", orders);
        map.put("imageScr", path);
        return ResponseEntity.ok(map);
    }

    Object getValueObject(String val) {
        if(val.startsWith("i:")) {
            return Integer.parseInt(val.substring(2));
        } else if(val.startsWith("l:")) {
            return Long.parseLong(val.substring(2));
        } else if(val.startsWith("f:")) {
            return Float.parseFloat(val.substring(2));
        } else if(val.startsWith("d:")) {
            return Double.parseDouble(val.substring(2));
        } else if(val.startsWith("b:")) {
            return Boolean.valueOf(val.substring(2));
        } else {
            return val;
        }
    }
}
