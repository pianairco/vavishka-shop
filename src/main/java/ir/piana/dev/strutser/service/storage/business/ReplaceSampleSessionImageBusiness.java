package ir.piana.dev.strutser.service.storage.business;

import ir.piana.dev.strutser.service.sql.SqlService;
import ir.piana.dev.strutser.service.storage.AfterSaveImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.Map;

@Component("replaceSampleSessionImageBusiness")
public class ReplaceSampleSessionImageBusiness implements AfterSaveImage {
    @Autowired
    private SqlService sqlService;

    @Override
    public ResponseEntity doWork(HttpServletRequest request, String path) {
        Object id = getValueObject(request.getHeader("id"));

        sqlService.updateByQueryName("replace-session-image",
                new Object[]{path, id});
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("id", id);
        map.put("image_src", path);
        return ResponseEntity.ok(map);
    }
}
