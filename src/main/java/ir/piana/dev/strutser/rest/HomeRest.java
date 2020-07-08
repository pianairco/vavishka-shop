package ir.piana.dev.strutser.rest;

import ir.piana.dev.strutser.data.model.GoogleUserEntity;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/")
public class HomeRest {
    @PostMapping("logout")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "hello";
    }


    @GetMapping(path = "/")
    public ModelAndView redirect(ModelMap model) {
        model.addAttribute("attribute", "redirectWithRedirectPrefix");
        return new ModelAndView("redirect:/home", model);
    }

    @GetMapping(path = "error")
    public String getError(HttpServletRequest request) {
        return "errorPage";
    }

    @GetMapping(path = "home")
    public String getHome(HttpServletRequest request) {
        return "homePage";
    }

    @GetMapping(path = "hello")
    public ModelAndView getHello(HttpServletRequest request) {
        request.setAttribute("remoteUser", "hasan");
        GoogleUserEntity user = GoogleUserEntity.builder().name("ali").username("ali@gmai.com").build();
        ModelAndView mv = new ModelAndView("helloPage", "user", user);
        mv.setStatus(HttpStatus.OK);
        return mv;
    }

    @GetMapping(path = "login")
    public String getLogin(HttpServletRequest request) {
        return "loginPage";
    }

    @GetMapping(path = "login-page")
    public String getLoginPage(HttpServletRequest request) {
        return "loginPage";
    }
}
