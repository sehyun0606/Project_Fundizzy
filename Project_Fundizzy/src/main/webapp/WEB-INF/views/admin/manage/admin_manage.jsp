<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 관리</title>
    <script src="resources/js/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="resources/css/admin/manage/admin_manage.css" />
</head>
<body>
	<!-- top.jsp -->
	<header>
		<jsp:include page="/WEB-INF/views/admin/inc/admin_top.jsp" />
	</header>

	<article>
		<!-- sidebar.jsp -->
		<jsp:include page="/WEB-INF/views/admin/inc/admin_sidebar.jsp" />
		
		<!-- 고정된 main-content -->
		<div class="main-content">
			<h2 class="section-title">관리자 관리</h2>

			<!-- 관리자 등록 및 삭제 컨테이너 -->
			<div class="admin-container">
				<!-- 관리자 등록 -->
				<div class="admin-section">
					<h3 class="sub-title">관리자 등록</h3>
					<form action="adminAdd" method="post" class="admin-form">
						<div class="input-row">
							<select name="searchType" id="submitTeam">
								<option value="부서" selected>부서</option>
								<option value="인사" >인사</option>
								<option value="프로젝트" >프로젝트</option>
								<option value="결제" >결제</option>
								<option value="관리자" >총 관리자</option>
							</select>
							<input type="text" name="submitId" id="submitId" placeholder="아이디를 입력하세요" required>
						</div>
						<div class="input-row">
							<input type="text" name="adminName" id="submitName" placeholder="이름을 입력하세요" style="width: 168px" required>
							<input type="text" name="adminPasswd" id="submitPasswd" placeholder="비밀번호를 입력하세요" required>
						</div>
						<button type="submit" class="submit-btn">등록</button>
					</form>
				</div>

				<!-- 관리자 삭제 -->
				<div class="admin-section">
					<h3 class="sub-title">관리자 삭제</h3>
					<form action="/admin/delete" method="post" class="admin-form">
						<div class="input-row">
							<select name="team" required>
								<option value="" selected>부서</option>
								<option value="" >인사</option>
								<option value="" >프로젝트</option>
								<option value="" >결제</option>
								<option value="" >커뮤니티</option>
							</select>
							<input type="text" name="deleteId" placeholder="아이디를 입력하세요" >
<!-- 							<input type="text" name="department" placeholder="부서" required> -->
						</div>
						<div class="input-row">
							<input type="text" name="position" placeholder="관리자 성함을 입력하세요" required>
						</div>
						<button type="submit" class="delete-btn">삭제</button>
					</form>
				</div>
				
				<!-- 관리자 조회 -->
				<div class="admin-section">
					<h3 class="sub-title">관리자 권한 부여</h3>
					<form action="/admin/delete" method="post" class="admin-form">
						<div class="input-row">
							<select name="searchType">
								<option value="" selected>부서</option>
								<option value="" >인사</option>
								<option value="" >프로젝트</option>
								<option value="" >결제</option>
								<option value="" >커뮤니티</option>
							</select>
							<input type="text" name="deleteId" placeholder="아이디를 입력하세요" >
<!-- 							<input type="text" name="department" placeholder="부서" required> -->
						</div>
						<div class="input-row">
							<input type="text" name="position" placeholder="관리자 성함을 입력하세요" required>
						</div>
						<button type="submit" class="select-btn">조회</button>
					</form>
				</div>
			</div>
			
			<div class="member-info">
		        <h2 class="member_info_title">관리자 정보</h2>
	        	<form action=""> 
			        <div class="search-bar">
			        	<select name="searchType" class="searchTypeAdmin">
							<option value="" selected>부서</option>
							<option value="" >인사</option>
							<option value="" >프로젝트</option>
							<option value="" >결제</option>
							<option value="" >커뮤니티</option>
						</select>
			            <input type="text" placeholder="관리자명">
			            <button class="search-btn">검색</button>
			        </div>
	            </form>
		
		        <table>
		            <thead>
		            <tr>
		                <th>이메일</th>
		                <th>닉네임</th>
		                <th>가입 날짜</th>
		                <th>상태</th>
		                <th>이미지</th>
		            </tr>
		            </thead>
		            <tbody>
		            	<c:forEach var="member" items="${memberInfo}" varStatus="status">
			                <c:if test="${status.index < 8}"> <%-- 0~4 번째 요소(5개)만 출력 --%>
			                    <tr onclick="location.href='#'">
			                        <td>${member.email}</td>
			                        <td>${member.nickname}</td>
			                        <td>
			                            <fmt:formatDate value="${member.reg_date}" pattern="yyyy-MM-dd HH:mm"/>
			                        </td>
			                        <td>${member.login_type}</td>
			                        <td>${member.profile}</td>
			                    </tr>
			                </c:if>
			            </c:forEach>
		            </tbody>
		        </table>
		    </div>
		</div>
	</article>
	<script type="text/javascript">
		$(document).ready(function () {
		    $(".admin-form").submit(function (event) {
		        event.preventDefault(); // 기본 폼 제출 방지
	
		        // 입력 값 가져오기
       			const submitTeam = $("#submitTeam").val(); // ID 선택자 사용
       			const submitId = $("#submitId").val(); // ID 선택자 사용
       			const submitName = $("#submitName").val(); // ID 선택자 사용
       			const submitPasswd = $("#submitPasswd").val(); // ID 선택자 사용
				console.log(submitTeam + "" + submitId + "" + submitName + "" + submitPasswd);
       			
		        // AJAX 요청 (jQuery 사용)
       			$.ajax({
					type : "POST",
					url : "adminAdd",
					data : {
						admin_team : submitTeam,
						admin_id : submitId,
						admin_name : submitName,
						admin_passwd : submitPasswd
					}
				}).done(function(result) {
					if(result.trim() == "true") {
						alert("관리자 등록 성공!");
						$(".admin-form")[0].reset(); // 폼 초기화
					} else {
						alert("관리자 등록 실패");
						$(".admin-form")[0].reset(); // 폼 초기화
					}
				}).fail(function() {
					alert("오류 발생!");
				});
		    });
		});


	
	</script>
	
	
	
</body>
</html>
