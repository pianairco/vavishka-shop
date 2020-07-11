package ir.piana.dev.strutser;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

//@Configuration
public class WebConfiguration /*extends WebMvcConfigurationSupport*/ {
//    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/upload-dir/**")
//                .addResourceLocations("file:/c:/upload-dir/");
        registry.addResourceHandler("/**")
                .addResourceLocations("/static", "file:/c:/upload-dir/");

    }
}
