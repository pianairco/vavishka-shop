package ir.piana.dev.strutser.action;

import com.fasterxml.jackson.databind.ObjectMapper;
import ir.piana.dev.strutser.data.model.Sms;
import ir.piana.dev.strutser.data.repository.SmsRepository;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Service("home")
public class HomeAction extends DispatchAction {

    @Autowired
    SmsRepository smsRepository;

    @Autowired
    private EntityManager entityManager;

    @Autowired
    private ObjectMapper objectMapper;

    public ActionForward unspecified(ActionMapping mapping, ActionForm form,
                                     HttpServletRequest request,
                                     HttpServletResponse response)
            throws Exception {
        return list(mapping, form, request, response);
    }

    public ActionForward list(ActionMapping mapping, ActionForm form,
                                     HttpServletRequest request,
                                     HttpServletResponse response)
            throws Exception {
//        Sms object = smsRepository.findById(1l).get();
        return mapping.findForward("home");
    }

    public ResponseEntity ajax(ActionForm form,
                               HttpServletRequest request)
            throws Exception {
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.set("Content-Type","APPLICATION/JSON");
        return ResponseEntity.ok().headers(responseHeaders)
                .body(objectMapper.readValue("{\"name\": \"ali\"}", Map.class));
    }
}
