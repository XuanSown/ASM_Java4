<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hệ Thống Quản Trị - Sown Tube</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
.admin-card {
	border: none;
	box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
		<div class="container-fluid px-4">
			<a class="navbar-brand fw-bold text-uppercase"
				href="${pageContext.request.contextPath}/admin/videoManager">
				Admin Panel </a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#adminNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="adminNavbar">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/admin/videoManager">Quản
							lý Video </a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/admin/userManager">Quản lý Người dùng
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/admin/report">Báo cáo - Thống kê
					</a></li>
				</ul>

				<ul class="navbar-nav ms-auto align-items-center">
					<li class="nav-item me-3"><a
						href="${pageContext.request.contextPath}/home"
						class="btn btn-outline-light btn-sm" target="_blank"> <i
							class="bi bi-box-arrow-up-right me-1"></i> Xem Trang Chủ
					</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle text-white d-flex align-items-center"
						href="#" role="button" data-bs-toggle="dropdown"> <i
							class="bi bi-person-circle fs-5 me-2"></i> <span>${sessionScope.currentUser.fullname}</span>
					</a>
						<ul class="dropdown-menu dropdown-menu-end shadow">
							<li><h6 class="dropdown-header">Tài khoản quản trị</h6></li>
							<li><a class="dropdown-item" href="#"><i
									class="bi bi-gear me-2"></i>Cài đặt</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item text-danger"
								href="${pageContext.request.contextPath}/logout"> <i
									class="bi bi-box-arrow-right me-2"></i>Đăng xuất
							</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container-fluid px-4 mt-4 flex-grow-1">
		<div class="row">
			<div class="col-12">
				<div class="card admin-card bg-white">
					<div class="card-header bg-white border-bottom py-3">
						<nav aria-label="breadcrumb">
							<ol class="breadcrumb mb-0">
								<li class="breadcrumb-item"><a href="#"
									class="text-decoration-none">Admin</a></li>
								<li class="breadcrumb-item active" aria-current="page">Dashboard</li>
							</ol>
						</nav>
					</div>
					<div class="card-body" style="min-height: 550px;">
						<jsp:include page="${page}"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>

	<footer class="bg-white text-center py-3 mt-4 border-top">
		<div class="container">
			<p class="mb-0 text-muted small">
				&copy; 2025 <b>Sown Tube System</b>. All rights reserved.
			</p>
		</div>
	</footer>

</body>
</html>