package dao;

import java.util.List;

import entity.ChatMessage;

public interface ChatDAO {
	void create(ChatMessage message);

	List<ChatMessage> findTop50(); // Lấy 50 tin nhắn mới nhất
}