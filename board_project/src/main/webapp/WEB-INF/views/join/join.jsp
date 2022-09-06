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
<script src="http://code.jquery.com/jquery-3.5.1.js"></script>
<title>회원가입</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/footer.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/header1.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/reset.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/all.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/joininfo.css">

<body>
	<!--헤더-->
	<div class="joininfofree">
		<form action="<%=request.getContextPath()%>/join/insertInfo" method="post">
			<div class="writeinfo">
				<div class="inforow">
					<br> <label class="labelinfo" for="us_name">이름</label><br>
					<br> <input type="text" class="inputinfo" required
						id="us_name" name="us_name" placeholder=""
						style="font-family: 'Cafe24SsurroundAir'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/Cafe24SsurroundAir.woff') format('woff'); font-weight: normal; font-style: normal;"><br>
					<br> <label class="labelinfo" for="us_id">아이디</label><br>
					<br> <input type="text" class="inputinfo" required
						name="us_id" id="us_id"
						style="font-family: 'Cafe24SsurroundAir'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/Cafe24SsurroundAir.woff') format('woff'); font-weight: normal; font-style: normal;"><br>
					<button type="button" class="inputinfobtn" id="checkid">중복확인</button>
				</div>
				<div class="inforow idchk1">
					<p class="fonthighlight  " style="color: blue">사용가능한 아이디입니다.</p>
				</div>
				<div class="inforow   idchk2">
					<p class="fonthighlight" style="color: red">사용중인 아이디입니다.</p>
					<br>
				</div>
				<div class="inforow">
					<label class="labelinfo" for="us_pw">비밀번호</label><br> <br>
					<input type="password" class="inputinfo" required name="us_pw"
						id="us_pw">
				</div>
				<div class="inforow">
					<label class="labelinfo" for="us_pwcheck">비밀번호 확인</label><br>
					<br> <input type="password" class="inputinfo" required
						name="us_pwcheck" id="us_pwcheck" placeholder="">
				</div>
				<div class="inforow" id="alert-success">
					<p class="fonthighlight" style="color: blue">비밀번호가 일치합니다.</p>
				</div>
				<div class="inforow" id="alert-fail">
					<p class="fonthighlight" style="color: red">비밀번호가 일치하지 않습니다.</p>
				</div>
			<div class="infonextbtn">
				<button type="submit" id="submit" class="btn3" style="float: none;">
					<p class="fonthighlight">회원가입</p>
				</button>
				<button type="button" class="btn3" style="float: none; margin: 20px 0">
					<p class="fonthighlight" onclick="location.href='<%=request.getContextPath()%>/'">홈</p>
				</button>
			</div>
		</form>
	</div>
	<!--푸터-->
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#alert-success").hide();
			$("#alert-fail").hide();
			$("input").keyup(function() {
				var pass = $("#us_pw").val();
				var passcheck = $("#us_pwcheck").val();
				if (pass != "" || passcheck != "") {
					if (pass == passcheck) {
						$("#alert-success").show();
						$("#alert-fail").hide();
						$("#submit").removeAttr("disabled");
					} else {
						$("#alert-success").hide();
						$("#alert-fail").show();
						$("#submit").attr("disabled", "disabled");
					}
				}

			});
		});
	</script>
	<script>
		//아이디 중복확인
		$(function() {
			$(".idchk1").hide();
			$(".idchk2").hide();
			$('#checkid').click(function() {
				var us_id = $("#us_id").val();
				console.log(us_id);
				if (us_id != '') {
					$.ajax({
						type : 'post',
						url : '/board/join/idchk',
						data : {
							m_id : us_id
						},
						dataType : 'json',
						success : function(result) {
							console.log(result);
							if (result == '0') {
								$(".idchk1").show();
								$(".idchk2").hide();
							} else {
								$(".idchk2").show();
								$(".idchk1").hide();
							}
						},
						error : function(a, b, c) {
							console.log(a, b, c);
						}
					});
				} else {
					alert('아이디를 입력해주세요.');
					$('#us_id').focus();
				}
			});
		});
	</script>
</body>

</html>
