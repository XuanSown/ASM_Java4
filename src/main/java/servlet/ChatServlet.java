package servlet;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import dao.ChatDAO;
import dao.impl.ChatDAOImpl;
import entity.ChatMessage;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChatDAO chatDao = new ChatDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Lấy danh sách tin nhắn để hiển thị
		List<ChatMessage> list = chatDao.findTop50();
		req.setAttribute("messages", list);
		// Trả về file JSP con chứa nội dung chat (không trả về layout)
		req.getRequestDispatcher("/views/user/chat-content.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		User currentUser = (User) req.getSession().getAttribute("currentUser");

		if (currentUser != null) {
			String content = req.getParameter("content");
			if (content != null && !content.trim().isEmpty()) {
				ChatMessage msg = new ChatMessage();
				msg.setContent(content);
				msg.setUser(currentUser);
				msg.setCreatedDate(new Timestamp(System.currentTimeMillis()));
				chatDao.create(msg);
			}
		}
		// Sau khi gửi xong thì không cần redirect, Ajax sẽ tự load lại
	}
}