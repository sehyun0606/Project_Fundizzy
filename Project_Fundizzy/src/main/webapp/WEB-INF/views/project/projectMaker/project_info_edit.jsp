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
	        <h1 class="title">프로젝트 정보</h1>
	        <form id="info-form" enctype="multipart/form-data" method="POST" action="ProjectInfoEdit">
	        	<input type="hidden" name="project_code" value="${sessionScope.project_code}">
	        	<input type="hidden" id="main-category" name="category" value="${projectInfo.category}">
	        	<input type="hidden" id="sub-category" name="sub_category" value="${projectInfo.sub_category}">
	        	<input type="hidden" id="adult_check" name="adult_check" value="${projectInfo.adult_check}">
	        	<input type="hidden" id="target_amount" name="target_amount" value="${projectInfo.target_amount}">
	        	<input type="hidden" id="maker_type" name="maker_type" value="${projectInfo.maker_type}">
	        	<input type="file" id="file2" name="registrationCard" style="display: none;">
	        	<input type="hidden" id="business_name" name="business_name"  value="${projectInfo.business_name}">
	        	<input type="hidden" id="business_number" name="business_number" value="${projectInfo.business_number}">
	        	<input type="hidden" id="repersentative_name" name="representative_name" value="${projectInfo.representative_name}">
	        	<input type="hidden" id="repersentative_email" name="representative_email" value="${projectInfo.representative_email}">
	        	<input type="hidden" id="delivery_fee" name="delivery_fee" value="${projectInfo.delivery_fee}">
	        </form>
	        <!-- 카테고리 선택 -->
		    <button class="side-button" id="submit-button" style="margin-left: 90%;"> 제출하기</button>
	        <label class="label">카테고리 선택</label> 
	        <select class="select main-category" required="required">
	            <option value="">카테고리 선택</option>
	            <option value="electric" ${projectInfo.category eq 'electric' ? 'selected' : ''}>테크,가전</option>
	            <option value="furniture" ${projectInfo.category eq 'furniture' ? 'selected' : ''}>홈,리빙</option>
	            <option value="furniture" ${projectInfo.category eq 'fashion' ? 'selected' : ''}>패션</option>
	            <option value="furniture" ${projectInfo.category eq 'beauty' ? 'selected' : ''}>스포츠</option>
	            <option value="furniture" ${projectInfo.category eq 'sports' ? 'selected' : ''}>패션</option>
	            <option value="furniture" ${projectInfo.category eq 'food' ? 'selected' : ''}>푸드</option>
	            <option value="furniture" ${projectInfo.category eq 'book' ? 'selected' : ''}>도서</option>
	            <option value="furniture" ${projectInfo.category eq 'electricBook' ? 'selected' : ''}>전자책,클래스</option>
	            <option value="furniture" ${projectInfo.category eq 'animal' ? 'selected' : ''}>반려동물</option>
	            <option value="furniture" ${projectInfo.category eq 'art' ? 'selected' : ''}>아트</option>
	            <option value="furniture" ${projectInfo.category eq 'charactor' ? 'selected' : ''}>캐릭터</option>
	            <option value="furniture" ${projectInfo.category eq 'movieMusic' ? 'selected' : ''}>영화,음악</option>
	        </select>
	        
	        <label class="label">보조 카테고리 선택(선택)</label>
	        <select class="select sub-category" required="required">
	            <option value="">카테고리 선택</option>
	            <option value="electric" ${projectInfo.category eq 'electric' ? 'selected' : ''}>테크,가전</option>
	            <option value="furniture" ${projectInfo.category eq 'furniture' ? 'selected' : ''}>홈,리빙</option>
	            <option value="furniture" ${projectInfo.category eq 'fashion' ? 'selected' : ''}>패션</option>
	            <option value="furniture" ${projectInfo.category eq 'beauty' ? 'selected' : ''}>스포츠</option>
	            <option value="furniture" ${projectInfo.category eq 'sports' ? 'selected' : ''}>패션</option>
	            <option value="furniture" ${projectInfo.category eq 'food' ? 'selected' : ''}>푸드</option>
	            <option value="furniture" ${projectInfo.category eq 'book' ? 'selected' : ''}>도서</option>
	            <option value="furniture" ${projectInfo.category eq 'electricBook' ? 'selected' : ''}>전자책,클래스</option>
	            <option value="furniture" ${projectInfo.category eq 'animal' ? 'selected' : ''}>반려동물</option>
	            <option value="furniture" ${projectInfo.category eq 'art' ? 'selected' : ''}>아트</option>
	            <option value="furniture" ${projectInfo.category eq 'charactor' ? 'selected' : ''}>캐릭터</option>
	            <option value="furniture" ${projectInfo.category eq 'movieMusic' ? 'selected' : ''}>영화,음악</option>
	        </select>
	        
	        <!-- 성인 인증 -->
	        <label class="label">성인 인증(선택)</label>
	        <c:choose>
		        <c:when test="${adult_check eq 'Y'}">
			        <div class="checkbox-container">
			            <input type="checkbox" id="adult" checked="checked">
			            <label for="adult">19세 이상만 참여 가능한 리워드예요</label>
			        </div>
		        </c:when>
	        	<c:otherwise>
			        <div class="checkbox-container">
			            <input type="checkbox" id="adult" >
			            <label for="adult">19세 이상만 참여 가능한 리워드예요</label>
			        </div>
	        	</c:otherwise>
	        </c:choose>
	        
	        <!-- 메이커 유형 -->
	        <label class="label">메이커 유형</label>
	        <div class="button-group">
	            <button id="individual" class="btn active">개인</button>
	            <button id="sole-proprietor" class="btn">개인 사업자</button>
	            <button id="proprietor" class="btn">법인 사업자</button>
	        </div>
	
	        <!-- 신청폼 -->
	        <label class="label" >신분증</label>
	        <input type="file" id="fileInput" class="input id-card" required="required" >
	        <img id="previewImage" src="/resources/upload/${projectInfo.registration_card}" style="width: 200px; height: 200px;">
	        
	       
	        <label class="label license"style="display: none;" >사업자 등록 번호</label>
	        <input type="text"  class="input license" placeholder="사업자 등록 번호" style="display: none;" value="${projectInfo.business_number}" required="required">
	        
	        <label class="label license"style="display: none;" >상호명</label>
	        <input type="text"  class="input license" placeholder="상호명" style="display: none;"  value="${projectInfo.business_name}" required="required">
	        
	        <label class="label">대표자명</label>
	        <input type="text" class="input name" placeholder="대표자명" value="${projectInfo.representative_name}" required="required">
	
	        <label class="label">대표자 이메일</label>
	        <input type="email" class="input email" placeholder="이메일" value="${projectInfo.representative_email}" required="required">
	
	        <!-- 목표 금액 -->
	        <label class="label">목표 금액</label>
	        <input type="number" id="amount" class="input" placeholder="최소 50만원 ~ 1억원 사이에서 설정해주세요."  value="${projectInfo.target_amount}"required="required">
	        <label class="label">배송비</label>
	        <input type="number" id="delivery" class="input" placeholder="배송비를 입력해주세요" required="required"value="${projectInfo.delivery_fee }">
	    </div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
