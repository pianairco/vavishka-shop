package ir.piana.dev.strutser.rest;

import ir.piana.dev.strutser.service.sql.SqlService;
import ir.piana.dev.strutser.service.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class SampleItemRest {
    @Autowired
    private StorageService storageService;

    @Autowired
    private SqlService sqlService;

    @PostMapping(path = "sample/add", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity addItem(@RequestBody Map<String, Object> sampleItem, @RequestHeader("file-group") String group) {
        String imageSrc = storageService.store((String) sampleItem.get("image"), group);
        sqlService.update(group,
                new Object[]{sampleItem.get("title"), sampleItem.get("description"), imageSrc});
        return ResponseEntity.ok().build();
    }
}
