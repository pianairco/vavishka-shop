package ir.piana.dev.strutser.service;

import com.google.api.client.googleapis.auth.oauth2.*;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import ir.piana.dev.strutser.data.model.GoogleUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.io.InputStream;
import java.io.InputStreamReader;

@Service("loginService")
public class LoginService {
    @Autowired
    EntityManager entityManager;

    @Transactional(propagation = Propagation.REQUIRED)
    public void service(String mobile) {
        Query nativeQuery = entityManager.createNativeQuery("insert into users (mobile, password) values (?, ?)");
        nativeQuery.setParameter(1, mobile);

        nativeQuery.setParameter(2, "4321");
        int i = nativeQuery.executeUpdate();
    }

    public GoogleUserEntity refreshToken(String code) {
//        https://developers.google.com/identity/sign-in/web/server-side-flow#java
        try {
//            RestTemplate restTemplate = new RestTemplate();
//            HttpHeaders headers = new HttpHeaders();
//            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
//            MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
//            map.add("code",code);
//            map.add("client_id","290205995528-o268sq4cttuds0f44jnre5sb6rudfsb5.apps.googleusercontent.com");
//            map.add("client_secret","vTqJIybOJYxEho_XTv70rJBW");
//            map.add("grant_type","authorization_code");
//            map.add("redirect_uri","http://localhost");
//
//            HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(map, headers);
//
//            ResponseEntity<Map> response =
//                    restTemplate.exchange("https://oauth2.googleapis.com/token",
////                    restTemplate.exchange("https://www.googleapis.com/o/auth2/token",
//                            HttpMethod.POST,
//                            entity,
//                            Map.class);
//            String accessToken = (String)response.getBody().get("access_token");
//            GoogleCredential credential = new GoogleCredential().setAccessToken(accessToken);
            InputStream resourceAsStream = LoginService.class.getResourceAsStream(
                    "/client_secret_290205995528-o268sq4cttuds0f44jnre5sb6rudfsb5.apps.googleusercontent.com.json");

            GoogleClientSecrets clientSecrets =
                    GoogleClientSecrets.load(
                            JacksonFactory.getDefaultInstance(), new InputStreamReader(resourceAsStream));

            GoogleTokenResponse tokenResponse =
                    new GoogleAuthorizationCodeTokenRequest(
                            new NetHttpTransport(),
                            JacksonFactory.getDefaultInstance(),
                            "https://oauth2.googleapis.com/token",
                            clientSecrets.getDetails().getClientId(),//"290205995528-o268sq4cttuds0f44jnre5sb6rudfsb5.apps.googleusercontent.com",
                            clientSecrets.getDetails().getClientSecret(),//"vTqJIybOJYxEho_XTv70rJBW",
                            code,
                            "http://localhost")  // Specify the same redirect URI that you use with your web
                            // app. If you don't have a web version of your app, you can
                            // specify an empty string.
                            .execute();
            String accessToken = tokenResponse.getAccessToken();
            GoogleCredential credential = new GoogleCredential().setAccessToken(accessToken);
            GoogleIdToken idToken = tokenResponse.parseIdToken();
            GoogleIdToken.Payload payload = idToken.getPayload();
            String userId = payload.getSubject();  // Use this value as a key to identify a user.
            String email = payload.getEmail();
            boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
            String name = (String) payload.get("name");
            String pictureUrl = (String) payload.get("picture");
            String locale = (String) payload.get("locale");
            String familyName = (String) payload.get("family_name");
            String givenName = (String) payload.get("given_name");
            return new GoogleUserEntity(userId, email, "2", emailVerified, name, pictureUrl, locale, familyName, givenName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


}
