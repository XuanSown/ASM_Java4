package servlet;

import java.io.IOException;
import java.sql.Date;

import dao.ShareDAO;
import dao.impl.ShareDAOImpl;
import entity.Share;
import entity.User;
import entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.EmailUtils;

@WebServlet("/video/share")
public class ShareVideoServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ShareDAO shareDAO = new ShareDAOImpl();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute("currentUser");

		// kiểm tra đăng nhập
		if (currentUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		String videoId = req.getParameter("videoId");
		String emailTo = req.getParameter("email");

		if (videoId == null || emailTo == null || emailTo.isEmpty()) {
			session.setAttribute("toastMessage", "Thông tin chia sẻ không hợp lệ!");
			session.setAttribute("toastType", "danger");
			resp.sendRedirect(req.getHeader("Referer"));
			return;
		}

		try {
			// gửi email
			String subject = "Chia sẻ video hay từ Sown Tube";
			String link = req.getRequestURL().toString().replace("share", "detail") + "?id=" + videoId;
			String body = "Xin chào,\n\n" + "Bạn của bạn (" + currentUser.getFullname()
					+ ") muốn chia sẻ một video thú vị với bạn.\n" + "Click vào link để xem ngay: " + link + "\n\n"
					+ "Chúc bạn xem phim vui vẻ!";

			EmailUtils.send(emailTo, subject, body);

			// lưu vào db
			Share share = new Share();
			share.setEmails(emailTo);
			share.setShareDate(new Date(System.currentTimeMillis()));
			share.setUser(currentUser);

			Video video = new Video();
			video.setId(videoId);
			share.setVideo(video);

			shareDAO.create(share);

			session.setAttribute("toastMessage", "Đã gửi video thành công!");
			session.setAttribute("toastType", "success");

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session.setAttribute("toastMessage", "Lỗi gửi email: " + e.getMessage());
			session.setAttribute("toast", "danger");
		}
		resp.sendRedirect(req.getHeader("Referer"));
	}
}
