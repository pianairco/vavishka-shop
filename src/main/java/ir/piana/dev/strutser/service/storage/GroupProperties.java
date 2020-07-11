package ir.piana.dev.strutser.service.storage;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GroupProperties {
    private String folder;
    private String sql;
}
