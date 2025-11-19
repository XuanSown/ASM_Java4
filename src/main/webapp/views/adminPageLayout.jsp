<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Entertainment</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="d-flex flex-column min-vh-100">

    <header class="bg-primary text-white text-center py-4">
        <h1 class="display-4 fw-bold">SOWN TUBE</h1>
    </header>

    <nav class="navbar navbar-expand-lg navbar-light bg-warning">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">Online Entertainment</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/videoManager">Video Manager</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/userManager">User Manager</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/report">Report</a>
                    </li>
                </ul>

                <ul class="navbar-nav ms-auto align-items-center">
                    <c:choose>
                        <c:when test="${empty sessionScope.currentUser}">
                            <li class="nav-item">
                                <a class="btn btn-outline-dark me-2" href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-dark" href="${pageContext.request.contextPath}/register">Đăng ký</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item me-3">
                                <span>Xin chào, <b>${sessionScope.currentUser.fullname}</b></span>
                            </li>
                            
                            <c:if test="${sessionScope.currentUser.admin}">
                                <li class="nav-item">
                                    <a class="btn btn-danger btn-sm me-2" href="${pageContext.request.contextPath}/admin/videoManager">Quản trị</a>
                                </li>
                            </c:if>
                            
                            <li class="nav-item">
                                <a class="btn btn-secondary btn-sm" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-4 flex-grow-1">
        <div class="card shadow-sm p-4" style="min-height: 500px;">
            <jsp:include page="${page}"></jsp:include>
        </div>
    </div>

    <footer class="bg-primary text-white text-center py-2 mt-auto">
        <p class="mb-0 fs-10">XuanSown© - Công Ty Trách Nhiệm Hữu Hạn Một Thành Viên</p>
    </footer>

</body>
</html>