<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/footer.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/header1.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/reset.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/all.css">
    <title>게시판</title>
    <style>
        #fileShare{
            width: 80%;
            height: 880px;
            margin: 0 auto;
            margin-top: 15px;
            background-color: rgb(232, 232, 232);
            border-radius: 30px;
        }
        #fs_title{
            padding: 40px 70px 20px;
            text-align: center;
        }
        #fs_menu{
            width: 90%;
            margin: 0 auto;
            margin-bottom: 50px;
        }
        #fs_table{
            width: 90%;
            margin: 0 auto;
            height: 570px;
        }
        #fs_table table{
            vertical-align: middle;
        }
        #fs_table table th{
            text-align: center;
        }
        #fs_menu_select{
            float: left;
            margin-left: 10px;
        }
        #fs_menu_select select{
            width: 300px;
        }
        #fs_menu_search{
            float: right;
            margin-right: 30px;
        }
        #fs_menu_write{
            float: right;
            margin-right: 60px;
        }
        #fs_menu_botton{
            clear: both;
            margin: 0 110px 20px 80px;
        }
        .btn-primary{
        float: right;
        }
        #pagingBox ul{
            justify-content: center
        }
        .modal_li{
            margin: 10px;
        }
        .mb-3{
            margin-top: 8px;
            height: 40px;
            font-size: 15px;
        }
        h1{
	        font-size: 30px;
	        font-weight: bold;
        }
        .td_writer, .td_wdate{
        	text-align: center;
        }
    </style>
