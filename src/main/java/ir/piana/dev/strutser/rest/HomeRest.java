package ir.piana.dev.strutser.rest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/")
public class HomeRest {
    @GetMapping(path = "/")
    public ModelAndView redirect(ModelMap model) {
        model.addAttribute("attribute", "redirectWithRedirectPrefix");
        return new ModelAndView("redirect:/home", model);
    }

    @GetMapping(path = "home")
    public String getHome(HttpServletRequest request) {
        return "homePage";
    }

    @GetMapping(path = "hello")
    public String getHello(HttpServletRequest request) {
        return "helloPage";
    }

    @GetMapping(path = "login")
    public String getLogin(HttpServletRequest request) {
        return "loginPage";
    }
}
