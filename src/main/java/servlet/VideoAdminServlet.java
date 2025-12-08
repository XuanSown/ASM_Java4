package servlet;

import java.io.IOException;

import dao.VideoDAO;
import dao.impl.VideoDAOImpl;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({ "/admin/video/save", "/admin/video/delete" })
public class VideoAdminServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private VideoDAO videoDAO = new VideoDAOImpl();

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String uri = req.getRequestURI();

		if (uri.contains("save")) {
			save(req, resp);
		} else if (uri.contains("delete")) {
			delete(req, resp);
		}
	}

	// hàm save
	private void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			Video video = new Video();
			video.setId("id");
			video.setTitle("title");
			video.setDescription("description");

			// active
			boolean active = req.getParameter("active") != null;
			video.setActive(active);

			String poster = req.getParameter("poster");
			if (poster == null || poster.trim().isEmpty()) {
				// tự động tạo link ảnh nếu để trống
				poster = "https://img.youtube.com/vi/" + video.getId() + "/maxresdefault.jpg";
			}
			video.setPoster(poster);

			// link embed youtube
			video.setLink("https://www.youtube.com/embed/" + video.getId());

			// kiểm tra xem là thêm mới hay là cập nhật
			Video existVideo = videoDAO.findById(video.getId());
			if (existVideo == null) {
				video.setViews(0);
				videoDAO.create(video);
				req.setAttribute("message", "Thêm mới thành công!");
			} else {
				video.setViews(existVideo.getViews()); // giữ nguyên lượt xem
				videoDAO.update(video);
				req.setAttribute("message", "Cập nhật thành công!");
			}
			req.setAttribute("messageType", "success");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			req.setAttribute("message", "Lỗi: " + e.getMessage());
			req.setAttribute("messageType", "danger");
		}

		// chuyển về trang danh sách lấy kq
		req.getRequestDispatcher("/admin/video/list").forward(req, resp);
	}

	// hàm delete
	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		try {
			videoDAO.delete(id);
			req.setAttribute("message", "Xóa video thành công");
			req.setAttribute("messageType", "danger");
		} catch (Exception e) {
			// TODO: handle exception
		}
		req.getRequestDispatcher("/admin/video/list").forward(req, resp);
	}
}
