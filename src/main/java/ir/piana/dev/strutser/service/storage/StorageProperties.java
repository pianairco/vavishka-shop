package ir.piana.dev.strutser.service.storage;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.Map;

@ConfigurationProperties("storage")
@Getter
@Setter
@NoArgsConstructor
public class StorageProperties {
    /**
     * Folder location for storing files
     */
    private String location = "upload-dir";
    private Map<String, GroupProperties> groups;
}
