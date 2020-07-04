package ir.piana.dev.strutser;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication(scanBasePackages = {
		"ir.piana.dev.strutser",
		"org.apache.struts.action"
})
@ServletComponentScan("org.apache.struts.action")
public class StrutserApplication {
	public static void main(String[] args) {
		SpringApplication.run(StrutserApplication.class, args);
	}
}
