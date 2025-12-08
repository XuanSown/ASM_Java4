<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:forEach items="${messages}" var="msg">
	<div class="mb-2 ${msg.user.id == sessionScope.currentUser.id ? 'text-end' : 'text-start'}">
		<div class="d-inline-block p-2 rounded 
			${msg.user.id == sessionScope.currentUser.id ? 'bg-primary text-white' : 'bg-light text-dark border'}">
			<small class="fw-bold d-block" style="font-size: 0.75rem; opacity: 0.8;">
				${msg.user.fullname}
			</small>
			<span>${msg.content}</span>
		</div>
	</div>
</c:forEach>