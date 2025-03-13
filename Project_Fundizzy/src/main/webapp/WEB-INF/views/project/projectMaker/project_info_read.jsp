<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 정보</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/projectMaker/project_info.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
	    <div class="container">
	        <h1 class="title">프로젝트 정보 확인</h1>
	        <!-- 카테고리 선택 -->
	        <label class="label">카테고리 선택</label> 
	        <select class="select main-category" disabled="disabled">
	            <option value="">카테고리 선택</option>
	            <option value="electric" ${projectInfo.category eq 'electric' ? 'selected' : ''}>전자기기</option>
	            <option value="furniture" ${projectInfo.category eq 'furniture' ? 'selected' : ''}>가구</option>
	            <option value="life" ${projectInfo.category eq 'life' ? 'selected' : ''}>생활용품</option>
	        </select>
	        
	        <label class="label">보조 카테고리 선택(선택)</label>
	        <select class="select sub-category" disabled="disabled">
	            <option value="">카테고리 선택</option>
	            <option value="electric" ${projectInfo.sub_category eq 'electric' ? 'selected' : ''}>전자기기</option>
	            <option value="furniture" ${projectInfo.sub_category eq 'furniture' ? 'selected' : ''}>가구</option>
	            <option value="life" ${projectInfo.sub_category eq 'life' ? 'selected' : ''}>생활용품</option>
	        </select>
	        
	        <!-- 성인 인증 -->
	        <label class="label">성인 인증(선택)</label>
	        <c:choose>
		        <c:when test="${projectInfo.adult_check eq 'Y'}">
			        <div class="checkbox-container">
			            <input type="checkbox" id="adult" checked="checked" disabled="disabled">
			            <label for="adult">19세 이상만 참여 가능한 리워드예요</label>
			        </div>
		        </c:when>
	        	<c:otherwise>
			        <div class="checkbox-container">
			            <input type="checkbox" id="adult" disabled="disabled">
			            <label for="adult">19세 이상만 참여 가능한 리워드예요</label>
			        </div>
	        	</c:otherwise>
	        </c:choose>
	        
	        <!-- 메이커 유형 -->
	        <label class="label">메이커 유형</label>
	        <div class="button-group">
	            <button id="individual" class="btn active" disabled="disabled">개인</button>
	            <button id="sole-proprietor" class="btn" disabled="disabled">개인 사업자</button>
	            <button id="proprietor" class="btn" disabled="disabled">법인 사업자</button>
	        </div>
	
	        <!-- 신청폼 -->
	        <label class="label" >신분증</label>
	        <img  src="/resources/upload/${projectInfo.registration_card}" style="width: 200px; height: 200px;">
	       
	        <label class="label license"style="display: none;" >사업자 등록 번호</label>
	        <input type="text"  class="input license" placeholder="사업자 등록 번호" style="display: none;" value="${projectInfo.business_number}" disabled="disabled">
	        
	        <label class="label license"style="display: none;" >상호명</label>
	        <input type="text"  class="input license" placeholder="상호명" style="display: none;" value="${projectInfo.business_name}" disabled="disabled">
	        
	        <label class="label">대표자명</label>
	        <input type="text" class="input name" placeholder="대표자명" value="${projectInfo.representative_name }" disabled="disabled">
	
	        <label class="label">대표자 이메일</label>
	        <input type="email" class="input email" placeholder="이메일" value="${projectInfo.representative_email }"  disabled="disabled">
	
	        <!-- 목표 금액 -->
	        <label class="label">목표 금액</label>
	        <input type="number" id="amount" class="input" value="${projectInfo.target_amount}" disabled="disabled">
	    </div>
	</div>
<script type="text/javascript">
function handleButtonClick() {
    $(".button-group .btn").removeClass("active"); // 모든 버튼에서 'active' 제거
    $(this).addClass("active"); // 클릭한 버튼에 'active' 추가
    let makerType = $(this).attr("id");
    $("#maker_type").val(makerType);
    
    if (makerType === 'sole-proprietor' || makerType === 'proprietor') {
        $(".license").css("display", "block");
    } else {
        $(".license").css("display", "none");
    }
}

$(document).ready(function() {
    // projectInfo.maker_type 값을 기반으로 버튼 설정
    let makerType = "${projectInfo.maker_type}";
    if (makerType) {
        $(".button-group .btn").removeClass("active");
        let selectedButton = $("#" + makerType);
        selectedButton.addClass("active");
        $("#maker_type").val(makerType);
        
        if (makerType === 'sole-proprietor' || makerType === 'proprietor') {
            $(".license").css("display", "block");
        } else {
            $(".license").css("display", "none");
        }
    }

});

</script>
</body>
</html>
