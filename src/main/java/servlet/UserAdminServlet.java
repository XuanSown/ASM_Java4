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

@WebServlet({ "/admin/user/update", "/admin/user/delete", "/admin/user/create" })
public class UserAdminServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAOImpl();

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String uri = req.getRequestURI();
		if (uri.contains("update")) {
			update(req, resp);
		} else if (uri.contains("delete")) {
			delete(req, resp);
		} else if (uri.contains("create")) {
			create(req, resp);
		}
	}

	// hàm create
	private void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			User user = new User();
			user.setId(req.getParameter("id"));
			user.setPassword(req.getParameter("password"));
			user.setFullname(req.getParameter("fullname"));
			user.setEmail(req.getParameter("email"));
			boolean isAdmin = req.getParameter("admin") != null;
			user.setAdmin(isAdmin);

			// Kiểm tra trùng lặp
			if (userDAO.findById(user.getId()) != null) {
				req.setAttribute("message", "Tên đăng nhập đã tồn tại!");
				req.setAttribute("messageType", "danger");
			} else if (userDAO.findByEmail(user.getEmail()) != null) {
				req.setAttribute("message", "Email đã được sử dụng!");
				req.setAttribute("messageType", "danger");
			} else {
				userDAO.create(user);
				req.setAttribute("message", "Thêm người dùng mới thành công!");
				req.setAttribute("messageType", "success");
			}
		} catch (Exception e) {
			req.setAttribute("message", "Lỗi: " + e.getMessage());
			req.setAttribute("messageType", "danger");
		}
		// Load lại danh sách
		req.getRequestDispatcher("/admin/userManager").forward(req, resp);
	}

	// hàm update
	private void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String id = req.getParameter("id");
			User user = userDAO.findById(id);

			if (user != null) {
				// Cập nhật thông tin từ form
				user.setFullname(req.getParameter("fullname"));
				user.setEmail(req.getParameter("email"));

				// Cập nhật vai trò (Admin/User)
				boolean isAdmin = req.getParameter("admin") != null;
				user.setAdmin(isAdmin);

				userDAO.update(user);

				req.setAttribute("message", "Cập nhật người dùng thành công!");
				req.setAttribute("messageType", "success");
			}
		} catch (Exception e) {
			req.setAttribute("message", "Lỗi cập nhật: " + e.getMessage());
			req.setAttribute("messageType", "danger");
		}
		// Load lại danh sách
		req.getRequestDispatcher("/admin/userManager").forward(req, resp);
	}

	// hàm delete
	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String id = req.getParameter("id");
			// Kiểm tra không cho xóa chính mình
			User currentUser = (User) req.getSession().getAttribute("currentUser");
			if (currentUser != null && currentUser.getId().equals(id)) {
				req.setAttribute("message", "Không thể xóa tài khoản đang đăng nhập!");
				req.setAttribute("messageType", "danger");
			} else {
				userDAO.delete(id);
				req.setAttribute("message", "Xóa người dùng thành công!");
				req.setAttribute("messageType", "success");
			}
		} catch (Exception e) {
			req.setAttribute("message", "Không thể xóa (User này đã có dữ liệu Like/Share)!");
			req.setAttribute("messageType", "danger");
		}
		req.getRequestDispatcher("/admin/userManager").forward(req, resp);
	}
}
