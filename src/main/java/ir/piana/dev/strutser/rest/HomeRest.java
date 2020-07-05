package ir.piana.dev.strutser.rest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeRest {
    @GetMapping(path = "home")
    public String getHome() {
        return "homePage";
    }
}
