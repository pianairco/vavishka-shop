package ir.piana.dev.strutser;

import ir.piana.dev.strutser.data.dao.GenericJdbcDAO;
import ir.piana.dev.strutser.data.dao.GenericJdbcDAOImpl;
import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.springframework.context.annotation.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@ImportResource("classpath:applicationContext.xml")
@EnableTransactionManagement
public class HibernateConf {

    @Bean
    public GenericJdbcDAO getGenericJdbcDao(DataSource dataSource) {
        GenericJdbcDAOImpl genericJdbcDAO = new GenericJdbcDAOImpl();
        genericJdbcDAO.setDataSource(dataSource);
        return genericJdbcDAO;
    }

/*//    @Bean
    public LocalSessionFactoryBean sessionFactory() {
        LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
        sessionFactory.setDataSource(dataSource());
//        sessionFactory.setPackagesToScan(
//                {"com.baeldung.hibernate.bootstrap.model" });
        sessionFactory.setHibernateProperties(hibernateProperties());

        return sessionFactory;
    }

//    @Bean
    public DataSource dataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("oracle.jdbc.driver.OracleDriver");
        dataSource.setUrl("jdbc:oracle:thin:@192.168.6.212:1521:devtwo");
        dataSource.setUsername("T2PSSF02");
        dataSource.setPassword("t");

        return dataSource;
    }

//    @Bean
    public PlatformTransactionManager hibernateTransactionManager() {
        HibernateTransactionManager transactionManager
                = new HibernateTransactionManager();
        transactionManager.setSessionFactory(sessionFactory().getObject());
        return transactionManager;
    }

    private final Properties hibernateProperties() {
        Properties hibernateProperties = new Properties();
        hibernateProperties.setProperty(
                "hibernate.hbm2ddl.auto", "create-drop");
        hibernateProperties.setProperty(
                "hibernate.dialect", "org.hibernate.dialect.H2Dialect");

        return hibernateProperties;
    }*/
}
