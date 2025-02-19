<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 정보</title>
    <link rel="stylesheet" type="text/css" href="resources/css/projectMaker/project_info.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
	    <div class="container">
	        <h1 class="title">프로젝트 정보</h1>
	        
	        <!-- 카테고리 선택 -->
	        <div class="first-label">
		        <label class="label">카테고리 선택</label> 
		        <button class="side-button" onclick="location.href='ProjectMaker'"> 제출하기</button>
	        </div>
	        <select class="select">
	            <option>카테고리 선택</option>
	        </select>
	        
	        <label class="label">보조 카테고리 선택(선택)</label>
	        <select class="select">
	            <option>카테고리 선택</option>
	        </select>
	        
	        <!-- 성인 인증 -->
	        <label class="label">성인 인증(선택)</label>
	        <div class="checkbox-container">
	            <input type="checkbox" id="adult">
	            <label for="adult">19세 이상만 참여 가능한 리워드예요</label>
	        </div>
	
	        <!-- 프로젝트 유형 -->
	       <div class="project-type-box">
		        <label class="title">프로젝트 유형</label>
		        <div class="option">
		            <input type="radio" id="funding" name="project-type" checked>
		            <label for="funding">
		                <span class="radio"></span>
		                <strong>펀딩</strong>
		                <p>한번도 출시된 적 없는 새 제품을 선보여요</p>
		            </label>
		        </div>
		        <div class="option">
		            <input type="radio" id="preorder" name="project-type">
		            <label for="preorder">
		                <span class="radio"></span>
		                <strong>프리오더</strong>
		                <p>기존에 출시된 제품을 특별한 혜택과 함께 제공하세요</p>
		            </label>
		        </div>
		    </div>
	        <!-- 메이커 유형 -->
	        <label class="label">메이커 유형</label>
	        <div class="button-group">
	            <button class="btn">개인</button>
	            <button class="btn">개인 사업자</button>
	            <button class="btn">법인 사업자</button>
	        </div>
	
	        <!-- 신청폼 -->
	        <label class="label">신분증</label>
	        <input type="file" class="input">
	
	        <label class="label">대표자명</label>
	        <input type="text" class="input" placeholder="대표자명">
	
	        <label class="label">대표자 이메일</label>
	        <input type="email" class="input" placeholder="이메일">
	
	        <!-- 목표 금액 -->
	        <label class="label">목표 금액</label>
	        <input type="number" class="input" placeholder="최소 50만원 ~ 1억원 사이에서 설정해주세요.">
	    </div>
	</div>
<script type="text/javascript">
	$(document).ready(function() {
	    $(".button-group .btn").click(function() {
	        $(".button-group .btn").removeClass("active"); // 모든 버튼에서 'active' 제거
	        $(this).addClass("active"); // 클릭한 버튼에 'active' 추가
	    });
	});	
</script>
</body>
</html>
