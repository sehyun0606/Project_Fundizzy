<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 대시보드</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/myPage/supporter/supporter_mypage.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/myPage/maker/maker_mypage.css">
<body>


<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>


<div class="container">

	<div >
		<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>

	</div>
    
    <!-- 메인 콘텐츠 -->
    <main class="main-content">
        
            <h2>${sessionScope.sId} 님 안녕하세요 - 서포터 마이 페이지</h2> 
            <p></p>
            
            

        <div class="user-info-container"> 
	        <!-- 상단 프로필 정보 -->
	        <section class="user-info">
	            <div class="user-stats">
	                <div class="stat-item1">
	                	<img class="icon" src="${pageContext.request.contextPath}/resources/images/myPage/free-icon-cart-709782.png">
	                    <a href="FundHistory">펀딩</a>
	                </div>
	                <div class="stat-item2" style="margin: 0;">
	                	<img class="icon2"  src="${pageContext.request.contextPath}/resources/images/myPage/free-icon-business-people-8452029.png">
	                    <a href="MySupport">지지서명</a>
	                </div>
	                <div class="stat-item3">
	                	<img class="icon" src="${pageContext.request.contextPath}/resources/images/myPage/free-icon-heart-shape-outline-25424.png">
	                    <a href="LikeHistory">찜한상품</a>
	                </div>
	                <div class="stat-item4">
	                	<img class="icon" src="${pageContext.request.contextPath}/resources/images/myPage/free-icon-bell-alarm-7887462.png">
	                    <a href="NotificationSetPage">알림설정</a>
	                </div>
	            </div>    
	        </section>
	
	</div>
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
			    					<c:if test="${project.approve_stat eq 'accept' && project.date_config eq'N' }">
						                <div class="project-status">기간 설정 필요</div>
			    					</c:if>
			    					<c:if test="${project.approve_stat eq 'accept' && project.date_config eq 'Y' }">
						                <div class="project-status">진행중</div>
			    					</c:if>
			    					<c:if test="${project.approve_stat eq 'deny' }">
						                <div class="project-status">반려됨</div>
			    					</c:if>
			    					
				            	</div>
			    			</c:forEach>
				        </div>
		    		</c:otherwise>
		    	</c:choose>
		        <button class="create-project-button">프로젝트 만들기</button>
		    </div>


    </main>
    
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

<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
<script type="text/javascript">
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
