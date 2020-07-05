package ir.piana.dev.strutser.rest;

import com.google.api.client.googleapis.auth.oauth2.*;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import ir.piana.dev.strutser.data.model.GoogleUserEntity;
import ir.piana.dev.strutser.data.repository.GoogleUserRepository;
import ir.piana.dev.strutser.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.LinkedHashMap;
import java.util.Map;

@RestController
public class GoogleAuthController {
    @Autowired
    GoogleUserRepository googleUserRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @PostMapping(path = "vavishka-shop/login")
    public GoogleUserEntity refreshToken(RequestEntity requestEntity) {
        RestTemplate restTemplate = new RestTemplate();

        Map body = (Map) requestEntity.getBody();
        String userId = (String) body.get("id");
        String email = (String) body.get("username");
        String password = (String) body.get("password");

        GoogleUserEntity googleUserEntity = null;
        googleUserEntity = googleUserRepository.findByUsername(email);
        if (googleUserEntity == null) {
            googleUserEntity = new GoogleUserEntity("", email, bCryptPasswordEncoder.encode("1234"),
                    true, "", "", "fa", "", "");
            googleUserRepository.save(googleUserEntity);
        }

        Map<String, String> map = new LinkedHashMap<>();
        map.put("username", email);
        map.put("password", "1234");

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, String>> entity = new HttpEntity<>(map, headers);

        ResponseEntity<Map> response =
                restTemplate.exchange("http://localhost/login",
                        HttpMethod.POST,
                        entity,
                        Map.class);
        return googleUserEntity;
    }
}
