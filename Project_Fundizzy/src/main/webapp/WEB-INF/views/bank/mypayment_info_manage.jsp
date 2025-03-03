<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 정보 관리</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bank/mypayment_info_manage.css" />
<!-- 아이콘 -->
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<!-- js연결 -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bank/mypayment_info_manage.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"/>
	</header>
	<article>
		<div id="title">
			결제 정보 관리
		</div>
		<div id="accountInfoDiv">
			<div class="subTitle">등록된 계좌정보</div>
			<div id="registAccountList">
<!-- 				<div id ="representAccount"> -->
<!-- 					<div class="accountHeader"> -->
<!-- 						<div class="bankName"> -->
<%-- 							<img src="${pageContext.request.contextPath}/resources/images/bank/bankbook.png">   --%>
<!-- 							산업은행(대표계좌) -->
<!-- 						</div> -->
<!-- 						<div class="delete"> -->
<%-- 							<img alt="계좌 삭제하기" src="${pageContext.request.contextPath}/resources/images/bank/trashcan.png">삭제 --%>
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="accountInfo"> -->
<!-- 						3333-3333-333 -->
<!-- 					</div> -->
<!-- 					<div class="accountBottom"> -->
<!-- 						<div class="registDate"> -->
<!-- 							계좌등록일 : 2025. 02. 01 -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<div class="account">
					<div class="accountHeader">
						<div class="bankName">
							<img src="${pageContext.request.contextPath}/resources/images/bank/bankbook.png">  
							<c:choose>
								<c:when test="${empty bankUserInfo}">
									등록된 계좌가 없습니다.
								</c:when>
								<c:otherwise>
									<div>
										계좌정보 표시하기
										<c:forEach var="account" items="${bankUserInfo.res_list}">
											${account.account_alias}
											${account.account_num_masked}
											${account.bank_name}
											${account.account_holder_name }
										</c:forEach>
									</div>
								</c:otherwise>
							</c:choose>	
								<div class="registRepresentBtn">
									<input type="button" value="대표계좌로 등록">
								</div>
						</div>
						<div class="delete">
							<img alt="계좌 삭제하기" src="${pageContext.request.contextPath}/resources/images/bank/trashcan.png">삭제
						</div>
					</div>
				</div>
				
				<div id="addAccount">
					<button 
						<c:choose>
							<c:when test="${empty sessionScope.token}">
								id="auth-button"
							</c:when>
							<c:otherwise>
								id="add_button"
							</c:otherwise>
						</c:choose>
					>+ button<i class='fas fa-plus'></i></button>
<%-- 					<img alt="계좌등록/추가" src="${pageContext.request.contextPath}/resources/images/bank/plus.png"> --%>
				</div>
			</div>
		</div>
		<div id="cardInfoDiv">
			<div class="subTitle">간편결제카드</div>
			<div id="addCard">
				<img alt="간편카드등록" src="${pageContext.request.contextPath}/resources/images/bank/plus.png">
			</div>
		</div>
	</article>
	
	<div class="account_modal" id="account_modal">
		<form action="BankAccountRegist" method="POST" class="account_content">
			<div class="top">
			    <b class="subject">${sessionScope.sId} 님의 계좌 목록</b>
			    <button type="button" class="x">x</button>
			</div>
			<div class="account_list_table">
				<table>
					<tr>
						<th>계좌명</th>
						<th>은행명</th>
						<th>계좌번호</th>
						<th>예금주명</th>
						<th>핀테크 이용번호</th>
						<th>등록</th>
					</tr>
					<c:forEach var="account" items="${bankUserInfo.res_list}">
						<tr>
							<th>${account.account_alias}</th>
							<th>${account.bank_name}</th>
							<th>${account.account_num_masked}</th>
							<th>${account.account_holder_name}</th>
							<th>${account.fintech_use_num}</th>
							<th><input type="submit" value="계좌 등록"></th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</form>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>