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
<meta name='viewport' content='width=device-width, initial-scale=1'>
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
				<div class="account">
					<div class="accountHeader">
						<div class="bankName">
							<img src="${pageContext.request.contextPath}/resources/images/bank/bankbook.png">  
							<c:choose>
								<c:when test="${empty bankAccount}">
									<input type="hidden" id="empty-account" value="${bankAccount.account_num_masked}">
								</c:when>
								<c:otherwise>
									<div>
										${bankAccount.account_alias}
										${bankAccount.account_num_masked}
										${bankAccount.bank_name}
										${bankAccount.account_holder_name}
									</div>
								</c:otherwise>
							</c:choose>	
						</div>
						<div class="delete">
							<button class="account_delete" onclick="BankAccountRemove()"><img alt="계좌 삭제하기" id="account_delete" src="${pageContext.request.contextPath}/resources/images/bank/trashcan.png">삭제</button>
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
					>button</button>
				</div>
			</div>
		</div>
	</article>
<%-- 	<img src="${pageContext.request.contextPath}/resources/images/bank/plus2.png"> --%>
	<div class="account_modal" id="account_modal">
	    <div class="account_content">
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
                        <form action="BankAccountRegist" method="POST">
                            <input type="hidden" name="account_alias" value="${account.account_alias}">
                            <input type="hidden" name="bank_name" value="${account.bank_name}">
                            <input type="hidden" name="account_num_masked" value="${account.account_num_masked}">
                            <input type="hidden" name="account_holder_name" value="${account.account_holder_name}">
                            <input type="hidden" name="fintech_use_num" value="${account.fintech_use_num}">
                            <input type="hidden" name="account_bank_code" value="${account.bank_code_std}">
                            <th>${account.account_alias}</th>
                            <th>${account.bank_name}</th>
                            <th>${account.account_num_masked}</th>
                            <th>${account.account_holder_name}</th>
                            <th>${account.fintech_use_num}</th>
                            <th><input type="submit" value="계좌 등록"></th>
                        </form>
	                    </tr>
	                </c:forEach>
	            </table>
	   		 </div>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
</body>
</html>