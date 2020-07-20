package ir.piana.dev.strutser.service.sql;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.Map;

@ConfigurationProperties("sql")
@Getter
@Setter
@NoArgsConstructor
public class SqlProperties {
    /**
     * Folder location for storing files
     */
    private Map<String, SqlGroupProperties> groups;
}
