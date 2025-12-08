<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<div class="card border-0 shadow-sm">
	<div class="card-header bg-white border-bottom">
		<h4 class="card-title fw-bold text-danger mb-0">
			<i class="bi bi-heart-fill me-2"></i>Video Yêu Thích Của Tôi
		</h4>
	</div>
	<div class="card-body">
		<c:if test="${empty favorites}">
			<div class="text-center py-5">
				<i class="bi bi-emoji-frown display-1 text-muted"></i>
				<p class="mt-3 text-muted">Bạn chưa yêu thích video nào.</p>
				<a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Khám phá ngay</a>
			</div>
		</c:if>

		<div class="row g-3">
			<c:forEach items="${favorites}" var="item">
				<div class="col-md-3 col-sm-6">
					<div class="card h-100 shadow-sm border-0">
						<a href="${pageContext.request.contextPath}/video/detail?id=${item.video.id}" class="position-relative">
							<img src="${item.video.poster}" class="card-img-top" alt="${item.video.title}" style="height: 150px; object-fit: cover;">
							<div class="position-absolute top-50 start-50 translate-middle text-white" style="opacity: 0.8;">
								<i class="bi bi-play-circle-fill fs-3"></i>
							</div>
						</a>
						<div class="card-body p-2">
							<h6 class="card-title text-truncate" title="${item.video.title}">
								<a href="${pageContext.request.contextPath}/video/detail?id=${item.video.id}" class="text-decoration-none text-dark">
									${item.video.title}
								</a>
							</h6>
							<small class="text-muted d-block mb-2">
								Đã thích: <fmt:formatDate value="${item.likeDate}" pattern="dd/MM/yyyy"/>
							</small>
							<a href="${pageContext.request.contextPath}/video/like?id=${item.video.id}" class="btn btn-sm btn-outline-danger w-100">
								<i class="bi bi-heartbreak-fill me-1"></i> Bỏ thích
							</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>