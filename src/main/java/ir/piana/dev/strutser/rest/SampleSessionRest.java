package ir.piana.dev.strutser.rest;

import com.fasterxml.jackson.databind.ObjectMapper;
import ir.piana.dev.strutser.service.sql.SqlService;
import ir.piana.dev.strutser.service.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RestController
public class SampleSessionRest {
    @Autowired
    private StorageService storageService;

    @Autowired
    private SqlService sqlService;

    @Autowired
    private ObjectMapper mapper;

    @PostMapping(path = "sample/session/add", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @Transactional
    public ResponseEntity addSession(
            @RequestBody Map<String, Object> sampleItem,
            @RequestHeader("file-group") String group){
        String iconSrc = storageService.store((String) sampleItem.get("icon"), group);
//        sqlService.update(group,
//                new Object[]{sampleItem.get("title"), sampleItem.get("description"), imageSrc});
        long id = sqlService.insert(group, "vavishka_seq",
                new Object[]{sampleItem.get("samples_id"), sampleItem.get("title"),
                        sampleItem.get("description"),
                        iconSrc, sampleItem.get("orders")});
        Map map = new LinkedHashMap();
        map.put("id", id);
        map.put("samples_id", sampleItem.get("samples_id"));
        map.put("title", (String)sampleItem.get("title"));
        map.put("description", (String)sampleItem.get("description"));
        map.put("orders", sampleItem.get("orders"));
        map.put("iconSrc", iconSrc);
        return ResponseEntity.ok(map);
    }

    @PostMapping(path = "sample/session/edit", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @Transactional
    public ResponseEntity editItem(
            @RequestBody Map<String, Object> sampleItem,
            @RequestHeader("file-group") String group){
        String imageSrc = null;
        if(sampleItem.get("image") != null) {
            imageSrc = storageService.store((String) sampleItem.get("image"), group);
        } else {
            imageSrc = (String)sampleItem.get("imageSrc");
        }

        sqlService.update(group,
                new Object[]{sampleItem.get("title"), sampleItem.get("description"), imageSrc, sampleItem.get("id")});
        Map map = new LinkedHashMap();
        map.put("id", sampleItem.get("id"));
        map.put("title", (String)sampleItem.get("title"));
        map.put("description", (String)sampleItem.get("description"));
        map.put("imageSrc", imageSrc);
        return ResponseEntity.ok(map);
    }

    @PostMapping(path = "sample/session/delete", consumes = MediaType.APPLICATION_JSON_VALUE,
                produces = MediaType.APPLICATION_JSON_VALUE)
    @Transactional
    public ResponseEntity deleteItem(
            @RequestBody Map<String, Object> sampleItem,
            @RequestHeader("file-group") String group) {
        sqlService.delete(group, new Object[]{sampleItem.get("id")});
        return ResponseEntity.ok().build();
    }

    @PostMapping(path = "sample/session/image/add", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @Transactional
    public ResponseEntity addSessionImage(
            @RequestBody Map<String, Object> sampleItem,
            @RequestHeader("file-group") String group){
        String iconSrc = storageService.store((String) sampleItem.get("icon"), group);
//        sqlService.update(group,
//                new Object[]{sampleItem.get("title"), sampleItem.get("description"), imageSrc});
        long id = sqlService.insert(group, "vavishka_seq",
                new Object[]{sampleItem.get("samples_id"), sampleItem.get("title"),
                        sampleItem.get("description"),
                        iconSrc, sampleItem.get("orders")});
        Map map = new LinkedHashMap();
        map.put("id", id);
        map.put("samples_id", sampleItem.get("samples_id"));
        map.put("title", (String)sampleItem.get("title"));
        map.put("description", (String)sampleItem.get("description"));
        map.put("orders", sampleItem.get("orders"));
        map.put("iconSrc", iconSrc);
        return ResponseEntity.ok(map);
    }

    @PostMapping(path = "sample/session/images", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    @Transactional
    public ResponseEntity getSessionImages(@RequestBody Map<String, Object> sampleItem) {
        List<Map<String, Object>> mapList = sqlService.listByName("get-session-images",
                new Object[]{sampleItem.get("id")});
        SortedMap<String, Map<String, Object>> map  = new TreeMap<>();
        for (Map m : mapList) {
            map.put(m.get("ID").toString(), m);
        }
        return ResponseEntity.ok(map);
    }
}
