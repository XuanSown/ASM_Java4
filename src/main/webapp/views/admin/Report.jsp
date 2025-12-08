<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>

<div class="card shadow-sm border-0">
    <div class="card-header bg-white py-3">
        <h5 class="mb-0 fw-bold text-primary"><i class="bi bi-bar-chart-line-fill me-2"></i>Báo Cáo & Thống Kê</h5>
    </div>
    <div class="card-body">
        
        <ul class="nav nav-tabs mb-4" id="reportTab" role="tablist">
            <li class="nav-item">
                <button class="nav-link ${empty param.videoUserId && empty param.videoShareId ? 'active' : ''}" id="fav-tab" data-bs-toggle="tab" data-bs-target="#favorites" type="button">
                    Favorites
                </button>
            </li>
            <li class="nav-item">
                <button class="nav-link ${not empty param.videoUserId ? 'active' : ''}" id="fav-user-tab" data-bs-toggle="tab" data-bs-target="#favUsers" type="button">
                    Favorite Users
                </button>
            </li>
            <li class="nav-item">
                <button class="nav-link ${not empty param.videoShareId ? 'active' : ''}" id="share-tab" data-bs-toggle="tab" data-bs-target="#sharedFriends" type="button">
                    Shared Friends
                </button>
            </li>
        </ul>

        <div class="tab-content" id="reportTabContent">
            
            <div class="tab-pane fade ${empty param.videoUserId && empty param.videoShareId ? 'show active' : ''}" id="favorites">
                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Tiêu Đề Video</th>
                            <th>Số Lượt Thích</th>
                            <th>Ngày Thích Cũ Nhất</th>
                            <th>Ngày Thích Mới Nhất</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${favList}" var="item">
                            <tr>
                                <td>${item[0]}</td>
                                <td class="fw-bold text-center">${item[1]}</td>
                                <td><fmt:formatDate value="${item[2]}" pattern="dd-MM-yyyy"/></td>
                                <td><fmt:formatDate value="${item[3]}" pattern="dd-MM-yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="tab-pane fade ${not empty param.videoUserId ? 'show active' : ''}" id="favUsers">
                <form action="${pageContext.request.contextPath}/admin/report" method="get" class="row g-3 align-items-center mb-4">
                    <div class="col-auto">
                        <label class="col-form-label fw-bold">Chọn Video:</label>
                    </div>
                    <div class="col-auto">
                        <select name="videoUserId" class="form-select" onchange="this.form.submit()">
                            <option value="">-- Chọn video để xem --</option>
                            <c:forEach items="${videos}" var="v">
                                <option value="${v.id}" ${v.id == videoUserId ? 'selected' : ''}>${v.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>

                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Tên Đăng Nhập</th>
                            <th>Họ và Tên</th>
                            <th>Email</th>
                            <th>Ngày Thích</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${favUsers}" var="f">
                            <tr>
                                <td>${f.user.id}</td>
                                <td>${f.user.fullname}</td>
                                <td>${f.user.email}</td>
                                <td><fmt:formatDate value="${f.likeDate}" pattern="dd-MM-yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="tab-pane fade ${not empty param.videoShareId ? 'show active' : ''}" id="sharedFriends">
                <form action="${pageContext.request.contextPath}/admin/report" method="get" class="row g-3 align-items-center mb-4">
                    <div class="col-auto">
                        <label class="col-form-label fw-bold">Chọn Video:</label>
                    </div>
                    <div class="col-auto">
                        <select name="videoShareId" class="form-select" onchange="this.form.submit()">
                            <option value="">-- Chọn video để xem --</option>
                            <c:forEach items="${videos}" var="v">
                                <option value="${v.id}" ${v.id == videoShareId ? 'selected' : ''}>${v.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>

                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Người Gửi (User)</th>
                            <th>Email Người Gửi</th>
                            <th>Email Người Nhận</th>
                            <th>Ngày Gửi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${shareList}" var="s">
                            <tr>
                                <td>${s.user.fullname} (${s.user.id})</td>
                                <td>${s.user.email}</td>
                                <td>${s.emails}</td>
                                <td><fmt:formatDate value="${s.shareDate}" pattern="dd-MM-yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>