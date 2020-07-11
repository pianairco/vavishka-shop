package ir.piana.dev.strutser.rest.image;

import ir.piana.dev.strutser.model.ResponseModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
public class ImageLoaderController {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private ImageLoaderProperties imageLoaderProperties;

    @GetMapping(path = "/image-loader", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ResponseModel> getImages(@RequestHeader("image_loader_group") String group) {
        List<Map<String, Object>> maps = jdbcTemplate.queryForList(imageLoaderProperties.getGroups().get(group));
        return ResponseEntity.ok(ResponseModel.builder().code(0).data(maps).build());
    }
}
