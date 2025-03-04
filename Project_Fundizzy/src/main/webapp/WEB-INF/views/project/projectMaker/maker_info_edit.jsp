<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메이커 정보</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/projectMaker/maker_info.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/projectMaker/maker_info.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div class="main"> 
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
	    <div class="container">
    		<form action="MakerInfoEdit" enctype="multipart/form-data" method="POST">
    		<input type="hidden" name="project_code" value="${sessionScope.project_code}">
    		<input type="hidden" name="member_email" value="${sessionScope.sId}">
	        <div class="title-section">
		        <h2 class="title">스토리 정보</h2>
	    		<button class="side-button" type="submit" onclick="location.href='ProjectMaker'"> 제출하기</button>
	    	</div>
	        <label for="maker-name">메이커 명</label>
	        <input type="text" id="maker-name" name="maker_name" placeholder="메이커 명을 입력해 주세요" value="${projectInfo.maker_name}">
	
	        <small>40자 제한</small>
	
	        <label>메이커 프로필 이미지</label>
	        <button type="button" class="image-upload">이미지 등록</button>
	        <input type="file" id="fileInput" name="profileImg" accept="image/*" style="display: none;">
	        <img id="previewImage" class="preview" src="" alt="미리보기" style="display:none;">
	
	        <label for="email">문의 이메일</label>
	        <input type="email" id="email" name="maker_email" placeholder="이메일을 입력해 주세요">
	
	        <label for="phone">문의 전화번호</label>
	        <input type="tel" id="phone" name="maker_phone" placeholder=" - 를 포함하여 전화번호 입력">
	
	        <label>SNS(선택)</label>
	        <input type="text" name="facebook_address" placeholder="facebook 주소 입력">
	        <input type="text" name="twitter_address" placeholder="twitter 주소 입력">
	        <input type="text" name="instagram_address" placeholder="instagram 주소 입력">
	    </form>
	    </div>
    </div>
</body>
</html>
