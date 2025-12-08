<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>

<div class="row">
	<div class="col-lg-8">
		<div class="card shadow-sm border-0 mb-4">
			<div class="ratio ratio-16x9">
				<iframe src="${item.link }" title="${item.title }" allowfullscreen></iframe>
			</div>

			<div class="card-body">
				<h4 class="card-title fw-bold text-primary">${item.title}</h4>
				<div
					class="d-flex justify-content-between align-items-center text-muted border-bottom pb-3 mb-3">
					<span><i class="bi bi-eye-fill me-1"></i>
					<fmt:formatNumber value="${item.views }"></fmt:formatNumber>lượt
						xem</span>

					<div>
						<a
							href="${pageContext.request.contextPath}/video/like?id=${item.id}"
							class="btn btn-sm ${isLiked ? 'btn-danger' : 'btn-outline-danger'} me-2">
							<i class="bi ${isLiked ? 'bi-heart-fill' : 'bi-heart'}"></i>
							${isLiked ? 'Đã thích' : 'Yêu thích'}
						</a>
						<button type="button" class="btn btn-outline-primary btn-sm"
							data-bs-toggle="modal" data-bs-target="#shareModal">
							<i class="bi bi-share-fill"></i> Chia sẻ
						</button>
					</div>
				</div>

				<div class="bg-light p-3 rounded">
					<h6 class="fw-bold">Mô tả:</h6>
					<p class="mb-0" style="white-space: pre-line;">${item.description}</p>
				</div>
			</div>
		</div>

		<div class="card shadow-sm border-0">
			<div class="card-body">
				<h5 class="fw-bold">Bình luận</h5>
				<p class="text-muted">Chức năng bình luận đang được phát
					triển...</p>
			</div>
		</div>
	</div>

	<div class="col-lg-4">
		<h5 class="fw-bold mb-3 border-start border-4 border-primary ps-2">Gợi
			Ý Cho Bạn</h5>
		<div class="list-group list-group-flush">
			<c:forEach items="${recommendations}" var="v">
				<c:if test="${v.id != item.id}">
					<a
						href="${pageContext.request.contextPath}/video/detail?id=${v.id}"
						class="list-group-item list-group-item-action d-flex gap-3 py-3 border-0 border-bottom">
						<img src="${v.poster}" alt="${v.title}" class="rounded"
						style="width: 120px; height: 68px; object-fit: cover;">
						<div class="d-flex flex-column justify-content-between">
							<h6 class="mb-0 text-truncate-2"
								style="font-size: 0.95rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">${v.title}</h6>
							<small class="text-muted"><i class="bi bi-eye me-1"></i>
							<fmt:formatNumber value="${v.views}" /></small>
						</div>
					</a>
				</c:if>
			</c:forEach>
		</div>
	</div>
</div>

<!-- Modal cho share -->
<div class="modal fade" id="shareModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-bold">Chia sẻ Video</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="${pageContext.request.contextPath}/video/share" method="post">
          <div class="modal-body">
            <input type="hidden" name="videoId" value="${item.id}">
            
            <div class="mb-3">
                <label class="form-label">Nhập Email bạn bè:</label>
                <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                <div class="form-text">Chúng tôi sẽ gửi liên kết video này tới họ.</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            <button type="submit" class="btn btn-primary"><i class="bi bi-send-fill me-1"></i> Gửi ngay</button>
          </div>
      </form>
    </div>
  </div>
</div>