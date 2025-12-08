package servlet;

import java.io.IOException;
import java.util.List;

import dao.FavoriteDAO;
import dao.ShareDAO;
import dao.UserDAO;
import dao.VideoDAO;
import dao.impl.FavoriteDAOImpl;
import dao.impl.ShareDAOImpl;
import dao.impl.UserDAOImpl;
import dao.impl.VideoDAOImpl;
import entity.Favorite;
import entity.Share;
import entity.User;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/home", "/video/detail", "/admin/videoManager", "/admin/userManager", "/admin/report",
		"/admin/video/list", "/admin/video/details", "/admin/video/edit" })
public class Index extends HttpServlet {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private VideoDAO videoDAO = new VideoDAOImpl();
	private FavoriteDAO favDao = new FavoriteDAOImpl();
	private UserDAO userDao = new UserDAOImpl();
	private ShareDAO shareDAO = new ShareDAOImpl();

	public Index() {
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		// Mac dinh dung layout user
		String layout = "/views/userPageLayout.jsp";

		// Xu ly cho admin
		if (uri.contains("/admin/")) {
			User user = (User) req.getSession().getAttribute("currentUser");
			if (user == null || !user.getAdmin()) {
				resp.sendRedirect(req.getContextPath() + "/login?message=AccessDenied");
				return;
			}
			layout = "/views/adminPageLayout.jsp";

			if (uri.contains("/admin/videoManager")) {
				req.setAttribute("page", "/views/admin/VideoManager.jsp");
			} else if (uri.contains("/admin/userManager")) {
				req.setAttribute("page", "/views/admin/UserManager.jsp");

				List<User> list = userDao.findAll();
				req.setAttribute("users", list);
			} else if (uri.contains("/admin/video/edit")) {
				req.setAttribute("page", "/views/admin/VideoManager.jsp");
				req.setAttribute("subpage", "/views/admin/VideoDetails.jsp");

				// Lấy id cần sửa
				String id = req.getParameter("id");
				Video video = videoDAO.findById(id);
				req.setAttribute("video", video);
				req.setAttribute("isEdit", true); // báo hiệu đang sửa
			} else if (uri.contains("/admin/video/details")) {
				req.setAttribute("page", "/views/admin/VideoManager.jsp");
				req.setAttribute("subpage", "/views/admin/VideoDetails.jsp");
				req.setAttribute("isEdit", false); // báo hiệu thêm mới
			} else if (uri.contains("/admin/video/list")) {
				req.setAttribute("page", "/views/admin/VideoManager.jsp");
				req.setAttribute("subpage", "/views/admin/VideoList.jsp");

				List<Video> list = videoDAO.findAll();
				req.setAttribute("videos", list);
			} else if (uri.contains("/admin/report")) {
				req.setAttribute("page", "/views/admin/Report.jsp");

				// 1. Lấy dữ liệu cho Tab 1 (Thống kê Favorites)
				List<Object[]> listFav = favDao.reportFavorites();
				req.setAttribute("favList", listFav);

				// 2. Lấy dữ liệu cho dropdown Video (để chọn ở Tab 2 và Tab 3)
				List<Video> videoList = videoDAO.findAll();
				req.setAttribute("videos", videoList);

				// 3. Xử lý Tab 2: Lọc người thích theo Video
				String videoUserId = req.getParameter("videoUserId"); // Lấy ID video từ dropdown tab 2
				if (videoUserId != null && !videoUserId.isEmpty()) {
					List<Favorite> favUsers = favDao.findByVideoId(videoUserId);
					req.setAttribute("favUsers", favUsers);
					req.setAttribute("videoUserId", videoUserId); // Giữ lại giá trị đã chọn
				}

				// 4. Xử lý Tab 3: Lọc người share theo Video
				String videoShareId = req.getParameter("videoShareId"); // Lấy ID video từ dropdown tab 3
				if (videoShareId != null && !videoShareId.isEmpty()) {
					List<Share> shareList = shareDAO.findByVideoId(videoShareId);
					req.setAttribute("shareList", shareList);
					req.setAttribute("videoShareId", videoShareId); // Giữ lại giá trị đã chọn
				}
			}
		}

		// Xu ly cho user(trang chu)
		else {
			if (uri.contains("/home")) {
				String pageParam = req.getParameter("page");
				int page = 1; // Mac dinh trang la 1
				if (pageParam != null) {
					try {
						page = Integer.parseInt(pageParam);
					} catch (NumberFormatException e) {
						// TODO: handle exception
						page = 1;
					}
				}
				// So luong video moi trang
				int pageSize = 6;

				// 3. Tính tổng số video và tổng số trang
				// Lưu ý: Để tối ưu nên viết hàm count() trong DAO, nhưng tạm thời dùng
				// findAll().size()
				List<Video> allVideos = videoDAO.findAll();
				int totalVideos = 0;
				for (Video v : allVideos) {
					if (Boolean.TRUE.equals(v.getActive())) {
						totalVideos++;
					}
				}
				int maxPage = (int) Math.ceil((double) totalVideos / pageSize);

				// Kiểm tra nếu page vượt quá maxPage
				if (page > maxPage && maxPage > 0) {
					page = maxPage;
				}
				if (page < 1) {
					page = 1;
				}

				// 4. Lấy danh sách video theo phân trang
				// Hàm này bạn đã có sẵn trong VideoDAOImpl
				List<Video> list = videoDAO.findAll(page, pageSize);

				// 5. Gửi dữ liệu sang JSP
				req.setAttribute("items", list);
				req.setAttribute("currentPage", page);
				req.setAttribute("maxPage", maxPage);
				req.setAttribute("page", "/views/user/home.jsp");
			}

			// Video detail
			else if (uri.contains("/video/detail")) {
				String id = req.getParameter("id");
				if (id != null) {
					Video video = videoDAO.findById(id);
					if (video != null) {
						videoDAO.increaseViews(id); // tăng lượt xem
						video.setViews(video.getViews() + 1); // cập nhật lại view
						req.setAttribute("item", video);

						// lấy ngẫu nhiên video trong danh sách hoặc mới nhất
						// để hiện thị ở sidebar
						List<Video> list = videoDAO.findAll(1, 5); // lấy 5 video ở trang 1
						req.setAttribute("recommendations", list);
						req.setAttribute("page", "/views/user/video-detail.jsp");
					} else {
						resp.sendRedirect(req.getContextPath() + "/home");
						return;
					}
					// Kiểm tra user đã like chưa để hiện thị nút
					User currentUser = (User) req.getSession().getAttribute("currentUser");
					boolean isLiked = false;
					if (currentUser != null) {
						Favorite fav = favDao.findByUserIdAndVideoId(currentUser.getId(), video.getId());
						if (fav != null) {
							isLiked = true;
						}
					}
					req.setAttribute("isLiked", isLiked);
				}
			}
		}
		req.getRequestDispatcher(layout).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}
}
