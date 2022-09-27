
<%@page import="java.io.PrintWriter"%>
<%@page import="org.springframework.web.servlet.support.RequestContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>게시판 프로젝트</title>
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
<style>
header {
	margin-top: 10px;
}

#p_main_top {
	width: 1200px;
	margin: 0 auto;
	border-bottom: 2px solid silver;
}

#p_top_logo {
	float: left;
	margin-left: 30px;
}

#p_top_menu {
	float: left;
	margin: 15px 0 0 10px;
}

#p_top_profile {
	float: left;
}

.navbar-nav {
	margin-right: 20px;
}

.dropdown-toggle, .dropdown {
	font-weight: bold;
}

#dropdownUser1 {
	padding-right: 10px;
}
</style>
<!--section공용-->
<style>
#main_box {
	width: 1200px;
	margin: 15px auto 0;
}

#booking, #review {
	text-align: center;
	/* display: flex;
      justify-content: center; */
	/* float: left; */
	width: 550px;
	height: 450px;
	background-color: white;
	border-radius: 30px;
	margin: 30px 15px;
	padding: 15px;
}

#statistics_visit, #statistics_review {
	text-align: center;
	/* display: flex;
      justify-content: center; */
	/* float: left; */
	width: 550px;
	height: 480px;
	background-color: white;
	border-radius: 30px;
	margin: 0 15px 30px;
	overflow: hidden;
}

.box_font {
	margin-top: 10px;
	font-weight: bold;
	color: #0D6EFD;
	margin-bottom: 20px;
	font-size: large;
}

.nav_tab_div {
	background-color: rgba(241, 241, 241);
	width: 1200px;
	margin: 10px 0;
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	border-radius: 15px;
}

.statiscics_font {
	margin-top: 20px;
    font-weight: bold;
    color: #0D6EFD;
    margin-bottom: 20px;
    font-size: large;
}
.table{
	font-size : 15px;
	text-align: center;
}
</style>
<!--월별 예약통계-->
<style>
#container {
	height: 400px;
}

.highcharts-figure, .highcharts-data-table table {
	min-width: 310px;
	max-width: 800px;
	margin: 1em auto;
}

#datatable {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #ebebeb;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
	display: none;
}

#datatable caption {
	padding: 1em 0;
	font-size: 1.2em;
	color: #555;
}

#datatable th {
	font-weight: 600;
	padding: 0.5em;
}

#datatable td, #datatable th, #datatable caption {
	padding: 0.5em;
}

#datatable thead tr, #datatable tr:nth-child(even) {
	background: #f8f8f8;
}

#datatable tr:hover {
	background: #f1f7ff;
}
</style>
<!--별점통계-->
<style>
.highcharts-figure, .highcharts-data-table table {
	width: 500px;
	margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #ebebeb;
	margin: 10px auto;
	text-align: center;
	width: 100%;
}

.highcharts-data-table caption {
	padding: 1em 0;
	font-size: 1.2em;
	color: #555;
}

.highcharts-data-table th {
	font-weight: 600;
	padding: 0.5em;
}

.highcharts-data-table td, .highcharts-data-table th,
	.highcharts-data-table caption {
	padding: 0.5em;
}

.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even)
	{
	background: #f8f8f8;
}

.highcharts-data-table tr:hover {
	background: #f1f7ff;
}
</style>
<!--content-->
<style>
/* 컨텐트 */
content>article>div {
	width: 1200px;
	height: 1000px;
	padding: 30px;
	display: none;
	margin: 20px auto 0;
	background-color: rgb(241, 241, 241);
}

/* 컨텐트안 제목 */
article>div>p {
	text-align: center;
	font-weight: bold;
	padding-top: 20px;
	font-size: large;
}

/* 검색바 위치*/
.navbar-light {
	float: right;
	margin-bottom: 20px;
}

/* 내정보 관리 */
.k_company {
	font-weight: bold;
}

/* 업체등록 */
#k_bu_eroll_top {
	display: flex;
}

.k_company_info {
	resize: none;
}
</style>
<style>
/* Slideshow container */
.slideshow-container {
	max-width: 1440px;
	position: relative;
	margin: auto;
	margin-top: 50px;
	margin-bottom: 60px;
	font-family: 'EliceDigitalBaeum_Bold';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_220508@1.0/EliceDigitalBaeum_Bold.woff2')
		format('woff2');
	font-weight: 700;
	font-style: normal;
	margin-bottom: 60px;
}

.mySlideDiv {
	margin: 20px auto;
	text-align: center;
}

