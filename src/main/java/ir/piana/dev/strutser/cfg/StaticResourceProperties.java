package ir.piana.dev.strutser.cfg;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.List;
import java.util.Map;

@ConfigurationProperties("static-resource")
@Getter
@Setter
@NoArgsConstructor
public class StaticResourceProperties {
    private Map<String, List<String>> paths;
}
