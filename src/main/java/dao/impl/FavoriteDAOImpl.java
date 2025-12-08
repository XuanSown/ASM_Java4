package dao.impl;

import java.util.List;

import dao.FavoriteDAO;
import entity.Favorite;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import util.XJPA;

public class FavoriteDAOImpl implements FavoriteDAO {

	@Override
	public List<Favorite> findByUserId(String userId) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		try {
			String jpql = "select f from Favorite f where f.user.id = :uid";
			TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
			query.setParameter("uid", userId);
			return query.getResultList();
		} finally {
			// TODO: handle finally clause
			em.close();
		}
	}

	@Override
	public List<Favorite> findByVideoId(String videoId) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		try {
			String jpql = "select f from Favorite f where f.video.id = :vid";
			TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
			query.setParameter("vid", videoId);
			return query.getResultList();
		} finally {
			// TODO: handle finally clause
			em.close();
		}
	}

	@Override
	public Favorite findByUserIdAndVideoId(String userId, String videoId) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		try {
			String jpql = "select f from Favorite f where f.user.id = :uid and f.video.id = :vid";
			TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
			query.setParameter("uid", userId);
			query.setParameter("vid", videoId);
			return query.getResultStream().findFirst().orElse(null);
		} finally {
			// TODO: handle finally clause
			em.close();
		}
	}

	@Override
	public void create(Favorite favorite) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();
			em.persist(favorite);
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
	public void delete(Long id) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();
			Favorite fav = em.find(Favorite.class, id);
			if (fav != null) {
				em.remove(fav);
			}
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
