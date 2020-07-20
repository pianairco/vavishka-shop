package ir.piana.dev.strutser.restmv;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import ir.piana.dev.strutser.service.sql.SqlService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("bulma")
public class BulmaRest {

    @Autowired
    private SqlService sqlService;

    @Autowired
    private ObjectMapper mapper;

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
    public ModelAndView getSampleSearchPage(HttpServletRequest request) throws JsonProcessingException {
        List<Map<String, Object>> sample = sqlService.list("sample");
        Map<String, Object> model = new LinkedHashMap<>();
        model.put("sample", mapper.writeValueAsString(sample));
        return new ModelAndView("bulma.sampleSearchPage", model);
    }
}
