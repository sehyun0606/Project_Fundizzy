<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fundizzy</title>
    <style>
        .top-items {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            color: #565656;
        }
        body {
            font-family: Arial, sans-serif;
        }
        .top-menu {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            border-bottom: 1px solid #ddd;
            height: 60px;
        }
        .logo {
            font-size: 20px;
            font-weight: bold;
        }
        .nav-links {
            display: flex;
            gap: 15px;
        }
        .nav-links a {
            text-decoration: none;
            color: black;
        }
        .nav-links a.active {
            color: mediumpurple;
        }
        .search-bar {
            border: 1px solid mediumpurple;
            padding: 5px 10px;
            border-radius: 15px;
            width: 300px;
        }
        .auth-links {
            display: flex;
            gap: 10px;
            height: min-content;
            align-items: center;
        }
        .create-project {
            background-color: mediumpurple;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
        }
        .nav{
        	margin-left: 15%;
        	display: flex;
        	width: 23%;
        	justify-content: space-between;
        	font-size: large;
        }
        .log-in{
        	display: flex;
        	width: 400px;
        	justify-content: space-between;
        	margin-right: 150px;
        	align-items: center;
        }
        .auth-links a{
        	text-decoration: none;
        }
        .bell{
        	width: 30px;
        	height: 30px;
        	color: purple;
        }
        .home{
	        text-decoration: none;
	   		color: mediumpurple;
        }
    </style>
</head>
<body>
    <div class="top-menu top-items">
    	<div class="nav top-items">
	        <div class="logo top-items"><a class="home" href="/">Fundizzy</a></div>
	        <div class="nav-links top-items">
	            <b><a href="#" class="active top-items">오픈예정</a></b>
	            <b><a href="FundList" class="top-items">펀딩</a></b>
	            <b><a href="PreOrderList" class="top-items">프리오더</a></b>
	            <b><a href="HelpCenter" class="top-items">도움말센터</a></b>
	        </div>
    	</div>
        <input type="text" class="search-bar  top-items"  placeholder="검색">
        <div class="log-in top-items">
	        <div class="auth-links top-items">
		        <c:choose>
					<c:when test="${empty sessionScope.sId}"> <%-- 미 로그인 시 --%>
			            <a href="Login" class="top-items">로그인</a>
			            <a href="SignUp" class="top-items">회원가입</a>
		<!-- 				<a href="MemberLogin">로그인</a> |  -->
		<!-- 				<a href="MemberJoin">회원가입</a> -->
					</c:when>
					<c:otherwise> <%-- 로그인 한 사용자일 경우 --%>
						<c:choose>
							<c:when test="${sessionScope.loginType == 'kakao'}">
							    <a href="NotificationBoard"><img class="bell" src="/resources/images/bell.png"></a>
								<a href="SupporterPage" class="top-items">${DBKakaoUserInfo.nickname}</a> 님 | 
								<a href="javascript:void(0)" onclick="logout()">로그아웃</a>
							</c:when>
							<c:when test="${sessionScope.loginType == 'naver'}">
							    <a href="NotificationBoard"><img class="bell" src="/resources/images/bell.png"></a>
								<a href="SupporterPage" class="top-items">${DBNaverUserInfo.nickname}</a> 님 | 
								<a href="javascript:void(0)" onclick="logout()">로그아웃</a>
							</c:when>
							<c:when test="${sessionScope.loginType == 'local'}">
							    <a href="NotificationBoard"><img class="bell" src="/resources/images/bell.png"></a>
								<a href="SupporterPage" class="top-items">${member.nickname}</a> 님 | 
								<a href="javascript:void(0)" onclick="logout()">로그아웃</a>
							</c:when>
						</c:choose>
					</c:otherwise>
				</c:choose>
	        </div>
        </div>
    </div>
    <script type="text/javascript">
    
	    function logout() {
			// confirm() 함수 활용하여 "로그아웃하시겠습니까?" 질문을 통해
			// 확인 버튼 클릭 시 "MemberLogout" 페이지로 이동 처리
			if(confirm("로그아웃하시겠습니까?")) {
				location.href = "MemberLogout";
			}
		}
	    
    </script>
</body>
</html>
