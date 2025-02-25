<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가입 축하 페이지</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <style type="text/css">
		
		.container {
		    text-align: center;
		    margin-top: 250px;
		    margin-bottom: 270px;
		   
		}
		
		h1 {
		    font-size: 24px;
		    color: black;
		    margin-bottom: 40px;
		}
		
		.home-button {
		    background-color: #f9a7d5; /* 핑크 버튼 색상 */
		    color: white;
		    border: none;
		    border-radius: 25px;
		    padding: 10px 50px;
		    font-size: 16px;
		    cursor: pointer;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		}
		
		.home-button:hover {
		    background-color: #e589c1; /* 호버 시 더 진한 핑크 */
		}
		
		.home-button:active {
		    background-color: #d478b0;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
		}

    	
    </style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
    <div class="container">
        <h1>${nickName} 서포터님 가입을 축하드립니다!</h1>
        <button class="home-button" onclick="window.location.href='./'">홈 화면으로 바로가기</button>
    </div>
    <footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>
