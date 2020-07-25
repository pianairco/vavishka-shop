package ir.piana.dev.strutser;

import com.fasterxml.jackson.core.Version;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;
import ir.piana.dev.strutser.action.common.FormManagerProvider;
import ir.piana.dev.strutser.action.common.SQLQueryManagerProvider;
import ir.piana.dev.strutser.cfg.StaticResourceProperties;
import ir.piana.dev.strutser.rest.image.ImageLoaderProperties;
import ir.piana.dev.strutser.service.sql.SqlProperties;
import ir.piana.dev.strutser.service.storage.StorageProperties;
import ir.piana.dev.strutser.service.storage.StorageService;
import ir.piana.dev.strutser.util.LowerCaseKeyDeserializer;
import ir.piana.dev.strutser.util.LowerCaseKeySerializer;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication(scanBasePackages = {
		"ir.piana.dev.strutser",
		"org.apache.struts.action",
})
//@ImportResource("classpath:applicationContext.xml")
@ServletComponentScan("org.apache.struts.action")
@EnableTransactionManagement
@EnableCaching
@EnableConfigurationProperties({
		StorageProperties.class,
		SqlProperties.class,
		ImageLoaderProperties.class,
		StaticResourceProperties.class
})
public class StrutserApplication /*implements CommandLineRunner*/ {
	@Bean("objectMapper")
	public ObjectMapper getObjectMapper() {
		ObjectMapper objectMapper = new ObjectMapper();
		SimpleModule module = new SimpleModule("LowerCaseKeyDeserializer",
				new Version(1,0,0,null));
		module.addKeyDeserializer(Object.class, new LowerCaseKeyDeserializer());
		module.addKeySerializer(Object.class, new LowerCaseKeySerializer());
		objectMapper.registerModule(module);
		return objectMapper;
	}

	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
		return bCryptPasswordEncoder;
	}

	@Bean
	public SQLQueryManagerProvider getSQLQueryManagerProvider() {
		SQLQueryManagerProvider sqlQueryManagerProvider = new SQLQueryManagerProvider();
		sqlQueryManagerProvider.setJsonResources(new String[]{"/actions/query.json"});
		sqlQueryManagerProvider.setDebug(true);
		return sqlQueryManagerProvider;
	}

	@Bean
	public FormManagerProvider getFormManagerProvider(SQLQueryManagerProvider sqlQueryManagerProvider) {
		FormManagerProvider formManagerProvider = new FormManagerProvider();
		formManagerProvider.setJsonResources(new String[]{"/actions/form.json"});
		formManagerProvider.setDebug(true);
		formManagerProvider.setSqlQueryManagerProvider(sqlQueryManagerProvider);
		return formManagerProvider;
	}

	public static void main(String[] args) {
		SpringApplication.run(StrutserApplication.class, args);
	}

	@Bean
	CommandLineRunner init(StorageService storageService) {
		return (args) -> {
//			storageService.deleteAll();
			storageService.init();
		};
	}

//	@Override
//	public void run(String... strings) {
//
//	}
}
