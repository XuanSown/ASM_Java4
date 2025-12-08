package dao.impl;

import java.util.List;

import dao.ShareDAO;
import entity.Share;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
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

	@Override
	public List<Share> findByVideoId(String videoId) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		try {
			String jpql = "SELECT s FROM Share s WHERE s.video.id = :vid";
			TypedQuery<Share> query = em.createQuery(jpql, Share.class);
			query.setParameter("vid", videoId);
			return query.getResultList();
		} finally {
			// TODO: handle finally clause
			em.close();
		}
	}

}
