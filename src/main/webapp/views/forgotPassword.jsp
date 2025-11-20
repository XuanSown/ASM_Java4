<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
    <div class="container" style="max-width: 400px;">
        <div class="card shadow-sm">
            <div class="card-header bg-warning text-white text-center fw-bold">
                QUÊN MẬT KHẨU
            </div>
            <div class="card-body p-4">
                <c:if test="${not empty message}">
                    <div class="alert alert-${messageType == 'success' ? 'success' : 'danger'}">
                        ${message}
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/forgotPassword" method="post">
                    <div class="mb-3">
                        <label class="form-label">Tên đăng nhập (ID)</label>
                        <input type="text" name="id" class="form-control" required placeholder="Nhập ID của bạn">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email đăng ký</label>
                        <input type="email" name="email" class="form-control" required placeholder="Nhập email của bạn">
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-warning text-white fw-bold">Lấy Lại Mật Khẩu</button>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary">Quay lại Đăng nhập</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>