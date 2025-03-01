<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	        <h1 class="title">프로젝트 정보</h1>
	        <form>
	        	<input type="hidden" id="main-category" name="category">
	        	<input type="hidden" id="sub-category" name="sub_category">
	        	<input type="hidden" id="adult_check" name="adult_check" value="N">
	        	<input type="hidden" name="repersentative_email">
	        	<input type="hidden" id="target_amount" name="target_amount">
	        	<input type="hidden" id="maker_type" name="maker_type" value="individual">
	        	<input type="file" id="file2" name="registration_card" style="display: none;">
	        	<input type="hidden" id="business_name" name="business_name">
	        	<input type="hidden" id="business_number" name="business_number">
	        	<input type="hidden" id="repersentative_name" name="repersentative_name">
	        	<input type="hidden" id="repersentative_email" name="repersentative_email">
	        </form>
	        <!-- 카테고리 선택 -->
	        <div class="first-label">
		        <label class="label">카테고리 선택</label> 
		        <button class="side-button" onclick="location.href='ProjectMaker'"> 제출하기</button>
	        </div>
	        <select class="select main-category">
	            <option value="">카테고리 선택</option>
	            <option value="electric">전자기기</option>
	            <option value="furniture">가구</option>
	            <option value="life">생활용품</option>
	        </select>
	        
	        <label class="label">보조 카테고리 선택(선택)</label>
	        <select class="select sub-category">
	            <option value="">카테고리 선택</option>
	            <option value="electric">전자기기</option>
	            <option value="furniture">가구</option>
	            <option value="life">생활용품</option>
	        </select>
	        
	        <!-- 성인 인증 -->
	        <label class="label">성인 인증(선택)</label>
	        <div class="checkbox-container">
	            <input type="checkbox" id="adult">
	            <label for="adult">19세 이상만 참여 가능한 리워드예요</label>
	        </div>
	
	        <!-- 메이커 유형 -->
	        <label class="label">메이커 유형</label>
	        <div class="button-group">
	            <button id="individual" class="btn active">개인</button>
	            <button id="sole-proprietor" class="btn">개인 사업자</button>
	            <button id="proprietor" class="btn">법인 사업자</button>
	        </div>
	
	        <!-- 신청폼 -->
	        <label class="label">신분증</label>
	        <input type="file" class="input id-card">
	       
	        <label class="label license"style="display: none;" >사업자 등록 번호</label>
	        <input type="text"  class="input license-num" placeholder="사업자 등록 번호" style="display: none;">
	        
	        <label class="label license"style="display: none;" >상호명</label>
	        <input type="text"  class="input license-name" placeholder="상호명" style="display: none;">
	        
	        <label class="label">대표자명</label>
	        <input type="text" class="input name" placeholder="대표자명">
	
	        <label class="label">대표자 이메일</label>
	        <input type="email" class="input email" placeholder="이메일">
	
	        <!-- 목표 금액 -->
	        <label class="label">목표 금액</label>
	        <input type="number" id="amount" class="input" placeholder="최소 50만원 ~ 1억원 사이에서 설정해주세요.">
	    </div>
	</div>
<script type="text/javascript">
	$(document).ready(function() {
	    $(".button-group .btn").click(function() {
	        $(".button-group .btn").removeClass("active"); // 모든 버튼에서 'active' 제거
	        $(this).addClass("active"); // 클릭한 버튼에 'active' 추가
	        let makerType = $(this).attr("id");
	        $("#maker_type").val(makerType);
	        
	        if(makerType == 'sole-proprietor' || makerType == 'proprietor'){
	        	$(".license").css("display", "block");
	        }else{
	        	$(".license").css("display", "none");
	        }
	    });
	    
	    $(".main-category").change(function(){
	    	$("#main-category").val($(this).val());
	    })
	    
	    $(".sub-category").change(function(){
	    	$("#sub-category").val($(this).val());
	    })
	    
	    $("#adult").change(function(){
	    	if($(this).is(":checked")) {
	    		$("#adult_check").val("Y");
	    	} else {
	    		$("#adult_check").val("N");
	    	}
	    })
	    
	    $('.id-card').change(function() {
            var file = this.files[0]; // #file1에서 선택된 파일
            var dataTransfer = new DataTransfer(); // 새로운 DataTransfer 객체 생성

            dataTransfer.items.add(file); // file1에서 선택한 파일을 DataTransfer에 추가
            $('#file2')[0].files = dataTransfer.files; // #file2에 해당 파일 설정
        });
	    
	    
	    $(".license-num").keyup(function() {
	        $("#business_number").val($(this).val());
	    });
	    
	    $(".license-name").keyup(function() {
	        $("#business_name").val($(this).val());
	    });
	    
	    $(".name").keyup(function() {
	        $("#repersentative_name").val($(this).val());
	    });
	    
	    $(".email").keyup(function() {
	        $("#repersentative_email").val($(this).val());
	    });
	    
	    $("#amount").keyup(function() {
	        $("#target_amount").val($(this).val());
	    });
	});	
</script>
</body>
</html>
