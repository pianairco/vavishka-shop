package ir.piana.dev.strutser.data.dao;

import lombok.extern.slf4j.Slf4j;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

@Component
@Transactional
@Slf4j
public class GenericDAOHibernate implements GenericDAO {
    private static int MAX_RESULTS_DEFAULT = 1000;

    @Autowired
    private SessionFactory sessionFactory;

    @Autowired
    private GenericJdbcDAO genericJdbcDAO;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public GenericJdbcDAO getGenericJdbcDAO() {
        return null;
    }

    @Override
    public List findObjects(Class clazz) {
        return getSession().createCriteria(clazz).setMaxResults(MAX_RESULTS_DEFAULT).list();
    }

    @Override
    public List findObjects(Class clazz, String orderBy) {
        return getSession().createQuery("from " + clazz.getName() + " tableName order by tableName." + orderBy).setMaxResults(MAX_RESULTS_DEFAULT).list();
    }

    @Override
    public List findObjectsByTemplate(String hql) {
        return getSession().createQuery(hql).setMaxResults(MAX_RESULTS_DEFAULT).list();    }

    @Override
    public List findObjects(String hql) {
        int maxResults = MAX_RESULTS_DEFAULT;
        return findObjects(hql, maxResults);
    }

    @Override
    public List findObjects(String hql, int maxResults) {
        final Query query = getSession().createQuery(hql);
        return query.setMaxResults(maxResults).list();
    }

    @Override
    public Object findObject(Class clazz, Serializable id) {
        return getSession().get(clazz, id);
    }

    @Override
    public Object findObjectWithRefresh(Class clazz, Serializable id) {
        Object object = getSession().get(clazz, id);
        getSession().refresh(object);
        if (object == null) {
        }
        return object;
    }

    @Override
    public void saveObject(Object object, String ip, String username) {
        getSession().saveOrUpdate(object);
    }

    @Override
    public void flush() {
        getSession().flush();
    }

    @Override
    public void clear() {
        getSession().clear();
    }

    @Override
    public void removeObject(Class clazz, Serializable id, String ip, String username) {
        Object object = findObject(clazz, id);
        removeObject(object, ip, username);
    }

    @Override
    public void removeObject(Object object, String ip, String username) {
        getSession().delete(object);
    }

    @Override
    public void evict(Object object) {
        getSession().evict(object);
    }

    @Override
    public int findObjectsCount(String countHql) {
        List lst = findObjects(countHql, 1);
        if (lst.size() > 0) {
            Long count = (Long) lst.iterator().next();
            return count.intValue();
        } else {
            log.error("bad countHql : " + countHql);
            return 0;
        }
    }

    @Override
    public long findMax(String maxOrSumHql) {
        List lst = findObjects(maxOrSumHql, 1);
        if (lst.size() > 0) {
            long max = 0L;
            try {
                Object object = lst.iterator().next();
                if (object == null) {
                    return 0L;
                } else {
                    log.debug("MAX/SUM : object.getClass() = " + object.getClass());
                    max = Long.parseLong(object.toString());
                }
            } catch (NumberFormatException e) {
                log.error("bad maxOrSumHql : " + maxOrSumHql);
                log.error(e.getMessage());
            }
            return max;
        } else {
            log.error("bad maxOrSumHql : " + maxOrSumHql);
            return 0L;
        }
    }

    @Override
    public String findMaxString(String maxHql) {
        List lst = findObjects(maxHql, 1);
        if (lst.size() > 0) {
            Object object = lst.iterator().next();
            if (object != null) {
                return object.toString();
            } else {
                log.error("bad maxHql : " + maxHql);
                return "";
            }
        } else {
            log.error("bad maxHql : " + maxHql);
            return "";
        }

    }
}
