<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 관리</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/css/projectMaker/project_maker_home.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
		
	    <div class="container">
	        <div class="header">프로젝트 관리</div>
	        <div class="status-box">
	            <span>프로젝트 준비 상태</span>
	            <button>제출하기</button>
	        </div>
	        
	        	<c:choose>
		        	<c:when test="${projectSetting.service_config eq 'Y' }">
				        <div class="task">
				            <div class="task-title">
				                <div class="progress-bar progress-complete"></div>
				                서비스 요금 <span class="status">작성 완료</span>
				            </div>
				            <button onclick="location.href='ProjectPlan'">수정하기</button>
				        </div>
		        	</c:when>
		        	<c:otherwise>
				        <div class="task">
				            <div class="task-title">
				                <div class="progress-bar progress-incomplete"></div>
				                서비스 요금 <span class="status">작성 전</span>
				            </div>
				            <button onclick="location.href='ProjectPlan'">작성하기</button>
				        </div>
		        	</c:otherwise>
		        </c:choose>
		        
		        <c:choose>
		        	<c:when test="${projectSetting.project_info_config eq 'Y' }">
				        <div class="task">
				            <div class="task-title">
				                <div class="progress-bar progress-complete"></div>
				                프로젝트 정보 <span class="status">작성 완료</span>
				            </div>
				            <button onclick="location.href='ProjectInfoEdit'">수정하기</button>
				        </div>
		        	</c:when>
		        	<c:otherwise>
				        <div class="task">
				            <div class="task-title">
				                <div class="progress-bar progress-incomplete"></div>
				                프로젝트 정보 <span class="status">작성 전</span>
				            </div>
				            <button onclick="location.href='ProjectInfo'">작성하기</button>
				        </div>
		        	</c:otherwise>
		        </c:choose>
		        
		        <c:choose>
		        	<c:when test="${projectSetting.story_config eq 'Y' }">
				        <div class="task">
				            <div class="task-title">
				                <div class="progress-bar progress-complete"></div>
				                스토리 작성 <span class="status">작성 완료</span>
				            </div>
				            <button onclick="location.href='ProjectStoryEdit'">수정하기</button>
				        </div>
		        	</c:when>
		        	<c:otherwise>
				        <div class="task">
				            <div class="task-title">
				                <div class="progress-bar progress-incomplete"></div>
				                스토리 작성 <span class="status" >작성 전</span>
				            </div>
				            <button onclick="location.href='ProjectStory'">작성하기</button>
				        </div>
		        	</c:otherwise>
		        </c:choose>
		        <c:choose>
		        	<c:when test="${projectSetting.reward_config eq 'Y' }">
		        		<div class="task">
				            <div class="task-title">
				                <div class="progress-bar progress-complete"></div>
				               	 리워드 설계 <span class="status" >작성 완료</span>
				            </div>
		            		<button  onclick="location.href='ProjectReward'">수정하기</button>
		        		</div>
		        	</c:when>
		        	<c:otherwise>
		        		<div class="task">
				            <div class="task-title">
				                <div class="progress-bar progress-incomplete"></div>
				               	 리워드 설계 <span class="status">작성 전</span>
				            </div>
		            		<button  onclick="location.href='ProjectReward'">작성하기</button>
		        		</div>
		        	</c:otherwise>
		        </c:choose>
		        <c:choose>
		        	<c:when test="${projectSetting.maker_config eq 'Y' }">
				        <div class="task">
				            <div class="task-title">
				                <div class="progress-bar progress-complete"></div>
				                메이커 정보 <span class="status">작성 완료</span>
				            </div>
				            <button onclick="location.href='MakerInfoEdit'" >수정하기</button>
				        </div>
		        	</c:when>
		        	<c:otherwise>
				        <div class="task">
				            <div class="task-title">
				                <div class="progress-bar progress-incomplete"></div>
				                메이커 정보 <span class="status">작성 전</span>
				            </div>
				            <button onclick="location.href='MakerInfo'">작성하기</button>
				        </div>
		        	</c:otherwise>
		        </c:choose>
	        
	        
	    </div>
    </div>
    <script>
    
    </script>
</body>
</html>
