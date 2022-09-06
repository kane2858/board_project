<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PROJOB_JOIN</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/footer.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/header1.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/reset.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/all.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/login.css">
<link rel="shortcut icon" type="image/x-icon"
	href="<%=request.getContextPath() %>/resources/images/PROJOB_TITLE.png">
</head>

<body>
	<c:if test="${!empty msg}">
		<script>
			alert('${msg}');
		</script>
	</c:if>
	<div class="login">
		<form action="<%=request.getContextPath()%>/login/selectInfo" method="post">
			<div class="logincontent">
				<c:choose>
					<c:when test="${!empty m_id}">
						<label class="loginlabel fontname" for="us_id">아이디</label> <input
						type="text" class="inputlogin" id="us_id" name="m_id"
						value="${m_id}"
						style="font-family: 'Cafe24SsurroundAir'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/Cafe24SsurroundAir.woff') format('woff'); font-weight: normal; font-style: normal;">
					</c:when>
					<c:otherwise>
						<label class="loginlabel fontname" for="us_id">아이디</label> <input
						type="text" class="inputlogin" id="us_id" name="m_id"
						placeholder="" 
						style="font-family: 'Cafe24SsurroundAir'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/Cafe24SsurroundAir.woff') format('woff'); font-weight: normal; font-style: normal;">	
					</c:otherwise>
				</c:choose>
				<br> <label class="loginlabel fontname" for="us_pw">비밀번호</label>
				<input type="password" class="inputlogin" id="us_pw" name="m_pw"
					placeholder=""
					style="font-family: 'Cafe24SsurroundAir'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/Cafe24SsurroundAir.woff') format('woff'); font-weight: normal; font-style: normal;">
			</div>
			<div class="loginbutton">
				<button class="loginbtn btn4" type="submit">로 그 인</button>
			</div>
		</form>
		<div class="logindivision"></div>
	</div>
</body>

</html>
