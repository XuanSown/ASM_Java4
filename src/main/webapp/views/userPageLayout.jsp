<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sown Tube</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* Font chữ và màu nền */
        body {
            background-color: #f8f9fa; /* Màu xám rất nhạt cho nền web */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Hiệu ứng cho Banner */
        .hero-header {
            background: linear-gradient(135deg, #0d6efd 0%, #0dcaf0 100%); /* Gradient Xanh dương */
            color: white;
            padding: 1rem 0;
            margin-bottom: 1rem;
            border-radius: 0 0 20px 20px; /* Bo tròn góc dưới */
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        /* Card nội dung */
        .content-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 20px;
            min-height: 500px;
        }

        /* Navbar tùy chỉnh */
        .navbar-brand {
            font-weight: 800;
            letter-spacing: 1px;
            color: #0d6efd !important;
        }
        
        /* Thanh tìm kiếm */
        .search-bar {
            max-width: 500px;
            width: 100%;
        }
        .search-input {
            border-radius: 20px 0 0 20px;
            border: 1px solid #ced4da;
            padding-left: 15px;
        }
        .search-btn {
            border-radius: 0 20px 20px 0;
            border: 1px solid #ced4da;
            border-left: none;
            background-color: #f8f9fa;
        }
        .search-btn:hover {
            background-color: #e9ecef;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
        <div class="container">
            <a class="navbar-brand fs-3" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-play-circle-fill text-primary me-2"></i>SOWN TUBE
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="userNavbar">
                <form class="d-flex mx-auto search-bar my-2 my-lg-0">
                    <input class="form-control search-input shadow-none" type="search" placeholder="Tìm kiếm video..." aria-label="Search">
                    <button class="btn search-btn" type="submit">
                        <i class="bi bi-search text-secondary"></i>
                    </button>
                </form>

                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/favorites"></i> Yêu thích</a>
                    </li>
                    <li class="nav-item me-2">
                        <a class="nav-link fw-semibold" href="#"></i> Thịnh hành</a>
                    </li>

                    <c:choose>
                        <c:when test="${empty sessionScope.currentUser}">
                            <li class="nav-item ms-2">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary rounded-pill px-4 me-2">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/register" class="btn btn-primary rounded-pill px-4">Đăng ký</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item dropdown ms-3">
                                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <div class="bg-primary text-white rounded-circle d-flex justify-content-center align-items-center me-2" style="width: 35px; height: 35px;">
                                        <i class="bi bi-person-fill"></i>
                                    </div>
                                    <span class="fw-bold text-dark">${sessionScope.currentUser.fullname}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/editProfile"><i class="bi bi-person-gear me-2"></i>Hồ sơ cá nhân</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/changePassword"><i class="bi bi-key me-2"></i>Đổi mật khẩu</a></li>
                                    
                                    <c:if test="${sessionScope.currentUser.admin}">
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/admin/videoManager">
                                                <i class="bi bi-shield-lock me-2"></i>Trang Quản Trị
                                            </a>
                                        </li>
                                    </c:if>
                                    
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <header class="hero-header text-center">
        <div class="container">
            <h1 class="display-5 fw-bold">Khám Phá Thế Giới Giải Trí</h1>
            <p class="lead mb-0">Nền tảng chia sẻ video giải trí hàng đầu dành cho sinh viên FPT Polytechnic</p>
        </div>
    </header>

    <div class="container flex-grow-1">
        <div class="content-card">
            <jsp:include page="${page}"></jsp:include>
        </div>
    </div>

    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6 mb-3 mb-md-0">
                    <h1 class="text-primary fw-bold">SOWN TUBE</h5>
                </div>
                <div class="col-md-3 mb-3 mb-md-0">
                    <h6 class="fw-bold">Liên kết nhanh</h6>
                    <ul class="list-unstyled small">
                        <li><a href="#" class="text-decoration-none text-light">Trang chủ</a></li>
                        <li><a href="#" class="text-decoration-none text-light">Thịnh hành</a></li>
                        <li><a href="#" class="text-decoration-none text-light">Liên hệ</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h6 class="fw-bold">Theo dõi chúng tôi</h6>
                    <div class="d-flex gap-3 fs-5">
                        <a href="#" class="text-light"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="text-light"><i class="bi bi-youtube"></i></a>
                        <a href="#" class="text-light"><i class="bi bi-tiktok"></i></a>
                    </div>
                </div>
            </div>
            <hr class="border-secondary my-3">
            <div class="text-center small text-secondary">
                &copy; 2025 XuanSown - Công Ty TNHH MTV. All rights reserved.
            </div>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<!-- thông báo like -->
	<c:if test="${not empty sessionScope.toastMessage}">
        <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1055;">
            <div id="liveToast" class="toast show align-items-center text-white bg-${sessionScope.toastType} border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        ${sessionScope.toastMessage}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>
        
        <script>
            // Tự động ẩn Toast sau 3 giây
            setTimeout(function() {
                var toastElement = document.getElementById('liveToast');
                if (toastElement) {
                    var bsToast = new bootstrap.Toast(toastElement);
                    bsToast.hide();
                }
            }, 3000);
        </script>

        <%
            session.removeAttribute("toastMessage");
            session.removeAttribute("toastType");
        %>
    </c:if>

</body>
</html>