/* effect */
.fade {
	-webkit-animation-name: fade;
	-webkit-animation-duration: 1.5s;
	animation-name: fade;
	animation-duration: 1.5s;
}

@
-webkit-keyframes fade {
	from {opacity: .4
}

to {
	opacity: 1
}

}
@
keyframes fade {
	from {opacity: .4
}

to {
	opacity: 1
}

}

/* Next & previous buttons */
.prev, .next {
	cursor: pointer;
	position: absolute;
	top: 60%;
	width: auto;
	padding: 16px;
	margin-top: -22px;
	color: black;
	font-weight: bold;
	font-size: 30px;
	transition: 0.6s ease;
	border-radius: 0 3px 3px 0;
}

/* Position the "next button" to the right */
.prev {
	margin-left: 10%;
}

.next {
	right: 0;
	border-radius: 3px 0 0 3px;
	margin-right: 10%;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

#content_middle {
	width: 340px;
	margin: 20px auto;
	padding: 30px;
	text-align: center;
	border: 3px solid rgb(232, 232, 232);
	border-radius: 30px;
	font-family: 'EliceDigitalBaeum_Bold';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_220508@1.0/EliceDigitalBaeum_Bold.woff2')
		format('woff2');
	font-weight: 700;
	font-style: normal;
}

#content_top p {
	font-size: 50px;
	font-weight: bold;
	color: white;
	background: none;
}

#content_row {
	width: 80%;
	margin: 0 auto;
	text-align: center;
}

#content_row p {
	font-family: 'EliceDigitalBaeum_Bold';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_220508@1.0/EliceDigitalBaeum_Bold.woff2')
		format('woff2');
	font-weight: 700;
	font-style: normal;
	font-size: 21px;
}

#tools span {
	font-family: 'EliceDigitalBaeum_Bold';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_220508@1.0/EliceDigitalBaeum_Bold.woff2')
		format('woff2');
}

