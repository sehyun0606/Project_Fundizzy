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
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div class="main"> 
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
	    <div class="container">
	        <div class="title-section">
		        <h2 class="title">스토리 정보 확인</h2>
	    	</div>
	        <label for="maker-name">메이커 명</label>
	        <input type="text" id="maker-name" name="maker_name" disabled="disabled" value="${makerInfo.maker_name}">
	
	        <small>40자 제한</small>
	
	        <label>메이커 프로필 이미지</label>
	        <input type="file" id="fileInput" name="profileImg" accept="image/*" style="display: none;" disabled="disabled">
	        <img id="previewImage" class="preview" src="${makerInfo.profile_img}">
	
	        <label for="email">문의 이메일</label>
	        <input type="email" id="email" name="maker_email" disabled="disabled" value="${makerInfo.maker_email}">
	
	        <label for="phone">문의 전화번호</label>
	        <input type="tel" id="phone" name="maker_phone" disabled="disabled" value="${makerInfo.maker_phone}">
	
	        <label>SNS(선택)</label>
	        <input type="text" name="facebook_address" disabled="disabled" placeholder="facebook 주소 입력" value="${makerInfo.facebook_address}">
	        <input type="text" name="twitter_address" disabled="disabled" placeholder="twitter 주소 입력" value="${makerInfo.twitter_address}">
	        <input type="text" name="instagram_address" disabled="disabled" placeholder="instagram 주소 입력" value="${makerInfo.instagram_address }">
	    </div>
    </div>
    <footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>
