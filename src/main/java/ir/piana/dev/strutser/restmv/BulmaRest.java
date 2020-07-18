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
    public ModelAndView getHome(HttpServletRequest request) {
        return new ModelAndView("bulma.homePage");
    }

    @GetMapping(path = "/shop")
    public ModelAndView getShop(HttpServletRequest request) {
        return new ModelAndView("bulma.shopPage");
    }

    @GetMapping(path = "/gallery")
    public ModelAndView getGallery(HttpServletRequest request) {
        return new ModelAndView("bulma.galleryPage");
    }

    @GetMapping(path = "/sample")
    public ModelAndView getSamplePage(HttpServletRequest request) {
        return new ModelAndView("bulma.samplePage");
    }

    @GetMapping(path = "/admin/sample")
    public ModelAndView getAdminSamplePage(HttpServletRequest request) {
        return new ModelAndView("bulma.adminSamplePage");
    }

    @GetMapping(path = "/sample-search")
    public ModelAndView getSampleSearchPage(HttpServletRequest request) {
        return new ModelAndView("bulma.sampleSearchPage");
    }
}
