<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styleSheet" type="text/css" href="resources/css/projectState/project_state_default.css" >
<link rel="stylesheet" type="text/css" href="resources/css/projectState/project_state.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp" />
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp" />
		<div class="content">
			<h1>프로젝트 현황</h1>
			<div class="state-container">
				<div class="state">
					<div>펀딩 금액</div>
					<span>1,000,000</span>
					<span class="unit">원</span>
				</div>
				<div class="state">
					<div>펀딩 달성률</div>
					<span>71</span>
					<span class="unit">%</span>
				</div>
				<div class="state">
					<div>펀딩 건수</div>
					<span>71</span>
					<span class="unit">건</span>
				</div>
				<div class="state">
					<div>남은 기간</div>
					<span>0</span>
					<span class="unit">일</span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>