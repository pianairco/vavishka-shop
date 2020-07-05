package ir.piana.dev.strutser.data.repository;

import ir.piana.dev.strutser.data.model.Sms;
import org.springframework.data.jpa.repository.JpaRepository;


public interface SmsRepository extends JpaRepository<Sms, Long> {
}
