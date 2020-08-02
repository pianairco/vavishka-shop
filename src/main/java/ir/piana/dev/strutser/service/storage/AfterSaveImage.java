package ir.piana.dev.strutser.service.storage;

import org.springframework.http.ResponseEntity;

import javax.servlet.http.HttpServletRequest;

public interface AfterSaveImage<T> {
    ResponseEntity<T> doWork(HttpServletRequest request, String path);
}
