package ir.piana.dev.strutser.restmv;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminRest {
    @GetMapping(path = "/header")
    public ModelAndView getHeaderImage(HttpServletRequest request) {
        return new ModelAndView("admin.headerPage");
    }

}
