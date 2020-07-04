package ir.piana.dev.strutser.data.manager;

import ir.piana.dev.strutser.data.dao.GenericDAO;
import ir.piana.dev.strutser.data.dao.GenericJdbcDAO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.io.Serializable;
import java.util.List;

@Component
@Transactional
@Slf4j
public class GenericManagerImpl implements GenericManager {

    @Autowired
    protected GenericDAO dao;

    @Autowired
    public GenericJdbcDAO genericJdbcDAO;

    @Override
    public GenericJdbcDAO getGenericJdbcDAO() {
        return genericJdbcDAO;
    }

    @Override
    public GenericDAO getDao() {
        return dao;
    }

    @Override
    public List findObjectsByTemplate(String hql) {
        return dao.findObjectsByTemplate(hql);
    }

    @Override
    public List findObjects(Class clazz) {
        return dao.findObjects(clazz);
    }

    @Override
    public List findObjects(Class clazz, String orderBy) {
        return dao.findObjects(clazz, orderBy);
    }

    @Override
    public List findObjects(String hql) {
        return dao.findObjects(hql);
    }

    @Override
    public List findObjects(String hql, int maxResults) {
        return dao.findObjects(hql, maxResults);
    }

    @Override
    public Object findObject(Class clazz, Serializable id) {
        return dao.findObject(clazz, id);
    }

    @Override
    public Object findObjectWithRefresh(Class clazz, Serializable id) {
        return dao.findObjectWithRefresh(clazz, id);
    }

    @Override
    public void saveObject(Object object, String ip, String username) {
/*
if (object instanceof PurchaseOrder) {
PurchaseOrder po = (PurchaseOrder) object;
if (po.getPoId() != null) {
dao.flush();
ledgerDAO.renumberPOLines(po.getPoId().longValue());
}
} else if (object instanceof SaleOrder) {
SaleOrder so = (SaleOrder) object;
if (so.getSoId() != null) {
dao.flush();
ledgerDAO.renumberSOLines(so.getSoId().longValue());
}
}
*/
        dao.saveObject(object, ip, username);
    }

    @Override
    public void saveObject(Object object, HttpServletRequest request) {
        String username = null;
        String ip = null;
        if (request != null) {
            username = request.getRemoteUser();
            ip = request.getRemoteHost();
        }
        saveObject(object, ip, username);
    }

    private void removeObject(Class clazz, Serializable id, String ip, String username) {
        dao.removeObject(clazz, id, ip, username);
    }

    private void removeObject(Object object) {
        dao.removeObject(object, null, null);
    }

    @Override
    public void removeObject(Class clazz, Serializable id, HttpServletRequest request) {
        String ip = request.getRemoteHost();
        String username = request.getRemoteUser();
        removeObject(clazz, id, ip, username);
    }

    @Override
    public void removeObject(Object object, String ip, String username) {
        dao.removeObject(object, ip, username);
    }

    @Override
    public void removeObject(Object object, HttpServletRequest request) {
        String ip = request.getRemoteHost();
        String username = request.getRemoteUser();
        dao.removeObject(object, ip, username);
    }

    @Override
    public void evict(Object object) {
        dao.evict(object);
    }

    @Override
    public void flush() {
        dao.flush();
    }

    @Override
    public int findObjectsCount(String countHql) {
        return dao.findObjectsCount(countHql);
    }

    @Override
    public long findMax(String maxHql) {
        return dao.findMax(maxHql);
    }

    @Override
    public String findMaxString(String maxHql) {
        return dao.findMaxString(maxHql);
    }

    @Override
    public long findSum(String sumHql) {
        return dao.findMax(sumHql);
    }

}
