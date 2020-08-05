package ir.piana.dev.strutser.rest;

import com.google.api.client.util.Maps;
import ir.piana.dev.strutser.model.ResponseModel;
import ir.piana.dev.strutser.service.storage.AfterSaveImage;
import ir.piana.dev.strutser.service.storage.GroupProperties;
import ir.piana.dev.strutser.service.storage.StorageFileNotFoundException;
import ir.piana.dev.strutser.service.storage.StorageService;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;


@Controller
@RequestMapping("images")
public class FileUploadController {
    @Autowired
    private StorageService storageService;

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/")
    public String listUploadedFiles(Model model) throws IOException {

        model.addAttribute("files", storageService.loadAll().map(
                path -> MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
                        "serveFile", path.getFileName().toString()).build().toUri().toString())
                .collect(Collectors.toList()));

        return "uploadForm";
    }

    @GetMapping("/files/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> serveFile(@PathVariable String filename) {

        Resource file = storageService.loadAsResource(filename);
        return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
                "attachment; filename=\"" + file.   getFilename() + "\"").body(file);
    }

    @PostMapping(value = "/image-upload", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ResponseModel> handleFileUpload(
            HttpServletRequest request,
            @RequestHeader("image_upload_group") String group,
            @RequestParam("file") MultipartFile file,
            RedirectAttributes redirectAttributes) {
        String rotation = request.getHeader("image-upload-rotation");
        String path = storageService.store(file, group, rotation);

        GroupProperties groupProperties = storageService.getGroupProperties(group);
        String afterSaveImageName = groupProperties.getAfterSaveImage();

        if(afterSaveImageName != null && !afterSaveImageName.isEmpty()) {
            AfterSaveImage afterSaveImage = (AfterSaveImage) applicationContext.getBean(afterSaveImageName);
            return afterSaveImage.doWork(request, path);
        }

        Map map = Maps.newHashMap();
        map.put("path", path);

        redirectAttributes.addFlashAttribute("message",
                "You successfully uploaded " + file.getOriginalFilename() + "!");


        return ResponseEntity.ok(ResponseModel.builder().code(0).data(map).build());
    }

    @ExceptionHandler(StorageFileNotFoundException.class)
    public ResponseEntity<?> handleStorageFileNotFound(StorageFileNotFoundException exc) {
        return ResponseEntity.notFound().build();
    }
}
