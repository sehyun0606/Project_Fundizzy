<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fundizzy 문의 등록</title>
<link rel="stylesheet" type="text/css" href="resources/css/helpCenter/qna_form.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="resources/js/jquery-3.7.1.js"></script>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/main_top.jsp" />
    </header>

    <article class="qna-container">
        <!-- 네비게이션 (Breadcrumb) -->
        <nav class="breadcrumb">
            <a href="HelpCenter">펀디즈 도움말 센터</a> / <span>문의 등록</span>
        </nav>

        <h1 class="qna-title">문의 등록</h1>

        <form action="submitQna" method="get" class="qna-form">
	        <div class="form-group">
	            <label for="qna-type">어떤 도움이 필요하신가요?</label>
	            <select id="qna-type" name="qnaType">
	                <option value="">문의 유형을 선택하세요</option>
	                <option value="펀디즈">펀디즈 문의하기</option>
	                <option value="서포터">서포터 문의하기</option>
	                <option value="메이커">메이커 문의하기</option>
	                <option value="비회원">비회원 문의하기</option>
	                <option value="기타">기타 문의</option>
	            </select>
			</div>
            
            <div class="form-group required-field">
			    <label for="email">이메일 주소 <span class="required">*</span></label>
			    <input type="email" id="email" name="email" required>
			</div>
			
			<div class="form-group optional fundizzy-maker-supporter">
			    <label for="fundizzy-id">펀디즈 이메일 계정</label>
			    <input type="text" id="fundizzy-email" name="fundizzyEmail">
			</div>
			
			<div class="form-group optional guest">
			    <label for="contact">성함 입력(실명) <span class="required">*</span></label>
			    <input type="text" id="name" name="name" >
			</div>
			
			<div class="form-group optional maker">
			    <label for="project-number">※ 프로젝트 번호</label>
			    <input type="text" id="project-number" name="projectNumber">
			</div>
			
			<div class="form-group optional supporter">
			    <label for="order-number">결제번호/ 주문번호</label>
			    <input type="text" id="order-number" name="orderNumber">
			</div>

			<div class="form-group required-field">
            	<label for="qna-content">문의 내용을 입력해 주세요.</label>
			</div>
            <textarea id="qna-content" name="qnaContent" rows="6" required></textarea>

            <div class="qna-agreement">
                <input type="checkbox" id="privacy-agreement" name="privacyAgreement" required>
                <label for="privacy-agreement">※ 아래 개인정보 수집 및 이용 약관을 확인하신 후 동의해주세요. <span class="required">*</span></label>
            </div>

            <div class="qna-privacy-info">
                <p><strong>네, 동의합니다.</strong></p>
                <ul>
                    <li>① 수집항목: (필수) 이메일 주소, 연락처, 이름 (선택) 외부 이메일 계정</li>
                    <li>② 수집목적: 원활한 답변 및 정보 제공</li>
                    <li>③ 보유기간: 정보 수집으로부터 3년 후 파기</li>
                </ul>
                <p class="privacy-note">
                    개인정보 수집 동의를 거부할 수 있으나, 거부할 경우 업무 처리의 부재로 답변 및 상담이 제한될 수 있습니다.
                </p>
            </div>
            
           	<label for="file-upload">첨부 파일 선택</label>
            <div class="file-upload required-field">
                <input type="file" id="file-upload" name="fileUpload">
            </div>

            <button type="submit" class="submit-btn">제출</button>
        </form>
    </article>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/footer.jsp" />
    </footer>

    <script>
	    $(document).ready(function () {
	        // 모든 optional 필드 숨김
	        $(".optional").hide();
	
	        $("#qna-type").change(function () {
	            var selectedType = $(this).val();
	
	            // 모든 optional 필드 숨기기
	            $(".optional").hide();
	
	            // 선택한 유형에 맞는 필드만 보이기
	            if (selectedType === "fundizzy") {
	                $(".fundizzy-maker-supporter, .fundizzy").show();
	            } else if (selectedType === "supporter") {
	                $(".supporter, .fundizzy-maker-supporter").show();
	            } else if (selectedType === "maker") {
	                $(".maker, .fundizzy-maker-supporter").show();
	            } else if (selectedType === "guest") {
	                $(".guest").show();
	            } 
	            
	        });
	    });
    </script>
</body>
</html>
