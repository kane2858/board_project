<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/header1.css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/reset.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/all.css">
<title>통계 페이지</title>
<!--header-->
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
</head>
<body>
	<article style="margin-top: 30px;">
		<div id="main_box">
			<div class="nav_tab_div" style="margin-top: 30px;">
				<div id="statistics_visit" style="margin-top: 30px;">
					<p class="statiscics_font">회원가입 통계</p>
					<figure class="highcharts-figure">
						<div id="container_visit"></div>
						<table id="datatable">
							<thead>
								<tr>
									<th></th>
									<th>승인 회원</th>
									<th>비승인 회원</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${join_list}" var="list">
									<tr>
										<th>${list.U_DATE }월</th>
										<td>${list.U_OK }</td>
										<td>${list.U_NO }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</figure>
				</div>
				<div id="statistics_review" style="margin-top: 30px;">
					<p class="statiscics_font">전체 프로젝트별 통계</p>
					<script src="https://code.highcharts.com/highcharts.js"></script>
					<figure class="highcharts-figure">
						<div id="container"></div>
					</figure>
				</div>
			</div>
		</div>
	</article>
	<script>
	$(function(){
		console.log(${msg});
		/* if('${msg}' != ''){
			alert('되나?');
		} */
	})
	</script>
	
	<script>
		// Create the chart
		Highcharts.chart('container', {
			chart : {
				type : 'pie'
			},
			title : {
				text : ''
			},
			accessibility : {
				announceNewData : {
					enabled : true
				},
				point : {
					valueSuffix : '%'
				}
			},
			plotOptions : {
				series : {
					dataLabels : {
						enabled : true,
						format : '{point.name}: {point.y:1f}개'
					}
				}
			},
			series : [ {
				name : "",
				colorByPoint : true,
				data : [
					{
						name : "웹사이트 제작",
						y : Number('${project_list[0].PRO_FIELD}'),
					}, {
						name : "웹사이트 유지·보수",
						y : Number('${project_list[1].PRO_FIELD}'),
					}, {
						name : "퍼블리싱",
						y : Number('${project_list[2].PRO_FIELD}'),
					}, {
						name : "개발·프로그래밍",
						y : Number('${project_list[3].PRO_FIELD}'),
					}
				]
			} ]
		});
	</script>
	<script src="https://code.highcharts.com/modules/data.js"></script>
	<!--방문자통계-->
	<script>
		Highcharts.chart('container_visit', {
			data : {
				table : 'datatable'
			},
			chart : {
				type : 'column'
			},
			title : {
				text : ''
			},
			yAxis : {
				allowDecimals : false,
				title : {
					text : ''
				}
			}
		});
	</script>
	
  
  <script src="https://code.highcharts.com/modules/data.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>  
</body>
</html>