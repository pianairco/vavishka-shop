package ir.piana.dev.strutser.rest;

import ir.piana.dev.strutser.model.ResponseModel;
import ir.piana.dev.strutser.service.storage.StorageFileNotFoundException;
import ir.piana.dev.strutser.service.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;


@Controller
@RequestMapping("images")
public class FileUploadController {
    @Autowired
    private StorageService storageService;

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
        List<Object> objects = Arrays.asList(new Object[10]);
        Enumeration<String> headerNames = request.getHeaderNames();
        int max = 0;
        while (headerNames.hasMoreElements()) {
            String key = headerNames.nextElement();
            if(key.startsWith("image_upload_param_")) {
                Integer order = Integer.parseInt(key.substring(19));
                max = order > max ? order : max;
                String header = request.getHeader(key);
                if(header.startsWith("i:")) {
                    objects.set(order - 1, Integer.parseInt(header.substring(2)));
                } else if(header.startsWith("l:")) {
                    objects.set(order - 1, Long.parseLong(header.substring(2)));
                } else if(header.startsWith("f:")) {
                    objects.set(order - 1, Float.parseFloat(header.substring(2)));
                } else if(header.startsWith("d:")) {
                    objects.set(order - 1, Double.parseDouble(header.substring(2)));
                } else if(header.startsWith("b:")) {
                    objects.set(order - 1, Boolean.valueOf(header.substring(2)));
                } else {
                    objects.set(order - 1, header);
                }

            }
        }
        storageService.store(file, group, objects.subList(0, max).toArray());
        redirectAttributes.addFlashAttribute("message",
                "You successfully uploaded " + file.getOriginalFilename() + "!");

        return ResponseEntity.ok(ResponseModel.builder().code(0).data("success").build());
    }

    @ExceptionHandler(StorageFileNotFoundException.class)
    public ResponseEntity<?> handleStorageFileNotFound(StorageFileNotFoundException exc) {
        return ResponseEntity.notFound().build();
    }
}
