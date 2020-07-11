package ir.piana.dev.strutser.cfg;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

import java.util.List;

@Configuration
public class WebConfiguration extends WebMvcConfigurationSupport {

    @Autowired
    private StaticResourceProperties staticResourceProperties;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        staticResourceProperties.getPaths().forEach((k, v) -> {
            registry.addResourceHandler(k)
                    .addResourceLocations(v.toArray(new String[0]));
//                    .addResourceLocations("classpath:/static/", "file:///c:/upload-dir/");
        });
    }
}
