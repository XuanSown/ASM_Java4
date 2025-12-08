package dao;

import java.util.List;

import entity.Favorite;

public interface FavoriteDAO {
	List<Favorite> findByUserId(String userId);

	List<Favorite> findByVideoId(String videoId);

	Favorite findByUserIdAndVideoId(String userId, String videoId);

	void create(Favorite favorite);

	void delete(Long id); // xóa theo id bảng Favorite

	List<Object[]> reportFavorites();
}
