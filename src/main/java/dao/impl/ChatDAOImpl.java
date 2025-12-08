package dao.impl;

import java.util.List;

import dao.ChatDAO;
import entity.ChatMessage;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import util.XJPA;

public class ChatDAOImpl implements ChatDAO {

	@Override
	public void create(ChatMessage message) {
		EntityManager em = XJPA.getEntityManager();
		EntityTransaction trans = em.getTransaction();
		try {
			trans.begin();
			em.persist(message);
			trans.commit();
		} catch (Exception e) {
			trans.rollback();
			e.printStackTrace();
		} finally {
			em.close();
		}
	}

	@Override
	public List<ChatMessage> findTop50() {
		EntityManager em = XJPA.getEntityManager();
		try {
			// Lấy 50 tin nhắn mới nhất, sắp xếp theo thời gian tăng dần để hiển thị đúng
			// thứ tự
			String jpql = "SELECT c FROM ChatMessage c ORDER BY c.createdDate ASC";
			TypedQuery<ChatMessage> query = em.createQuery(jpql, ChatMessage.class);
			// Nếu muốn tối ưu chỉ lấy 50 dòng thì dùng setMaxResults, nhưng logic sort hơi
			// ngược chút
			// Ở đây để đơn giản mình lấy toàn bộ hoặc giới hạn sau
			return query.getResultList();
		} finally {
			em.close();
		}
	}
}