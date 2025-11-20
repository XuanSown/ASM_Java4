package servlet;

import java.io.IOException;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/editProfile")
public class EditProfileServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserDAO dao = new UserDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.getRequestDispatcher("/views/editProfile.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		User currentUser = (User) session.getAttribute("currentUser");

		if (currentUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		String fullname = req.getParameter("fullname");
		String email = req.getParameter("email");

		try {
			// Cập nhật thông tin vào đối tượng User
			currentUser.setFullname(fullname);
			currentUser.setEmail(email);

			// Gọi DAO để update xuống Database
			dao.update(currentUser);

			// Cập nhật lại session để hiển thị tên mới ngay lập tức
			session.setAttribute("currentUser", currentUser);

			req.setAttribute("message", "Cập nhật hồ sơ thành công!");
			req.setAttribute("messageType", "success");

		} catch (Exception e) {
			req.setAttribute("message", "Lỗi cập nhật: " + e.getMessage());
		}
		req.getRequestDispatcher("/views/editProfile.jsp").forward(req, resp);
	}
}
