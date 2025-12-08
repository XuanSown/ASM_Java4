package servlet;

import java.io.IOException;
import java.util.List;

import dao.FavoriteDAO;
import dao.impl.FavoriteDAOImpl;
import entity.Favorite;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/favorites")
public class MyFavoriteServlet extends HttpServlet {

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

		if (currentUser == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		// lấy danh sách video đã thích của user
		List<Favorite> list = favDao.findByUserId(currentUser.getId());
		req.setAttribute("favorites", list);
		req.setAttribute("page", "/views/user/favorites.jsp");
		req.getRequestDispatcher("/views/userPageLayout.jsp").forward(req, resp);
	}

}
