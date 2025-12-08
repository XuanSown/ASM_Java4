package dao.impl;

import dao.ShareDAO;
import entity.Share;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import util.XJPA;

public class ShareDAOImpl implements ShareDAO {

	@Override
	public void create(Share share) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();
			em.persist(share);
			trans.commit();
		} catch (Exception e) {
			// TODO: handle exception
			trans.rollback();
			throw e;
		} finally {
			em.close();
		}
	}

}
