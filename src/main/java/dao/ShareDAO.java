package dao;

import java.util.List;

import entity.Share;

public interface ShareDAO {
	void create(Share share);

	List<Share> findByVideoId(String videoId);
}
