package ir.piana.dev.strutser;

import com.fasterxml.jackson.databind.ObjectMapper;
import ir.piana.dev.strutser.action.common.FormManagerProvider;
import ir.piana.dev.strutser.action.common.SQLQueryManagerProvider;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ImportResource;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication(scanBasePackages = {
		"ir.piana.dev.strutser",
		"org.apache.struts.action"
})
//@ImportResource("classpath:applicationContext.xml")
@ServletComponentScan("org.apache.struts.action")
@EnableTransactionManagement
public class StrutserApplication {
	@Bean("objectMapper")
	public ObjectMapper getObjectMapper() {
		return new ObjectMapper();
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
}