</head>
<body>
	<c:if test="${!empty msg }">
		<script type="text/javascript">
			alert('${msg}');
		</script>
	</c:if>
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
				<a href="<%=request.getContextPath()%>/board" class="fontimportant2">게시판</a>
			</div>
		</div>
	</div>
    
    <div id="fileShare">
        <div id="fs_title">
        </div>
        <div id="fs_menu">
            <div id="fs_menu_select">
                <select class="form-select form-select-lg mb-3" id="kind_select" aria-label=".form-select-lg example">
                    <option value="">전체</option>
                    <c:if test="${!empty kind}">
	                    <c:forEach items="${kind }" var="kind">
	                    	<c:if test="${kind.K_NO eq k_no }">
	                    	<option value="${kind.K_NO }" selected="selected">${kind.K_TITLE }</option>
	                    	</c:if>
	                    	<c:if test="${kind.K_NO ne k_no }">
	                    	<option value="${kind.K_NO }">${kind.K_TITLE }</option>
	                    	</c:if>
	                    </c:forEach>
	                </c:if>
                </select>
            </div>
            <div id="fs_menu_search">
                <!-- 검색 -->
                <div class="container-fluid">
                        <select id="s_title" style="width: 100px; float: left; margin-right: 10px;"
                            class="form-select" aria-label="Default select example">
                            <c:choose>
                            	<c:when test="${s_title eq '제목'}">
                            	<option value="제목" selected="selected">제목</option>
	                            <option value="내용">내용</option>
	                            <option value="작성자">작성자</option>
                            	</c:when>
                            	<c:when test="${s_title eq '내용'}">
                            	<option value="제목">제목</option>
	                            <option value="내용" selected="selected">내용</option>
	                            <option value="작성자">작성자</option>
                            	</c:when>
                            	<c:when test="${s_title eq '작성자'}">
                            	<option value="제목">제목</option>
	                            <option value="내용">내용</option>
	                            <option value="작성자" selected="selected">작성자</option>
                            	</c:when>
                            	<c:otherwise>
                            	<option value="제목">제목</option>
	                            <option value="내용">내용</option>
	                            <option value="작성자">작성자</option>
                            	</c:otherwise>
                            </c:choose>
                            
                        </select> 
                        <input class="form-control me-2" type="search" onkeyup="enterkey()" id="s_content" aria-label="Search" value="${s_content}" style="width:250px; float: left;">
                        <button id="s_search_btn" class="btn btn-outline-success" type="button">Search</button>
                </div>
            </div>
        </div>
        <div id="fs_menu_botton">
            <button type="button" class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/board/write'" style="margin-bottom: 20px;">등록하기</button>
        </div>
        <div id="fs_table">
            <table class="table table-striped" style="border-collapse: separate; border-spacing: 0 10px;">
                <thead >
                <tr>
                    <th scope="col">글 번호</th>
                    <th scope="col">글 종류</th>
                    <th scope="col">글 제목</th>
                    <th scope="col">첨부파일</th>
                    <th scope="col">작성자</th>
                    <th scope="col">작성일</th>
                    <th scope="col">조회수</th>
                </tr>
                </thead>
                <tbody>
                	<c:if test="${empty list }">
                		<tr style="text-align: center;">
		                    <td scope="row" colspan="7" >게시물이 없습니다</td>
		                </tr>
                	</c:if>
                	<c:forEach items="${list }" var="list">
						<tr style="cursor: pointer; text-align: center;" class="row_click">
		                    <td scope="row">${list.B_NO }</td>
		                    <td scope="row">${list.K_TITLE }</td>
		                    <td scope="row" style="max-width: 300px; overflow: hidden; text-overflow: ellipsis;">${list.B_TITLE } <c:if test="${!empty list.R_COUNT }">[${list.R_COUNT}]</c:if></td>
		                    <td scope="row">${list.F_COUNT }</td>
		                    <td scope="row">${list.M_NAME }</td>
		                    <td scope="row">${list.B_DATE }</td>
		                    <td scope="row">${list.B_COUNT }</td>
		                </tr>
                	</c:forEach>
                </tbody>
            </table>
        </div>
        <div id="pagingBox" style="margin-top: 30px;">
            <ul class="pagination">
            	<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/board?p_no=1&s_title=${s_title}&s_content=${s_content}&k_no=${k_no}">Start</a></li>
                <c:if test="${startPage > 1 }">
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/board?p_no=${startPage-1}&s_title=${s_title}&s_content=${s_content}&k_no=${k_no}">Previous</a></li>
					</c:if>
					<c:if test="${startPage <= 1 }">
						<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/board?p_no=${startPage-1 }&s_title=${s_title}&s_content=${s_content}&k_no=${k_no}">Previous</a></li>
					</c:if>
					<c:forEach step="1" begin="${startPage }" end="${endPage }" var="idx">
						<c:if test="${idx eq p_no }">
						<li class="page-item active"><a class="page-link" href="<%=request.getContextPath() %>/board?p_no=${idx }&s_title=${s_title}&s_content=${s_content}&k_no=${k_no}">${idx }</a></li>
						</c:if>
						<c:if test="${idx ne p_no }">
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/board?p_no=${idx }&s_title=${s_title}&s_content=${s_content}&k_no=${k_no}">${idx }</a></li>
						</c:if>
					</c:forEach>
					<!-- endPage에서 +1일 때 -->
					<c:if test="${endPage < pageCnt }">
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/board?p_no=${endPage+1 }&s_title=${s_title}&s_content=${s_content}&k_no=${k_no}">Next</a></li>
					</c:if>
					<c:if test="${endPage >= pageCnt }">
						<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/board?p_no=${endPage+1 }&s_title=${s_title}&s_content=${s_content}&k_no=${k_no}">Next</a></li>
					</c:if>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/board?p_no=${pageCnt }&s_title=${s_title}&s_content=${s_content}&k_no=${k_no}">End</a></li>
            </ul>
        </div>
        <form action="<%=request.getContextPath()%>/poiExcel" method="post">
        	<input type="hidden" name="s_content" value="${s_content }">
        	<input type="hidden" name="s_title" value="${s_title }">
        	<input type="hidden" name="k_no" value="${k_no }">
	        <div id="fs_menu_left_botton" style="float: right; margin-right: 110px; margin-top: -90px;">
	            <input type="submit" class="btn btn-primary" style="margin-bottom: 20px;" value="엑셀 다운로드">
	        </div>
        </form>
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
    	$(".row_click").click(function(){
    		location.href="<%=request.getContextPath()%>/board/detail?b_no="+$(this).children().eq(0).html()
    	})
    	
    	$("#kind_select").change(function(){
    		location.href="<%=request.getContextPath() %>/board?p_no=1&s_title=${s_title}&s_content=${s_content}&k_no="+$(this).val()
    	})
    	
    	$("#s_search_btn").click(function(){
    		location.href="<%=request.getContextPath() %>/board?p_no=1&s_title="+$("#s_title").val()+"&s_content="+$("#s_content").val()+"&k_no="+$("#kind_select").val()
    	})
    	
    	function enterkey() {
			if (window.event.keyCode == 13) {
				location.href="<%=request.getContextPath() %>/board?p_no=1&s_title="+$("#s_title").val()+"&s_content="+$("#s_content").val()+"&k_no="+$("#kind_select").val()
		    }
		}
    </script>
</body>
</html>