.aboutprojob {
	margin: 40px auto;
	text-align: center;
	width: 80%;
	align-items: center;
}
#mk_table thead, tbody, tr, th, td {
padding: 5px;
border: 1px solid black;
}
</style>
</head>
<body>
	<c:if test="${!empty msg}">
		<script>
			alert('${msg}');
		</script>
	</c:if>
	<div class="header">
		<div class="headerup">
			<div class="headerlogo">
				<img src="https://eansoft.co.kr/wp-content/uploads/2017/03/%ED%81%AC%EA%B8%B0%EB%B3%80%ED%99%98_%EC%9D%B4%EC%95%88%EC%86%8C%ED%94%84%ED%8A%B8_%EB%A1%9C%EA%B3%A0_1.jpg">
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
			<c:if test="${empty sessionInfo}">
				<div class="headerdownleft">
					<a href="<%=request.getContextPath()%>/board" class="fontimportant2">게시판</a>
					<a style="cursor: pointer;" id="jw_statistics" class="fontimportant2">재우 통계</a>
					<a style="cursor: pointer;" id="mk_statistics" class="fontimportant2">민교 통계</a>
				</div>
			</c:if>
			<c:if test="${!empty sessionInfo}">
				<div class="headerdownleft">
					<a href="<%=request.getContextPath()%>/board" class="fontimportant2">게시판</a>
					<a style="cursor: pointer;" id="jw_statistics" class="fontimportant2">재우 통계</a>
					<a style="cursor: pointer;" id="mk_statistics" class="fontimportant2">민교 통계</a>
				</div>
			</c:if>
		</div>
	</div>
	<br><br><br><br><br><br>
	<div id="statistics_join">
	</div>
	<br><br><br><br><br><br>
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
	<script type="text/javascript">
		$("#jw_statistics").click(function(){
			$("#statistics_join").html("");
			$.ajax({
				url:'http://localhost:8090/projob/statistics',
				type : 'get',
				dataType : 'json',
				success : function(data){
						html = "";
						html += '<table style="text-align: center; border: 1px solid black; margin: 0 auto;">';
						html += '<thead style="border: 1px solid black; background-color:skyblue; font-weight:bold;">';
						html += '<th style="width:100px; border: 1px solid black;">월</th>';
						html += '<th style="width:300px; border: 1px solid black;">프로잡 회원가입 승인 인원</th>';
						html += '<th style="width:300px; border: 1px solid black;">프로작 회원가입 미승인 인원</th>';
						html += '</thead>';
						html += '<tbody>';
						
					$.each(data, function(i, item){
						html += '<tr><td style="border: 1px solid black;">'+item.U_DATE+'월</td>';
						if(item.U_OK == undefined){
						html += '<td style="border: 1px solid black;">0명</td>';
						} else {
						html += '<td style="border: 1px solid black;">'+item.U_OK+'명</td>';
						}
						if(item.U_NO == undefined){
						html += '<td style="border: 1px solid black;">0명</td></tr>';
						} else {
						html += '<td style="border: 1px solid black;">'+item.U_NO+'명</td></tr>';
						}
					})
						html += '</tbody>';
						html += '</table>';
						$("#statistics_join").append(html);
				}
			})
		})
		
		$("#mk_statistics").click(function(){
			$("#statistics_join").html("");
			$.ajax({
		         url: 'http://192.168.0.92:8091/PISIC/statistics/callStatistics',
		         type: "get",
		         dataType: "json",
		         success: function(result) {
		            $(".statistics_list tbody").empty();
		            let html = "";
		            html += '<table style="text-align: center; border: 1px solid black; margin: 0 auto; width:2500px;" id="mk_table">';
		           	html += '<thead style="border: 1px solid black; background-color:skyblue; font-weight:bold;">';
		            html += '<tr>';
	            	html += '<th>No</th>';
            		html += '<th>노래명</th>';
           			html += '<th>가수명</th>';
       				html += '<th>강남구</th>';
   					html += '<th>강동구</th>';
					html += '<th>강북구</th>';
					html += '<th>강서구</th>';
					html += '<th>관악구</th>';
					html += '<th>광진구</th>';
					html += '<th>구로구</th>';
					html += '<th>금천구</th>';
					html += '<th>노원구</th>';
					html += '<th>도봉구</th>';
					html += '<th>동대문구</th>';
					html += '<th>동작구</th>';
					html += '<th>마포구</th>';
					html += '<th>서대문구</th>';
					html += '<th>서초구</th>';
					html += '<th>성동구</th>';
					html += '<th>성북구</th>';
					html += '<th>송파구</th>';
					html += '<th>양천구</th>';
					html += '<th>영등포구</th>';
					html += '<th>용산구</th>';
					html += '<th>은평구</th>';
					html += '<th>종로구</th>';
					html += '<th>중구</th>';
					html += '<th>중랑구</th>';
					html += '</tr>';
					html += '</thead>';
		         	html+= '<tbody>';
		            for(var i = 0 ; i < result.length ; i++){
		               let resultData = result[i];
		               html += '<tr>';
		               html += '<td>'+(i+1)+'</td>';
		               html += '<td>'+resultData.s_name+'</td>';
		               html += '<td>'+resultData.artist_name+'</td>';
		               html += '<td>'+resultData.cnt1+'</td>';
		               html += '<td>'+resultData.cnt2+'</td>';
		               html += '<td>'+resultData.cnt3+'</td>';
		               html += '<td>'+resultData.cnt4+'</td>';
		               html += '<td>'+resultData.cnt5+'</td>';
		               html += '<td>'+resultData.cnt6+'</td>';
		               html += '<td>'+resultData.cnt7+'</td>';
		               html += '<td>'+resultData.cnt8+'</td>';
		               html += '<td>'+resultData.cnt9+'</td>';
		               html += '<td>'+resultData.cnt10+'</td>';
		               html += '<td>'+resultData.cnt11+'</td>';
		               html += '<td>'+resultData.cnt12+'</td>';
		               html += '<td>'+resultData.cnt13+'</td>';
		               html += '<td>'+resultData.cnt14+'</td>';
		               html += '<td>'+resultData.cnt15+'</td>';
		               html += '<td>'+resultData.cnt16+'</td>';
		               html += '<td>'+resultData.cnt17+'</td>';
		               html += '<td>'+resultData.cnt18+'</td>';
		               html += '<td>'+resultData.cnt19+'</td>';
		               html += '<td>'+resultData.cnt20+'</td>';
		               html += '<td>'+resultData.cnt21+'</td>';
		               html += '<td>'+resultData.cnt22+'</td>';
		               html += '<td>'+resultData.cnt23+'</td>';
		               html += '<td>'+resultData.cnt24+'</td>';
		               html += '<td>'+resultData.cnt25+'</td>';
		               html += '</tr>';
		            }
		            html += '</tbody>';
		            html += '</table>';
		            $("#statistics_join").append(html);
		            
		         }
		      }); // ajax 끝
		})
	</script>
	
</body>
</html>
