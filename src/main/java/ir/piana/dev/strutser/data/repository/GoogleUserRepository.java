package ir.piana.dev.strutser.data.repository;

import ir.piana.dev.strutser.data.model.GoogleUserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GoogleUserRepository extends JpaRepository<GoogleUserEntity, Long> {
    GoogleUserEntity findByUsername(String email);
}
