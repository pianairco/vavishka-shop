package ir.piana.dev.strutser.security;

import ir.piana.dev.strutser.service.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

//https://auth0.com/blog/implementing-jwt-authentication-on-spring-boot/
@EnableWebSecurity
public class WebSecurity extends WebSecurityConfigurerAdapter {
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors().and().csrf().disable().authorizeRequests()
                .antMatchers(HttpMethod.POST, "/home.do").permitAll()
                .antMatchers(HttpMethod.POST, "/vavishka-shop/login").permitAll()
                .antMatchers(HttpMethod.POST, "/action").permitAll()//.authenticated()
                .antMatchers(HttpMethod.POST, "/logout").authenticated()
                .antMatchers(HttpMethod.GET, "/hello").authenticated()
                .antMatchers(HttpMethod.GET, "/home.do").authenticated()
                .antMatchers(HttpMethod.GET, "/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .successForwardUrl("/hello")
                .defaultSuccessUrl("/home")
                .successHandler(getSuccessHandler())
                .failureUrl("/error")
                .permitAll()
                .and()
                .addFilter(new JWTAuthenticationFilter(authenticationManager(), bCryptPasswordEncoder))
                .addFilter(new JWTAuthorizationFilter(authenticationManager()))
//                 this disables session creation on Spring Security
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.ALWAYS);
    }

    @Bean
    public AuthenticationSuccessHandler getSuccessHandler() {
        SimpleUrlAuthenticationSuccessHandler handler = new SimpleUrlAuthenticationSuccessHandler();
        handler.setUseReferer(true);
        return handler;
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder);
    }

    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        final UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", new CorsConfiguration().applyPermitDefaultValues());
        return source;
    }
}
