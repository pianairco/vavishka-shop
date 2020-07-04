package ir.piana.dev.strutser.data.manager;

import ir.piana.dev.strutser.data.dao.GenericDAO;
import ir.piana.dev.strutser.data.dao.GenericJdbcDAO;

import javax.servlet.http.HttpServletRequest;
import java.io.Serializable;
import java.util.List;

public interface GenericManager {
    GenericJdbcDAO getGenericJdbcDAO();
    GenericDAO getDao();
    List findObjects(Class clazz);
    List findObjects(Class clazz, String orderBy);
    List findObjects(String hql);
    List findObjectsByTemplate(String hql);
    List findObjects(String hql, int maxResults);
    Object findObject(Class clazz, Serializable id);
    Object findObjectWithRefresh(Class clazz, Serializable id);
    void saveObject(Object object, String ip, String username);
    void saveObject(Object object, HttpServletRequest request);
    void removeObject(Class clazz, Serializable id, HttpServletRequest request);
    void removeObject(Object object, HttpServletRequest request);
    void removeObject(Object object, String ip, String username);
    void evict(Object object);
    void flush();
    int findObjectsCount(String countHql);
    long findMax(String maxHql);
    String findMaxString(String maxHql);
    long findSum(String sumHql);
}
