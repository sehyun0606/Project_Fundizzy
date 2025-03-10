<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 리스트</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/maker/maker_mypage.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div class="main">
	<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>
		<div class="main-container">
		    <div class="project-container">
		    	<c:choose>
		    		<c:when test="${empty projectList}">
			    		<div class="funding-box">
				            제작 중인 프로젝트가 없어요. <br>
				            지금 바로 펀디지에서 새로운 프로젝트를 시작해 보세요.
			        	</div>
		    		</c:when>
		    		<c:otherwise>
		    			
			    		<div class="project-title">만든 프로젝트 <span style="color: mediumpurple;">${projectCount}</span></div>
				        <div class="project-list">
					        <c:forEach items="${projectList}" var="project">
			    				<div class="project-box">
			    					<form action="ProjectMaker" method="POST">
				    					<input type="hidden" class="project-code" name="project_code" value="${project.project_code}">
			    					</form>
			    					<c:choose>
			    						<c:when test="${empty project.representative_picture}">
							                <div class="image-placeholder">이미지 등록 필요</div>
			    						</c:when>
			    						<c:otherwise>
			    							<img src="/resources/upload/${project.representative_picture}" style="width: 100%; height: 120px;">
			    						</c:otherwise>
			    					</c:choose>
			    					<c:choose>
			    						<c:when test="${empty project.project_title}">
							                <div class="title-input">
							                <c:choose>
							                	<c:when test="${project.common_code eq 'PRO01' }">
							                		(펀딩)
							                	</c:when>
							                	<c:otherwise>
							                		(프리오더)
							                	</c:otherwise>
							                </c:choose>
							                제목을 입력해주세요</div>
			    						</c:when>
			    						<c:otherwise>
							                <div class="title-input">
							                <c:choose>
							                	<c:when test="${project.common_code eq 'PRO01' }">
							                		(펀딩)
							                	</c:when>
							                	<c:otherwise>
							                		(프리오더)
							                	</c:otherwise>
							                </c:choose>
							                ${project.project_title}</div>
			    						</c:otherwise>
			    					</c:choose>
			    					<div class="title-input"><fmt:formatDate value="${project.project_date}" pattern="yyyy-MM-dd"/></div>
			    					<c:if test="${project.approve_stat eq 'before' }">
						                <div class="project-status">작성 중</div>
			    					</c:if>
			    					<c:if test="${project.approve_stat eq 'request' }">
						                <div class="project-status">등록 요청 중</div>
			    					</c:if>
				            	</div>
			    			</c:forEach>
				        </div>
		    		</c:otherwise>
		    	</c:choose>
		        <button class="create-project-button">프로젝트 만들기</button>
		    </div>
		
		    <div class="data-container">
		        <div class="data-header">
		            오늘 데이터 한 번에 보기 <span class="refresh-icon">🔄</span>
		        </div>
		        <div class="data-summary">
		            <div>찜 · 알림신청 -</div>
		            <div>결제(예약) -</div>
		            <div>지지서명 -</div>
		            <div>앵콜요청 -</div>
		        </div>
		    </div>
		
		    <div class="funding-container">
		        <div class="funding-title">오늘 펀딩·프리오더</div>
		        <div class="funding-box">
		            진행 중인 프로젝트가 없어요. <br>
		            지금 바로 펀디지에서 새로운 프로젝트를 시작해 보세요.
		        </div>
		    </div>
	    </div>
	</div>
	<div id="project-modal" class="modal">
        <div class="modal-content">
	            <span class="close">&times;</span>
	            <div class="modal-title">새 프로젝트 만들기</div>
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
			    <form action="MakeProject" method="POST">
			    	<input type="hidden" class="common_code" name="common_code">
			    	<input type="hidden" value="${sessionScope.sId}" name="member_email"> 
		            <button class="modal-button">프로젝트 생성</button>
			    </form>
        </div>
    </div>
    <script>
        $(document).ready(function() {
            // 모달 열기
            $(".create-project-button").click(function() {
                $("#project-modal").fadeIn();
            });

            // 모달 닫기 (× 버튼)
            $(".close").click(function() {
                $("#project-modal").fadeOut();
            });

            // 모달 닫기 (배경 클릭)
            $(window).click(function(event) {
                if ($(event.target).is("#project-modal")) {
                    $("#project-modal").fadeOut();
                }
            });
            // 체크된 라디오 버튼의 ID 값 가져오기
            function getCheckedRadioId() {
                return $("input[name='project-type']:checked").attr("id");
            }

            // 페이지 로드 시 초기 체크된 라디오 버튼 ID 확인
            var initialCheckedId = getCheckedRadioId();
            $(".common_code").val("PRO01")

            // 라디오 버튼 변경 시마다 ID 값 출력
            $("input[name='project-type']").change(function() {
                var checkedId = getCheckedRadioId();
                if(checkedId == "funding"){
                	$(".common_code").val("PRO01")
                }else{
                	$(".common_code").val("PRO02")
                }
            });
            
            //프로젝트 클릭 시 해당 프로젝트메이커로 이동
            $(".project-box").click(function(){
            	$(this).find("form").submit();
            });
        });
    </script>
</body>
</html>
