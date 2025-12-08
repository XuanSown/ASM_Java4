package dao;

import java.util.List;

import entity.Video;

public interface VideoDAO {
	void create(Video video);

	void update(Video video);

	void delete(String id);

	List<Video> findAll();

	List<Video> findAll(int pageNumber, int pageSize);

	List<Video> findByTitle(String keyword);

	Video findById(String id);

	// Hàm tăng view
	void increaseViews(String id);
}
