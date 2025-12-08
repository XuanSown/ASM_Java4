<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>


<div class="row g-4">
	<c:forEach items="${items}" var="item">
		<div class="col-md-4 col-sm-6">
			<div class="card h-100 shadow-sm border-0">
				<a
					href="${pageContext.request.contextPath}/video/detail?id=${item.id}"
					class="position-relative text-decoration-none"> <img
					src="${item.poster}" class="card-img-top" alt="${item.title}"
					style="height: 200px; object-fit: cover;">
					<div
						class="position-absolute top-50 start-50 translate-middle text-white"
						style="opacity: 0.8;">
						<i class="bi bi-play-circle-fill display-4"></i>
					</div>
				</a>

				<div class="card-body">
					<h5 class="card-title text-truncate" title="${item.title}">
						<a
							href="${pageContext.request.contextPath}/video/detail?id=${item.id}"
							class="text-decoration-none text-dark fw-bold"> ${item.title}
						</a>
					</h5>
					<div
						class="d-flex justify-content-between align-items-center text-muted small">
						<span><i class="bi bi-eye-fill me-1"></i> <fmt:formatNumber
								value="${item.views}" /> lượt xem</span>
					</div>
				</div>

				<div
					class="card-footer bg-white border-top-0 d-flex justify-content-between pb-3">
					<a
						href="${pageContext.request.contextPath}/video/like?id=${item.id}"
						class="btn btn-success flex-grow-1 me-2"> <i
						class="bi bi-hand-thumbs-up-fill me-1"></i> Like
					</a>
					<button type="button"
						class="btn btn-warning text-white flex-grow-1"
						data-bs-toggle="modal" data-bs-target="#shareModal"
						onclick="shareVideo('${item.id}')">
						<i class="bi bi-share-fill me-1"></i> Share
					</button>
				</div>
			</div>
		</div>
	</c:forEach>
</div>

<div class="d-flex justify-content-center mt-5">
	<nav aria-label="Page navigation">
		<ul class="pagination shadow-sm">

			<li class="page-item ${currentPage == 1 ? 'disabled' : ''}"><a
				class="page-link"
				href="${pageContext.request.contextPath}/home?page=1">|&lt;</a></li>

			<li class="page-item ${currentPage == 1 ? 'disabled' : ''}"><a
				class="page-link"
				href="${pageContext.request.contextPath}/home?page=${currentPage - 1}">&lt;&lt;</a>
			</li>

			<c:forEach begin="1" end="${maxPage}" var="i">
				<li class="page-item ${currentPage == i ? 'active' : ''}"><a
					class="page-link"
					href="${pageContext.request.contextPath}/home?page=${i}">${i}</a></li>
			</c:forEach>

			<li class="page-item ${currentPage == maxPage ? 'disabled' : ''}">
				<a class="page-link"
				href="${pageContext.request.contextPath}/home?page=${currentPage + 1}">&gt;&gt;</a>
			</li>

			<li class="page-item ${currentPage == maxPage ? 'disabled' : ''}">
				<a class="page-link"
				href="${pageContext.request.contextPath}/home?page=${maxPage}">&gt;|</a>
			</li>

		</ul>
	</nav>
</div>

<!-- modal của share -->
<div class="modal fade" id="shareModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold">Chia sẻ Video</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/video/share" method="post">
                <div class="modal-body">
                    <input type="hidden" name="videoId" id="shareVideoId">
                    
                    <div class="mb-3">
                        <label class="form-label">Nhập Email người nhận:</label>
                        <input type="email" name="email" class="form-control" placeholder="name@example.com" required>
                        <div class="form-text">Hệ thống sẽ gửi đường dẫn video này qua email cho họ.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-send-fill me-1"></i> Gửi ngay
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function shareVideo(id) {
        // Tìm ô input ẩn có id="shareVideoId" và gán giá trị ID video vào
        var inputId = document.getElementById('shareVideoId');
        inputId.value = id;
    }
</script>