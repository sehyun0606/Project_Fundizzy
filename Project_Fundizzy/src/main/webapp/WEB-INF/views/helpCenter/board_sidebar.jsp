<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<aside class="board-sidebar">
	    <h3 onclick="location.href='Supporter'">서포터</h3>
	    <ul>
	        <li><a href="SupporterSelect?category=회원정보">회원정보</a></li>
	        <li><a href="SupporterSelect?category=결제">결제</a></li>
	        <li><a href="SupporterSelect?category=상품/배송">상품/배송</a></li>
	        <li><a href="SupporterSelect?category=교환/AS">교환/AS</a></li>
	        <li class="more-menu">
	            <a href="Supporter">더보기</a>
	            <span class="more-arrow">›</span>
	        </li>
	    </ul>
	    <!-- ✅ 연한 회색 구분선 -->
	    <div class="divider"></div>
	
	    <h3 onclick="location.href='Maker'">메이커</h3>
	    <ul>
	        <li><a href="MakerSelect?category=개설(예비메이커)">개설(예비메이커)</a></li>
	        <li><a href="MakerSelect?category=심사">심사</a></li>
	        <li><a href="MakerSelect?category=광고">광고</a></li>
	        <li class="more-menu">
	            <a href="Maker">더보기</a>
	            <span class="more-arrow">›</span>
	        </li>
	    </ul>
	
	    <!-- ✅ 연한 회색 구분선 -->
	    <div class="divider"></div>
	
	    <h3 onclick="location.href='Notice'">공지사항</h3>
	    <ul>
	        <li><a href="Notice">공지사항</a></li>
	    </ul>
	
	    <!-- ✅ 연한 회색 구분선 -->
	    <div class="divider"></div>
	</aside>
</body>
</html>