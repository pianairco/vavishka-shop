package ir.piana.dev.strutser.service;

import ir.piana.dev.strutser.data.model.GoogleUserEntity;
import ir.piana.dev.strutser.data.repository.GoogleUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    private GoogleUserRepository googleUserRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//        GoogleUserEntity googleUserModel = new GoogleUserEntity();
        GoogleUserEntity googleUserModel = googleUserRepository.findByUsername(username);
        if (googleUserModel == null) {
            throw new UsernameNotFoundException(username);
        }
        return new User(googleUserModel.getUsername(), googleUserModel.getPassword(), Collections.emptyList());
    }
}
