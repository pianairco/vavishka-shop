package ir.piana.dev.strutser.service.storage.business;

import ir.piana.dev.strutser.service.sql.SqlService;
import ir.piana.dev.strutser.service.storage.AfterSaveImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Component("insertSampleSessionImageBusiness")
public class InsertSampleSessionImageBusiness implements AfterSaveImage {
    @Autowired
    private SqlService sqlService;

    @Override
    public ResponseEntity doWork(HttpServletRequest request, String path) {
        Object sessionId = getValueObject(request.getHeader("sessionId"));
        Object orders = getValueObject(request.getHeader("orders"));

        long id = insert(path, sessionId, orders);
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("id", id);
        map.put("session_id", sessionId);
        map.put("orders", orders);
        map.put("image_src", path);
        return ResponseEntity.ok(map);
    }

    public long insert(String path, Object sessionId, Object orders) {
        long id = sqlService.insertByQueryName("insert-session-image", "vavishka_seq",
                new Object[]{path, sessionId, orders});
        return id;
    }
}
