package dao.impl;

import java.util.List;

import dao.VideoDAO;
import entity.Video;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import util.XJPA;

public class VideoDAOImpl implements VideoDAO {

	@Override
	public void create(Video video) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		EntityTransaction trans = em.getTransaction();

		try {
			trans.begin();
			em.persist(video);
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
	public void update(Video video) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		EntityTransaction trans = em.getTransaction();

		try {
			trans.begin();
			em.merge(video);
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
	public void delete(String id) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		EntityTransaction trans = em.getTransaction();

		try {
			trans.begin();
			Video video = em.find(Video.class, id);
			if (video != null) {
				em.remove(video);
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

	@Override
	public List<Video> findAll() {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		try {
			String jpql = "select v from Video v";
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			return query.getResultList();
		} finally {
			// TODO: handle exception
			em.close();
		}
	}

	@Override
	public List<Video> findAll(int pageNumber, int pageSize) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		try {
			String jpql = "select v from Video v";
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setFirstResult((pageNumber - 1) * pageSize);
			query.setMaxResults(pageSize);
			return query.getResultList();
		} finally {
			// TODO: handle exception
			em.close();
		}
	}

	@Override
	public List<Video> findByTitle(String keyword) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		try {
			String jpql = "select v from Video v where v.title LIKE :keyword";
			TypedQuery<Video> query = em.createQuery(jpql, Video.class);
			query.setParameter("keyword", "%" + keyword + "%");
			return query.getResultList();
		} finally {
			// TODO: handle finally clause
			em.close();
		}
	}

	@Override
	public Video findById(String id) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		try {
			return em.find(Video.class, id);
		} finally {
			em.close();
		}
	}

	@Override
	public void increaseViews(String id) {
		// TODO Auto-generated method stub
		EntityManager em = XJPA.getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();
			// update để tăng view trực tiếp
			String jpql = "update Video v set v.views = v.views + 1 where v.id = :id";
			Query query = em.createQuery(jpql);
			query.setParameter("id", id);
			query.executeUpdate();
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
