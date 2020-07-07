package ir.piana.dev.strutser.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Splitter;
import ir.piana.dev.strutser.data.model.GoogleUserEntity;
import org.apache.commons.io.IOUtils;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

public class JWTAuthenticationFilter extends UsernamePasswordAuthenticationFilter {

    private BCryptPasswordEncoder bCryptPasswordEncoder;
    private AuthenticationManager authenticationManager;

    public JWTAuthenticationFilter(
            AuthenticationManager authenticationManager, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.authenticationManager = authenticationManager;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest req,
                                                HttpServletResponse res) throws AuthenticationException {
        try {
            GoogleUserEntity userEntity = null;
            if("application/x-www-form-urlencoded".equalsIgnoreCase(req.getContentType())) {
                String s = IOUtils.toString(req.getInputStream());
                Map<String, String> split = Splitter.on('&')
                        .withKeyValueSeparator('=')
                        .split(s);
                userEntity = GoogleUserEntity.builder()
                        .username(split.get("username"))
                        .password(split.get("password"))
                        .build();
            } else {
                userEntity = new ObjectMapper()
                        .readValue(req.getInputStream(), GoogleUserEntity.class);
            }

            return authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            userEntity.getUsername(),
                            userEntity.getPassword(),
                            new ArrayList<>())
            );
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest req,
                                            HttpServletResponse res,
                                            FilterChain chain,
                                            Authentication auth) throws IOException, ServletException {

//        String token = JWT.create()
//                .withSubject(((User) auth.getPrincipal()).getUsername())
//                .withExpiresAt(new Date(System.currentTimeMillis() + 864_000_000))
//                .sign(Algorithm.HMAC512("SecretKeyToGenJWTs".getBytes()));
        req.getSession().setAttribute("authentication", auth.getPrincipal());
        req.getSession().setAttribute("authorization", ((User) auth.getPrincipal()).getUsername());
//        res.addHeader("Authorization", "Bearer " + token);
    }
}
