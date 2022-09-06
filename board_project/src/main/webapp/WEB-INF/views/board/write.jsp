<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/footer.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/header1.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/reset.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/all.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<meta name="theme-color" content="#7952b3">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<script src="https://ucarecdn.com/libs/widget/3.x/uploadcare.min.js"></script>
</head>
<title>게시판 글쓰기</title>
<body>
	<div class="header">
		<div class="headerup">
			<div class="headerlogo">
				<img
					src="https://eansoft.co.kr/wp-content/uploads/2017/03/%ED%81%AC%EA%B8%B0%EB%B3%80%ED%99%98_%EC%9D%B4%EC%95%88%EC%86%8C%ED%94%84%ED%8A%B8_%EB%A1%9C%EA%B3%A0_1.jpg"
					onclick="location.href='<%=request.getContextPath()%>/'"
					style="cursor: pointer;">
			</div>
			<div class="headerupright">
				<c:choose>
					<c:when test="${!empty sessionInfo}">
						<button type="button" class="fonthighlight btnwhite"
							onclick="location.href='<%=request.getContextPath()%>/login/logout'">Logout</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="fonthighlight btnwhite"
							onclick="location.href='<%=request.getContextPath()%>/join'">Join</button>
						<button type="button" class="fonthighlight btnwhite"
							onclick="location.href='<%=request.getContextPath()%>/login'">Login</button>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="headerdown">
			<div class="headerdownleft">
				<a href="<%=request.getContextPath()%>/board" class="fontimportant2"
					style="color: black; text-decoration: none;">게시판</a>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row"
			style="width: 1200px; margin: 0 auto; padding-top: 30px;">
			<form method="post"
				action="<%=request.getContextPath()%>/board/insertBoard" id="frm"
				enctype="multipart/form-data">
				<table class="table">
					<thead>
						<tr>
							<th colspan="3">게시글 작성 <select
								style="float: right; width: 80px;" name="k_no">
									<c:if test="${!empty kind}">
										<c:forEach items="${kind }" var="kind">
											<option value="${kind.K_NO }">${kind.K_TITLE }</option>
										</c:forEach>
									</c:if>
							</select>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="100%;"><input type="text" class="form-control"
								placeholder="글 제목" name="b_title" id="ntTitle" maxlength="300"
								required="required"></td>
						</tr>
						<tr>
							<td><textarea class="form-control ntContent"
									placeholder="글 내용" name="b_content" id="ntContent"
									maxlength="4000" style="height: 350px; resize: none;"
									required="required" onkeyup="viewDisplay(this)"></textarea> 
									<p><span class="viewByte red">0</span>/3000byte</p>
							</span></td>
						</tr>
						<tr>
							<td><input type="file" multiple="multiple" name="files">
							</td>
						</tr>
					</tbody>
				</table>
				<input type="button" id="s_write_btn"
					class="btn btn-primary pull-right"
					style="float: right; margin-right: 10px;" value="글쓰기">
			</form>
		</div>
	</div>
	<footer>
		<div class="footerline"></div>
		<div class="footer">
			<div class="footerend">
				<p class="fontcontent2">Copyright © 2022 PROJOB. All rights
					reserved.</p>
			</div>
		</div>
	</footer>
	<script>
	    var calByte = {
	    		getByteLength : function(s) {

	    			if (s == null || s.length == 0) {
	    				return 0;
	    			}
	    			var size = 0;

	    			for ( var i = 0; i < s.length; i++) {
	    				size += this.charByteSize(s.charAt(i));
	    			}

	    			return size;
	    		},
	    			
	    		cutByteLength : function(s, len) {

	    			if (s == null || s.length == 0) {
	    				return 0;
	    			}
	    			var size = 0;
	    			var rIndex = s.length;

	    			for ( var i = 0; i < s.length; i++) {
	    				size += this.charByteSize(s.charAt(i));
	    				if( size == len ) {
	    					rIndex = i + 1;
	    					break;
	    				} else if( size > len ) {
	    					rIndex = i;
	    					break;
	    				}
	    			}

	    			return s.substring(0, rIndex);
	    		},

	    		charByteSize : function(ch) {

	    			if (ch == null || ch.length == 0) {
	    				return 0;
	    			}

	    			var charCode = ch.charCodeAt(0);

	    			if (charCode <= 0x00007F) {
	    				return 1;
	    			} else if (charCode <= 0x0007FF) {
	    				return 2;
	    			} else if (charCode <= 0x00FFFF) {
	    				return 3;
	    			} else {
	    				return 4;
	    			}
	    		}
	    	};
	    $('#ntContent').on('keyup', function() {
	    	
	    	$(".viewByte").html(calByte.getByteLength( $(this).val() ));
	    	if(calByte.getByteLength( $(this).val() ) > 3000){
	    		$(this).val( calByte.cutByteLength($(this).val(),3000) );
	    	}
			
	    });

		$("#s_write_btn").click(function() {
			
			var title_check = /^[ㄱ-ㅎ가-힣\s]{0,30}$/;
			if (!title_check.test($("#ntTitle").val())) {
				if($(this).val().length > 30){
				const str = $("#ntTitle").val();
				let newStr = str.substr(0, 30);
				$("#ntTitle").val(newStr);
				alert('30자 이내로 입력해주세요');
				return;
				}
				alert('한글 30자 이내로 입력해주세요');
				return;
			}


			if ($.trim($("#ntTitle").val()) == '') {
				alert("제목을 입력해주세요");
				$("#ntTitle").val('');
				$("#ntTitle").focus();
				return;
			}

			if ($.trim($("#ntContent").val()) == '') {
				alert("내용을 입력해주세요");
				$('.ntContent').val('');
				$('.ntContent').focus();
				return;
			}

			$("#frm").submit();

		});

		$("#ntTitle").change(function() {
			var title_check = /^[ㄱ-ㅎ가-힣\s]{0,30}$/;
			if (!title_check.test($("#ntTitle").val())) {
				if($(this).val().length > 30){
				const str = $("#ntTitle").val();
				let newStr = str.substr(0, 30);
				$("#ntTitle").val(newStr);
				alert('30자 이내로 입력해주세요');
				return;
				}
				alert('한글 30자 이내로 입력해주세요');
			}
		})
	</script>
</body>
</html>