<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>푸터</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .footer {
            background-color: #f8f8f8;
            padding: 20px;
            font-size: 14px;
            color: #666;
            border-top: 1px solid #ddd;
        }
        .footer .footer-links, .footer .company-info {
            display: flex;
            justify-content: space-between;
            max-width: 1200px;
            margin: auto;
            margin-bottom: 1%;
        }
        .footer a {
            text-decoration: none;
            color: #666;
        }
        .footer a:hover {
            color: black;
        }
        
        #floatingChat {
		    position: fixed;
		    bottom: 40px;
		    right: 40px;
		    width: 80px;
		    height: 80px;
		    background-color:  #C9A7FF;
		    border-radius: 50%;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		    cursor: pointer;
		    z-index: 1000;
		}
		
		#floatingChat img {
		    width: 60%;
		    height: 60%;
		}
    </style>
</head>
<body>
    <div class="footer">
        <div class="footer-links">
            <div>
                <strong>정책ㆍ약관</strong> | <a href="#">개인정보처리방침</a>
            </div>
            <div>
                <a href="#">제휴문의</a> | <a href="#">공지사항</a> | <a href="#">와디즈 IR</a> |  <a href="#">SNS</a> | <a href="#">Language</a>
            </div>
        </div>
        <div class="company-info">
            <div>
                <strong>와디즈 고객센터</strong><br>
                 <a href="#">채팅 상담하기</a> | <a href="#">문의 등록하기</a> | <a href="#">도움말 센터 바로가기</a> 
            </div>
            <div>
                <strong>상담 가능 시간</strong><br>
                평일 오전 9시 ~ 오후 6시 (주말, 공휴일 제외)
            </div>
        </div>
        <div class="company-info">
            <div>
                펀디지(주) 대표이사 정세현 | 사업자등록번호 111-11-1111111 | <a href="#">사업자 정보 확인</a> | 통신판매업신고번호 2021-부산서면C-1111
            </div>
            <div>
                Android앱 | iOS앱
            </div>
        </div>
    </div>
    <input type="hidden" id="sId" value="${sessionScope.sId}">
    <c:if test="${not empty sessionScope.sId}">
	    <div id="floatingChat">
	    	<img src="/resources/images/chat/chattingIcon.png" alt="채팅오픈" onclick="openChatWindow()">
		</div>
    </c:if>
	<script src="/resources/js/jquery-3.7.1.js"></script>
	<script src="/resources/js/footer.js"></script>
	
</body>
</html>