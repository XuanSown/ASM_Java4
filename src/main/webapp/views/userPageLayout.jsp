<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
header,footer{
height:100px;
line-height: 100px;
background-color:blue;
color: white;
text-align: center; 
font-size: 30px;}
.content{
min-height: 500px;
}
nav{
text-align: center;
height: 30px;
line-height: 40px;
background-color:  gold;
}
</style>
</head>
<body>
	<header>Header</header>
	<nav>
		<a href="${pageContext.request.contextPath}/home">Online Entertainment </a> |
		<a href="${pageContext.request.contextPath}/admin/videoManager">Video Manager </a> |
		<a href="${pageContext.request.contextPath}/admin/userManager">User Manager </a> |
		<a href="${pageContext.request.contextPath}/admin/report">Report </a> |
	</nav>
	<div class="content">
		<jsp:include page="${page}"></jsp:include>
	</div>
	<footer>Footer</footer>
</body>
</html>