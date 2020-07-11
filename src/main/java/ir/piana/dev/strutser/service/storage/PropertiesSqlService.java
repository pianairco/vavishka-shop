package ir.piana.dev.strutser.service.storage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;

@Service
public class PropertiesSqlService {
    @Autowired
    private DataSource dataSource;

}
