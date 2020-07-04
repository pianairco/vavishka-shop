package ir.piana.dev.strutser.data.dao;

import java.io.Serializable;
import java.util.List;

public interface GenericDAO extends DAO {
    GenericJdbcDAO getGenericJdbcDAO();
    List findObjects(Class clazz);
    List findObjects(Class clazz, String orderBy);
    List findObjectsByTemplate(String hql);
    List findObjects(String hql);
    List findObjects(String hql, int maxResults);
    Object findObject(Class clazz, Serializable id);
    Object findObjectWithRefresh(Class clazz, Serializable id);
    void saveObject(Object object, String ip, String username);
    void flush();
    void clear();
    void removeObject(Class clazz, Serializable id, String ip, String username);
    void removeObject(Object object, String ip, String username);
    void evict(Object object);
    int findObjectsCount(String countHql);
    long findMax(String maxHql);
    String findMaxString(String maxHql);
}
