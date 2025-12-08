<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<div class="card shadow-sm border-0">
	<div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
		<h5 class="mb-0 fw-bold text-primary"><i class="bi bi-collection-play me-2"></i>Danh Sách Video</h5>
		<a href="${pageContext.request.contextPath}/admin/video/details" class="btn btn-primary btn-sm">
			<i class="bi bi-plus-lg me-1"></i> Thêm Mới
		</a>
	</div>
	<div class="card-body p-0">
		<div class="table-responsive">
			<table class="table table-hover align-middle mb-0">
				<thead class="bg-light text-secondary">
					<tr>
						<th class="ps-4">Mã Video</th>
						<th>Tiêu đề</th>
						<th>Lượt xem</th>
						<th>Trạng thái</th>
						<th class="text-end pe-4">Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${videos}" var="item">
						<tr>
							<td class="ps-4 fw-bold text-muted">${item.id}</td>
							<td>
								<div class="d-flex align-items-center">
									<img src="${item.poster}" class="rounded me-3" style="width: 60px; height: 34px; object-fit: cover;">
									<span class="d-inline-block text-truncate" style="max-width: 250px;">${item.title}</span>
								</div>
							</td>
							<td>${item.views}</td>
							<td>
								<span class="badge ${item.active ? 'bg-success-subtle text-success' : 'bg-danger-subtle text-danger'} rounded-pill">
									${item.active ? 'Hoạt động' : 'Đã ẩn'}
								</span>
							</td>
							<td class="text-end pe-4">
								<a href="${pageContext.request.contextPath}/admin/video/edit?id=${item.id}" class="btn btn-sm btn-outline-primary me-1">
									<i class="bi bi-pencil-square"></i> Sửa
								</a>
								<button onclick="confirmDelete('${item.id}', '${item.title}')" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
									<i class="bi bi-trash"></i> Xóa
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Xác nhận xóa</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Bạn có chắc muốn xóa video <strong id="deleteVideoTitle"></strong> không?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
        <a id="btnConfirmDelete" href="#" class="btn btn-danger">Xóa ngay</a>
      </div>
    </div>
  </div>
</div>

<script>
	function confirmDelete(id, title) {
		document.getElementById('deleteVideoTitle').innerText = title;
		document.getElementById('btnConfirmDelete').href = "${pageContext.request.contextPath}/admin/video/delete?id=" + id;
	}
</script>