<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<div class="card shadow-sm border-0">
	<div class="card-header bg-white py-3">
		<div class="d-flex justify-content-between align-items-center w-100">
			<h5 class="mb-0 fw-bold text-primary">
				<i class="bi bi-people-fill me-2"></i>Quản Lý Người Dùng
			</h5>
			<button class="btn btn-primary btn-sm" data-bs-toggle="modal"
				data-bs-target="#createUserModal">
				<i class="bi bi-plus-lg me-1"></i> Thêm Mới
			</button>
		</div>
	</div>
	<div class="card-body p-0">
		<c:if test="${not empty message}">
			<div
				class="alert alert-${messageType} m-3 alert-dismissible fade show">
				${message}
				<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			</div>
		</c:if>

		<div class="table-responsive">
			<table class="table table-hover align-middle mb-0">
				<thead class="bg-light text-secondary">
					<tr>
						<th class="ps-4">Tên đăng nhập (ID)</th>
						<th>Họ và tên</th>
						<th>Email</th>
						<th>Vai trò</th>
						<th class="text-end pe-4">Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${users}" var="u">
						<tr>
							<td class="ps-4 fw-bold">${u.id}</td>
							<td>${u.fullname}</td>
							<td>${u.email}</td>
							<td><span
								class="badge ${u.admin ? 'bg-primary' : 'bg-secondary'}">
									${u.admin ? 'Admin' : 'User'} </span></td>
							<td class="text-end pe-4">
								<button class="btn btn-sm btn-outline-primary me-1"
									onclick="editUser('${u.id}', '${u.fullname}', '${u.email}', ${u.admin})">
									<i class="bi bi-pencil-square"></i>
								</button>
								<button class="btn btn-sm btn-outline-danger"
									data-bs-toggle="modal" data-bs-target="#deleteUserModal"
									onclick="confirmDeleteUser('${u.id}')">
									<i class="bi bi-trash"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="modal fade" id="editUserModal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<h5 class="modal-title">Cập Nhật Thông Tin</h5>
				<button type="button" class="btn-close btn-close-white"
					data-bs-dismiss="modal"></button>
			</div>
			<form action="${pageContext.request.contextPath}/admin/user/update"
				method="post">
				<div class="modal-body">
					<div class="mb-3">
						<label class="form-label">Tên đăng nhập</label> <input type="text"
							name="id" id="editId" class="form-control" readonly>
					</div>
					<div class="mb-3">
						<label class="form-label">Họ và tên</label> <input type="text"
							name="fullname" id="editFullname" class="form-control" required>
					</div>
					<div class="mb-3">
						<label class="form-label">Email</label> <input type="email"
							name="email" id="editEmail" class="form-control" required>
					</div>
					<div class="mb-3 form-check">
						<input type="checkbox" name="admin" id="editAdmin"
							class="form-check-input" value="true"> <label
							class="form-check-label fw-bold" for="editAdmin">Là Quản
							trị viên (Admin)</label>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Hủy</button>
					<button type="submit" class="btn btn-primary">Lưu thay đổi</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- Modal xóa -->
<div class="modal fade" id="deleteUserModal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Xác nhận xóa</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body">
				Bạn có chắc chắn muốn xóa người dùng <strong id="deleteUserIdText"></strong>
				không? <br> <span class="text-danger small">* Hành động
					này không thể hoàn tác.</span>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Hủy</button>
				<a id="btnConfirmDeleteUser" href="#" class="btn btn-danger">Xóa
					ngay</a>
			</div>
		</div>
	</div>
</div>

<!-- Modal create -->
<div class="modal fade" id="createUserModal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header bg-success text-white">
				<h5 class="modal-title">Thêm Người Dùng Mới</h5>
				<button type="button" class="btn-close btn-close-white"
					data-bs-dismiss="modal"></button>
			</div>
			<form action="${pageContext.request.contextPath}/admin/user/create"
				method="post">
				<div class="modal-body">
					<div class="mb-3">
						<label class="form-label">Tên đăng nhập (ID)</label> <input
							type="text" name="id" class="form-control" required
							placeholder="Nhập ID...">
					</div>
					<div class="mb-3">
						<label class="form-label">Mật khẩu</label> <input type="password"
							name="password" class="form-control" required
							placeholder="Nhập mật khẩu...">
					</div>
					<div class="mb-3">
						<label class="form-label">Họ và tên</label> <input type="text"
							name="fullname" class="form-control" required
							placeholder="Nhập họ tên...">
					</div>
					<div class="mb-3">
						<label class="form-label">Email</label> <input type="email"
							name="email" class="form-control" required
							placeholder="name@example.com">
					</div>
					<div class="mb-3 form-check">
						<input type="checkbox" name="admin" id="createAdmin"
							class="form-check-input" value="true"> <label
							class="form-check-label fw-bold" for="createAdmin">Là
							Quản trị viên (Admin)</label>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Hủy</button>
					<button type="submit" class="btn btn-success">Tạo mới</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
    function editUser(id, fullname, email, isAdmin) {
        document.getElementById('editId').value = id;
        document.getElementById('editFullname').value = fullname;
        document.getElementById('editEmail').value = email;
        document.getElementById('editAdmin').checked = isAdmin;
        
        // Mở Modal
        var myModal = new bootstrap.Modal(document.getElementById('editUserModal'));
        myModal.show();
    }

    function confirmDeleteUser(id) {
        document.getElementById('deleteUserIdText').innerText = id;
        document.getElementById('btnConfirmDeleteUser').href = "${pageContext.request.contextPath}/admin/user/delete?id=" + id;
    }
</script>