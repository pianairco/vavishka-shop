package ir.piana.dev.strutser.cfg;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

import java.util.List;

@Configuration
public class WebConfiguration extends WebMvcConfigurationSupport {
    @Autowired
    private ObjectMapper objectMapper;

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

    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {

        MappingJackson2HttpMessageConverter jacksonMessageConverter = new MappingJackson2HttpMessageConverter();
        jacksonMessageConverter.setObjectMapper(objectMapper);
//        ObjectMapper objectMapper = jacksonMessageConverter.getObjectMapper();
//        objectMapper.registerModule(new JodaModule());
//        objectMapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, true);
        converters.add(jacksonMessageConverter);
    }
}
