package ir.piana.dev.strutser.restmv;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("bulma")
public class BulmaRest {
    @GetMapping(path = "/home")
    public ModelAndView getHeaderImage(HttpServletRequest request) {
        return new ModelAndView("bulma.homePage");
    }
}
