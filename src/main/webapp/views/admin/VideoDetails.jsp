<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<div class="card shadow-sm border-0">
    <div class="card-header bg-white py-3">
        <h5 class="mb-0 fw-bold text-primary">
            <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-plus-circle'} me-2"></i>
            ${isEdit ? 'Cập Nhật Video' : 'Thêm Video Mới'}
        </h5>
    </div>
    <div class="card-body">
        <c:if test="${not empty message}">
            <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/video/save" method="post">
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Mã Video (ID YouTube)</label>
                    <input type="text" name="id" class="form-control" value="${video.id}" required ${isEdit ? 'readonly' : ''} placeholder="Ví dụ: xk4_1vDrzzo">
                    <div class="form-text">Nhập ID lấy từ link YouTube (phần sau ?v=)</div>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label fw-bold">Tiêu đề video</label>
                    <input type="text" name="title" class="form-control" value="${video.title}" required placeholder="Nhập tên video...">
                </div>

                <div class="col-12">
                    <label class="form-label fw-bold">Link nhúng (Embed)</label>
                    <div class="input-group">
                        <span class="input-group-text">https://www.youtube.com/embed/</span>
                        <input type="text" class="form-control" value="${video.id}" disabled readonly placeholder="Tự động tạo từ Mã Video">
                    </div>
                </div>

                <div class="col-12">
                    <label class="form-label fw-bold">Hình Poster (Thumbnail)</label>
                    <input type="text" name="poster" class="form-control" value="${video.poster}" placeholder="Link ảnh hoặc để trống để lấy tự động từ YouTube">
                </div>

                <div class="col-12">
                    <label class="form-label fw-bold">Mô tả</label>
                    <textarea name="description" class="form-control" rows="4" placeholder="Nhập mô tả video...">${video.description}</textarea>
                </div>

                <div class="col-md-6">
                    <label class="form-label fw-bold">Trạng thái</label>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="active" value="true" ${video.active ? 'checked' : ''} ${empty video ? 'checked' : ''}>
                        <label class="form-check-label">Hiển thị video này</label>
                    </div>
                </div>
            </div>
            
            <div class="mt-4 pt-3 border-top d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4">
                    <i class="bi bi-save me-1"></i> Lưu Lại
                </button>
                <a href="${pageContext.request.contextPath}/admin/video/list" class="btn btn-secondary px-4">Quay lại</a>
            </div>
        </form>
    </div>
</div>