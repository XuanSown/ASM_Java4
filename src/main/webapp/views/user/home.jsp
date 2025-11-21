<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


<div class="row g-4"> <c:forEach items="${items}" var="item">
        <div class="col-md-4 col-sm-6">
            <div class="card h-100 shadow-sm border-0">
                <a href="${pageContext.request.contextPath}/video/detail?id=${item.id}" class="position-relative text-decoration-none">
                    <img src="${item.poster}" class="card-img-top" alt="${item.title}" 
                         style="height: 200px; object-fit: cover;">
                    <div class="position-absolute top-50 start-50 translate-middle text-white" style="opacity: 0.8;">
                        <i class="bi bi-play-circle-fill display-4"></i>
                    </div>
                </a>

                <div class="card-body">
                    <h5 class="card-title text-truncate" title="${item.title}">
                        <a href="${pageContext.request.contextPath}/video/detail?id=${item.id}" class="text-decoration-none text-dark fw-bold">
                            ${item.title}
                        </a>
                    </h5>
                    <div class="d-flex justify-content-between align-items-center text-muted small">
                        <span><i class="bi bi-eye-fill me-1"></i><fmt:formatNumber value="${item.views}" /> lượt xem</span>
                    </div>
                </div>

                <div class="card-footer bg-white border-top-0 d-flex justify-content-between pb-3">
                    <button class="btn btn-success flex-grow-1 me-2">
                        <i class="bi bi-hand-thumbs-up-fill me-1"></i> Like
                    </button>
                    <button class="btn btn-warning text-white flex-grow-1">
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
            
            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/home?page=1">|&lt;</a>
            </li>

            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/home?page=${currentPage - 1}">&lt;&lt;</a>
            </li>

            <c:forEach begin="1" end="${maxPage}" var="i">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/home?page=${i}">${i}</a>
                </li>
            </c:forEach>

            <li class="page-item ${currentPage == maxPage ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/home?page=${currentPage + 1}">&gt;&gt;</a>
            </li>
            
             <li class="page-item ${currentPage == maxPage ? 'disabled' : ''}">
                <a class="page-link" href="${pageContext.request.contextPath}/home?page=${maxPage}">&gt;|</a>
            </li>
            
        </ul>
    </nav>
</div>