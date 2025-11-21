package servlet;

import java.io.IOException;
import java.util.List;

import dao.VideoDAO;
import dao.impl.VideoDAOImpl;
import entity.User;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/home", "/admin/videoManager", "/admin/userManager", "/admin/report", "/admin/video/list",
		"/admin/video/details" })
public class Index extends HttpServlet {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private VideoDAO videoDAO = new VideoDAOImpl();

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
			} else if (uri.contains("/admin/video/details")) {
				req.setAttribute("page", "/views/admin/VideoManager.jsp");
				req.setAttribute("subpage", "/views/admin/VideoDetails.jsp");
			} else if (uri.contains("/admin/video/list")) {
				req.setAttribute("page", "/views/admin/VideoManager.jsp");
				req.setAttribute("subpage", "/views/admin/VideoList.jsp");
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
				int pageSize = 9;

				// 3. Tính tổng số video và tổng số trang
				// Lưu ý: Để tối ưu nên viết hàm count() trong DAO, nhưng tạm thời dùng
				// findAll().size()
				List<Video> allVideos = videoDAO.findAll();
				int totalVideos = allVideos.size();
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
		}
		req.getRequestDispatcher(layout).forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}
}
