<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로필 정보 설정</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/profile_settings.css">
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>

<body>
<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
<div class="main">
<div class="profile-container">
    <h1 class="profile-title">프로필 정보 설정</h1>
	<form action="ProfileInfoEdit" method="post" enctype="multipart/form-data">
	    <!-- 프로필 이미지 업로드 -->
	    <div class="profile-image-section">
	        <input type="file" id="fileInput" name="proFile" accept="image/*" style="display: none;">
	        <c:choose>
	        	<c:when test="${empty member.profile}">
			        <img id="previewImage" class="preview" src="" alt="미리보기" style="display:none;">
	        	</c:when>
	        	<c:otherwise>
			        <img id="previewImage" class="preview" src="/resources/upload/${member.profile}" alt="미리보기" style="display:none;">
	        	</c:otherwise>
	        </c:choose>
	        <div class="profile-buttons">
	            <button class="image-upload">프로필 사진 등록하기</button>
	        </div>
	    </div>
	
	
	    <!-- 입력 필드 -->
	    <div class="input-section">
			
			<input type="text" placeholder="이름을 설정해주세요" class="input-box" value="${member.nickname}">
	           
           <div class="input-group">
               <input type="email" value="${member.email }" class="input-box" readonly="readonly">
           </div>

           <div class="input-group">
               <input type="text" value="${member.phone}" class="input-box" readonly="readonly">
               <button type="button" class="btn edit">변경</button>
           </div>
           
	        <label>간단한 한 마디로 나를 소개해주세요</label>
	        <textarea placeholder="" name="introduction">${member.introduction}</textarea>
	    </div>
	
	    <!-- 버튼 -->
	    <div class="button-group">
	        <button class="cancel-btn">취소</button>
	        <button class="confirm-btn">확인</button>
	    </div>
    </form>
</div>
</div>
<script type="text/javascript">
$(document).ready(function() { 
	$(".image-upload").click(function() {
	        $("#fileInput").click();
	});
	
	$("#fileInput").change(function(event) {
	    let file = event.target.files[0]; 
	    if (file) {
	        let reader = new FileReader();
	        reader.onload = function(e) {
	            $("#previewImage").attr("src", e.target.result).show(); 
	            $(".image-upload").hide(); 
	        };
	        reader.readAsDataURL(file); 
	        $("#fileName").text(file.name);
	    } else {
	        $("#previewImage").hide(); 
	        $(".image-upload").show(); 
	        $("#fileName").text("0/1");
	    }
	});
	$(".preview").click(function(){
		$("#fileInput").click();
	});	
});
</script>
</body>
</html>
