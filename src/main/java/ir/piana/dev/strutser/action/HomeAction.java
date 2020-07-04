package ir.piana.dev.strutser.action;

import com.fasterxml.jackson.databind.ObjectMapper;
import ir.piana.dev.strutser.data.manager.GenericManager;
import ir.piana.dev.strutser.data.model.Sms;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Service("home")
public class HomeAction extends DispatchAction {

    @Autowired
    private GenericManager genericManager;

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
        Object object = genericManager.findObject(Sms.class, 1l);
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
