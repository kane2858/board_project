<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세보기</title>
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
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/footer.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/header1.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/reset.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/all.css">
</head>
<body>
<script type="text/javascript">
</script>
	<div class="header">
		<div class="headerup">
			<div class="headerlogo">
				<img src="https://eansoft.co.kr/wp-content/uploads/2017/03/%ED%81%AC%EA%B8%B0%EB%B3%80%ED%99%98_%EC%9D%B4%EC%95%88%EC%86%8C%ED%94%84%ED%8A%B8_%EB%A1%9C%EA%B3%A0_1.jpg" onclick="location.href='<%=request.getContextPath()%>/'" style="cursor: pointer;">
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
				<a href="<%=request.getContextPath()%>/board" class="fontimportant2"  style="color: black; text-decoration: none;">게시판</a>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row"
			style="width: 1200px; margin: 0 auto; padding-top: 30px;">
			<form id="frm" method="post" action="AdminNoticeUpdateDo" enctype="multipart/form-data">
				<table class="table">
					<thead>
						<tr>
							<th rowspan="2">게시글 상세보기</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${list.m_id eq sessionInfo.M_ID }">
								<tr>
									<td>글번호 : <span>${list.b_no}</span> | 글종류 : <span>${list.k_title}</span> | 작성자 : <span>${list.m_name}</span> | 작성일 : <span>${list.b_date} | 조회수 : <span>${list.b_count}</span></span></td>
								</tr>
								<tr>
									<td><input type="text" class="form-control"
										placeholder="글 제목" name="b_title" maxlength="300" id="ntTitle"
										required="required" value="${list.b_title}" /></td>
								</tr>
								<tr>
									<td><textarea class="form-control" placeholder="글 내용"
										name="b_content" maxlength="4000" id="ntContent"
										style="height: 350px; resize: none;" required="required">${list.b_content}</textarea><p><span class="viewByte red">0</span>/3000byte</p><br></td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td>글번호 : <span>${list.b_no}</span> | 글종류 : <span>${list.k_title}</span> | 작성자 : <span>${list.m_name}</span> | 작성일 : <span>${list.b_date}</span> | 조회수 : <span>${list.b_count}</span></td>
								</tr>
								<tr>
									<td><input type="text" class="form-control"
										placeholder="글 제목" name="b_title" maxlength="300" id="ntTitle"
										required="required" value="${list.b_title}" disabled/></td>
								</tr>
								<tr>
									<td><textarea class="form-control" placeholder="글 내용"
										name="b_content" maxlength="4000" id="ntContent"
										style="height: 350px; resize: none;" required="required" disabled>${list.b_content}</textarea><p><span class="viewByte red">0</span>/3000byte</p><br></td>
								</tr>
							</c:otherwise>
						</c:choose>
						<c:if test="${sessionInfo.M_ID eq list.m_id }">
						<tr>
							<td>
								<span>파일추가 : </span>
								<input type="file" multiple="multiple" name="files">
								<hr style="margin-bottom: -5px;">
							</td>
						</tr>
						</c:if>
						<tr>
							<td>
								<table>
								<c:if test="${list.list_fileinfo != null}">
								<c:forEach items="${list.list_fileinfo }" var="list">
								<tr>
									<td>
									<label>${list.f_realname }</label>
									</td>
									<td>
									<a href="<%=request.getContextPath() %>${list.f_path}${list.f_newname}" download><img src="https://cdn.pixabay.com/photo/2016/12/18/13/45/download-1915753_1280.png" width="18px;" style="margin-bottom: -3px;"></a>
									<c:if test="${sessionInfo.M_ID eq list.m_id }"><span style="cursor: pointer; color: red; font-size: 12px; margin-top: -30px;" class="btn_file_delete"> 삭제</span></c:if>
									<input type="hidden" value="${list.f_newname}"><input type="hidden" value="${list.f_path}"><br></td>
								</tr>
								</c:forEach>
								</c:if>
								<hr>
								</table>
							</td>
						</tr>
						<c:forEach items="${list.list_recomment }" var="rec">
						<tr>
							<td>
								<span style="font-weight: bold; padding: 20px;"><c:if test="${rec.r_depth > 0 }"><c:forEach begin="1" end="${rec.r_depth}" var="i">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach></c:if>${rec.m_name }</span><br><br>
								<c:choose>
									<c:when test="${rec.r_useyn == 'Y'}">
									<span><c:if test="${rec.r_depth > 0 }"><c:forEach begin="1" end="${rec.r_depth}" var="i">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach></c:if>${rec.r_content }</span><br><br>
									</c:when>
									<c:otherwise>
									<span><c:if test="${rec.r_depth > 0 }"><c:forEach begin="1" end="${rec.r_depth}" var="i">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach></c:if> 삭제된 댓글 입니다 </span><br><br>
									</c:otherwise>
								</c:choose>
								<c:if test="${rec.r_useyn eq 'Y'}"><span style="font-size: 15px;"><c:if test="${rec.r_depth > 0 }"><c:forEach begin="1" end="${rec.r_depth}" var="i">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach></c:if>${rec.r_date}</span><span><input type="hidden" value="${rec.r_no }"></span> <a style="color: blue; font-size: 12px; cursor: pointer;" class="btn_rerecomment">답글쓰기</a> <c:if test="${rec.m_id eq sessionInfo.M_ID }"><a style="color: green; font-size: 12px; cursor: pointer;" class="btn_reUpdate" > 수정하기 </a><a style="color: red; font-size: 12px; cursor: pointer;" class="btn_reDelete">삭제하기</a></c:if></c:if>
								<br><br><hr>
							</td>
						</tr>
						</c:forEach>
						<tr>
							<td><textarea class="form-control"
							id="r_content" maxlength="4000" id="r_content"
							style="height: 130px; resize: none;" required="required"></textarea></td>
						</tr>
						<tr>
							<td>
								<input type="button" id="r_send" class="btn btn-primary pull-right s_ad_nt_btn" value="답글달기" style="float: right; margin-right: 20px;">
							</td>
						</tr>
					</tbody>
				</table>
				<div>
					
				</div>
					<input type="hidden" value="${list.b_no }" name="b_no">
					<c:if test="${list.m_id eq sessionInfo.M_ID }">
					<input type="button" id="s_delete_btn" class="btn btn-danger pull-right s_ad_nt_btn" value="삭제하기"> 
					<input type="button" id="s_update_btn" class="btn btn-primary pull-right s_ad_nt_btn" value="수정하기">
					</c:if>
					<input type="button" id="back_btn" class="btn btn-secondary pull-right s_ad_nt_btn" value="목록으로">
			</form>
		</div>
	</div>
	<footer>
        <div class="footerline"></div>
        <div class="footer">
            <div class="footerend">
                <p class="fontcontent2">
                    Copyright © 2022 PROJOB. All rights reserved.
                </p>
            </div>
        </div>
    </footer>
	
	<script>
	$(document).ready(function(){
		$(".viewByte").html(calByte.getByteLength( $("#ntContent").val() ));
	});
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
	
		$("#back_btn").click(function() {
			window.history.back();
		});

		$("#s_update_btn").click(function() {
			if (confirm("정말 수정하시겠습니까?") == true) {
				if($.trim($("#ntTitle").val()) == '') {
					alert("제목을 입력해주세요.");
					$("#ntTitle").val('');
					$("#ntTitle").focus();
					return;
				}
				// if($.trim($("#ntContent").val()) == '') {
				if($("#ntContent").val().trim() == '') {
					alert("내용을 입력해주세요.");
					$('#ntContent').val('');
					$('#ntContent').focus();
					return;
				}
				
				var frmEl = $("#frm");
				frmEl.attr("action", "<%=request.getContextPath()%>/board/update");
				frmEl.attr("method", "post");
				frmEl.submit();
			}
		});

		$("#s_delete_btn").click(function() {
			if (confirm("정말 삭제하시겠습니까?") == true) {
				var frmEl = $("#frm");
				frmEl.attr("action", "<%=request.getContextPath()%>/board/delete");
				frmEl.attr("method", "post");
				frmEl.submit();
			} else {
				history.back();
			}
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
		$(".rere_content").change(function(){
			var title_check = /^[ㄱ-ㅎ가-힣\s]{0,30}$/;
			if (!title_check.test($(".rere_content").val())) {
				if($(this).val().length > 30){
				const str = $(".rere_content").val();
				let newStr = str.substr(0, 30);
				$(".rere_content").val(newStr);
				alert('30자 이내로 입력해주세요');
				return;
				}
				alert('한글 30자 이내로 입력해주세요');
			}	
		})
		
		$(document).on("click", "#r_send", function(){
			var title_check = /^[ㄱ-ㅎ가-힣\s]{0,30}$/;
			if (!title_check.test($("#r_content").val())) {
				if($(this).val().length > 30){
				const str = $("#r_content").val();
				let newStr = str.substr(0, 30);
				$("#r_content").val(newStr);
				alert('30자 이내로 입력해주세요');
				return;
				}
				alert('한글 30자 이내로 입력해주세요');
				return;
			}			
	
			var r_content = $("#r_content").val();
			var m_id = '${sessionInfo.M_ID}';
			var b_no = '${list.b_no}';
			if(r_content == ''){
				alert('댓글을 입력해주세요');
			} else {
				if(confirm('등록 하시겠습니까?')){
					$.ajax({
						type:'post',
						url:'recommentWrite',
						dataType:'json',
						data:{
							r_content : r_content,
							m_id : m_id,
							b_no : b_no
						},
						success:function(data){
							if(data > 0){
								alert('댓글 등록 성공');
								location.href="<%=request.getContextPath()%>/board/detail?b_no="+b_no
							} else {
								alert('댓글 등록 실패');
							}
						},
						error:function(a, b, c){
							console.log(a);
							console.log(b);
							console.log(c);
						}
					})
				}
			}
		});
		
		$(".btn_reDelete").click(function(){
			var r_no = $(this).prev().prev().prev().children().eq(0).val();
			var b_no = '${list.b_no}';
			if(confirm('삭제 하시겠습니까?')){
				$.ajax({
					type:'post',
					url:'recommentDelete',
					dataType:'json',
					data:{
						r_no : r_no
					},
					success:function(data){
						if(data > 0){
							alert('댓글 삭제 성공');
							location.href="<%=request.getContextPath()%>/board/detail?b_no="+b_no
						} else {
							alert('댓글 삭제 실패');
						}
					},
					error:function(a, b, c){
						console.log(a);
						console.log(b);
						console.log(c);
					}
				})
			}
			
		});
		
		$(".btn_rerecomment").click(function(){
			$(this).prev().append('<br><br><br><textarea class="form-control" class="rere_content" maxlength="3000" id="rere_content" style="height: 130px; resize: none;" required="required"></textarea><input type="button" class="btn btn-primary pull-right s_ad_nt_btn rerecomment_btn" value=" 답글달기" style="float:right; margin-right:20px; margin-top:20px;"><input type="button" id="back_btn" class="btn btn-secondary pull-right re_cancle" value="취소하기" style="float:right; margin-right:20px; margin-top:20px;"><br><br>');
			$(this).hide();
		})
		
		$(document).on('change', '#rere_content', function(){
			var title_check = /^[ㄱ-ㅎ가-힣\s]{0,30}$/;
			if (!title_check.test($("#rere_content").val())) {
				if($(this).val().length > 30){
				const str = $("#rere_content").val();
				let newStr = str.substr(0, 30);
				$("#rere_content").val(newStr);
				alert('30자 이내로 입력해주세요');
				return;
				}
				alert('한글 30자 이내로 입력해주세요');
				return;
			}
		})
		
		$(document).on('click', '.rerecomment_btn', function(){
			var title_check = /^[ㄱ-ㅎ가-힣\s]{0,30}$/;
			if (!title_check.test($("#rere_content").val())) {
				if($(this).val().length > 30){
				const str = $("#rere_content").val();
				let newStr = str.substr(0, 30);
				$("#rere_content").val(newStr);
				alert('30자 이내로 입력해주세요');
				return;
				}
				alert('한글 30자 이내로 입력해주세요');
				return;
			} else{
				
			var r_content = $(this).prev().val();
			var r_no = $(this).prev().prev().prev().prev().prev().val();
			var m_id = '${sessionInfo.M_ID}';
			var b_no = '${list.b_no}';
			if(r_content == ''){
				alert('댓글을 입력해주세요');
				return;
			}
			if(confirm('등록 하시겠습니까?')){
				$.ajax({
					type:'post',
					url:'rerecommentWrite',
					dataType:'json',
					data:{
						r_content : r_content,
						r_no : r_no,
						m_id : m_id,
						b_no : b_no
					},
					success:function(data){
						if(data > 0){
							alert('답글 등록 성공');
							location.href="<%=request.getContextPath()%>/board/detail?b_no="+b_no
						} else {
							alert('답글 등록 실패');
						}
					},
					error:function(a, b, c){
						console.log(a);
						console.log(b);
						console.log(c);
					}
				})
			}
			}
		});
		
		$(document).on('click', '.re_cancle', function(){
			$(this).next().next().remove();
			$(this).next().remove();
			$(this).prev().prev().prev().prev().prev().remove();
			$(this).prev().prev().prev().prev().remove();
			$(this).prev().prev().prev().remove();
			$(this).prev().prev().remove();
			$(this).prev().remove();
			$(this).remove();
			$(".btn_rerecomment").show();
		});
		
		$(".btn_file_delete").click(function(){
			var file_name = $(this).next().val();
			var file_path = $(this).next().next().val();
			var b_no = '${list.b_no}';
			if(confirm('삭제 하시겠습니까?')){
				$.ajax({
					type:'post',
					url:'fileRemove',
					dataType:'json',
					data:{
						file_name : file_name,
						file_path : file_path
					},
					success:function(data){
						alert(data);
						location.href="<%=request.getContextPath()%>/board/detail?b_no="+b_no
					},
					error:function(a, b, c){
						console.log(a);
						console.log(b);
						console.log(c);
					}
				})
			}
		})
		
		$("#r_content").change(function() {
			var title_check = /^[ㄱ-ㅎ가-힣\s]{0,30}$/;
			if (!title_check.test($("#r_content").val())) {
				if($(this).val().length > 30){
				const str = $("#r_content").val();
				let newStr = str.substr(0, 30);
				$("#r_content").val(newStr);
				alert('30자 이내로 입력해주세요');
				return;
				}
				alert('한글 30자 이내로 입력해주세요');
			}
		})
		
		$(".btn_reUpdate").click(function(){
			alert('수정안되용')
		})
	</script>
	
</html>