package servlet;

import java.io.IOException;
import java.sql.Date;

import dao.FavoriteDAO;
import dao.impl.FavoriteDAOImpl;
import entity.Favorite;
import entity.User;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*Kiểm tra người dùng đã like chưa
 * Nếu chưa -> thêm vào bảng Favorite
 * Nếu rồi -> xóa khỏi bảng Favorite*/

@WebServlet("/video/like")
public class LikeVideoServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private FavoriteDAO favDao = new FavoriteDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute("currentUser");

		// Kiểm tra đăng nhập
		if (currentUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		String videoId = req.getParameter("id");
		if (videoId == null) {
			resp.sendRedirect(req.getContextPath() + "/home");
			return;
		}

		try {
			Favorite existFav = favDao.findByUserIdAndVideoId(currentUser.getId(), videoId);
			// kiểm tra xem đã lưu chưa?
			// chưa like -> tạo mới
			if (existFav == null) {
				Favorite newFav = new Favorite();
				newFav.setUser(currentUser);

				Video video = new Video();
				video.setId(videoId);
				newFav.setVideo(video);

				newFav.setLikeDate(new Date(System.currentTimeMillis()));
				favDao.create(newFav);

				session.setAttribute("toastMessage", "Đã thêm vào danh sách yêu thích!");
				session.setAttribute("toastType", "success"); // Màu xanh
			} else {
				favDao.delete(existFav.getId()); // đã like -> xóa

				session.setAttribute("toastMessage", "Đã hủy bỏ yêu thích!");
				session.setAttribute("toastType", "danger"); // Màu đỏ
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		// quay trang cũ hoặc home
		String referer = req.getHeader("referer");
		if (referer != null) {
			resp.sendRedirect(referer);
		} else {
			resp.sendRedirect(req.getContextPath() + "/home");
		}
	}
}