<script type="text/javascript">
	$(document).ready(function() {
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
	    $("#delivery").keyup(function() {
	        $("#delivery_fee").val($(this).val());
	    });
	    
	    $("#submit-button").click(function(event){
	        let isValid = true;
	        let emptyFields = [];

	        // 필드명 한글 매핑
	        let fieldNames = {
	            "category": "카테고리",
	            "sub_category": "보조 카테고리",
	            "adult_check": "성인 인증",
	            "repersentative_email": "대표자 이메일",
	            "target_amount": "목표 금액",
	            "maker_type": "메이커 유형",
	            "repersentative_name": "대표자명",
	            "registration_card": "신분증 또는 사업자 등록증"
	        };


	        // maker_type이 개인 사업자나 법인 사업자일 때 사업자 등록번호와 상호명 검사 추가
	        if ($("#maker_type").val() === "sole-proprietor" || $("#maker_type").val() === "proprietor") {
	            if ($("#business_number").val().trim() === "") {
	                isValid = false;
	                emptyFields.push("사업자 등록 번호");
	            }
	            if ($("#business_name").val().trim() === "") {
	                isValid = false;
	                emptyFields.push("상호명");
	            }
	        }


	        // 모든 text, number, email input 검사
	        $(".name, input[type='number'], input[type='email']").each(function() {
	            if ($(this).val().trim() === "") {
	                let placeholderText = $(this).attr("placeholder");
	                emptyFields.push(placeholderText || "입력 필드");
	                isValid = false;
	            }
	        });

	        // 모든 select 검사
	        $("select").each(function() {
	            if ($(this).val() === "") {
	                emptyFields.push($(this).prev("label").text() || "선택 필드");
	                isValid = false;
	            }
	        });

	        // 하나라도 비어 있으면 경고창 띄우고 제출 막기
	        if (!isValid) {
	            alert("다음 항목을 입력해주세요: \n- " + emptyFields.join("\n- "));
	            return false; // 폼 제출 중단
	        }

	        $("#info-form").submit(); // 모든 검사가 통과되면 제출
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
		    }
		});


	});	
</script>
</body>
</html>
