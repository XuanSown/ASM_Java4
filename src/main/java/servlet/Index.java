package servlet;

import java.io.IOException;

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

	public Index() {
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String uri = req.getRequestURI();
		if (uri.contains("/home")) {
			req.setAttribute("page", "/views/user/home.jsp");
		}
		if (uri.contains("/admin/videoManager")) {
			req.setAttribute("page", "/views/admin/VideoManager.jsp");
		}
		if (uri.contains("/admin/userManager")) {
			req.setAttribute("page", "/views/admin/UserManager.jsp");
		}
		if (uri.contains("/admin/video/details")) {
			req.setAttribute("page", "/views/admin/VideoManager.jsp");
			req.setAttribute("sublpage", "/views/admin/VideoDetails.jsp");
		}
		if (uri.contains("/admin/video/list")) {
			req.setAttribute("page", "/views/admin/VideoManager.jsp");
			req.setAttribute("sublpage", "/views/admin/VideoList.jsp");
		}
		req.getRequestDispatcher("/views/adminPageLayout.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}
}
