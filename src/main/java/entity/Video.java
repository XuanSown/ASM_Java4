package entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "Video")
public class Video {
	@Id
	@Column(name = "Id")
	private String id;
	@Column(name = "Title", columnDefinition = ("nvarchar(255)"))
	private String title;
	@Column(name = "Poster")
	private String poster;
	@Column(name = "Views")
	private Integer views;
	@Column(name = "Description", columnDefinition = ("nvarchar(max)"))
	private String description;
	@Column(name = "Active")
	private Boolean active;

	@OneToMany(mappedBy = "video")
	private List<Favorite> favorites;
	@OneToMany(mappedBy = "video")
	private List<Share> shares;

	public Video() {
		// TODO Auto-generated constructor stub
	}

	public Video(String id, String title, String poster, Integer views, String description, Boolean active,
			List<Favorite> favorites, List<Share> shares) {
		super();
		this.id = id;
		this.title = title;
		this.poster = poster;
		this.views = views;
		this.description = description;
		this.active = active;
		this.favorites = favorites;
		this.shares = shares;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public Integer getViews() {
		return views;
	}

	public void setViews(Integer views) {
		this.views = views;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public List<Favorite> getFavorites() {
		return favorites;
	}

	public void setFavorites(List<Favorite> favorites) {
		this.favorites = favorites;
	}

	public List<Share> getShares() {
		return shares;
	}

	public void setShares(List<Share> shares) {
		this.shares = shares;
	}

}
