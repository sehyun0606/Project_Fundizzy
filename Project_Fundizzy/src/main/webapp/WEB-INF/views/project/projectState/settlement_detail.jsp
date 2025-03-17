<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정산 관리</title>
<link rel="styleSheet" type="text/css" href="resources/css/projectState/project_state_default.css" >
<link rel="stylesheet" type="text/css" href="resources/css/projectState/settlement_detail.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp" />
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp" />
		<div class="content">
			<h1>정산 내역</h1>
			<div class="notice">
				<h3>정산 안내</h3>
				<div class="order-container">
					<div>
						<div>1</div>
						<span>성공 종료</span>
					</div>
					<div class="spot">
						<span>· · · · · · ·</span>
					</div>
					<div>
						<div>2</div>
						<span>결제</span>
					</div>
					<div class="spot">
						<div>결제 완료 후<br>선정산 시작</div>
						<span>· · · · · · ·</span>
					</div>
					<div>
						<div>3</div>
						<span>선정산</span>
					</div>
					<div class="spot">
						<span>· · · · · · ·</span>
					</div>
					<div>
						<div>4</div>
						<span>발송·환불</span>
					</div>
					<div class="spot">
						<div>발송·환불 완료 후<br>최종정산 시작</div>
						<span>· · · · · · ·</span>
					</div>
					<div>
						<div>5</div>
						<span>최종 정산</span>
					</div>
				</div>
				<div class="notice-detail">
					<ul>
						<li>정산금은 <a href="PayPage">펀디지 페이</a>에 point로 지급돼요.</li>
						<li>프로젝트가 종료되면 정산 신청 알림을 보내드려요.</li>
						<li>선정산 단계에서는 최종 정산 금액의 일부가 먼저 지급돼요.</li>
						<li><a href="ShipmentRefund">리워드 발송과 환불 처리</a>가 완료되면 최종 정산 금액이 확정돼요.</li>
						<li>정산금을 지급받은 후 법인세법, 소득세법, 부가가치세법 등 관계법령에 따라 세금 신고 및 납부해야 합니다.</li>
					</ul>
				</div>
			</div>
			
			<h3>정산 내역</h3>
			<c:choose>
				<c:when test="">
					아직 프로젝트가 완료되지 않았어요!<br>
					프로젝트가 종료된 후에 선정산이 가능해요.
				</c:when>
				<c:otherwise>
					<table class="sumTable">
						<tr>
							<th width="35%">프로젝트명</th>
							<th width="10%">진행률</th>
							<th width="15%">정산 상태</th>
							<th width="10%">상세정보</th>
							<th width="15%">내역서 받기</th>
						</tr>
						<tr>
							<td>${projectInfo.project_title}</td>
							<td>${progress}%</td>
							<td>
								<c:choose>
									<c:when test="${projectInfo.settlement_status eq 'SET01'}">
										진행중
									</c:when>
									<c:when test="${projectInfo.settlement_status eq 'SET02'}">
										선정산 가능
									</c:when>
									<c:when test="${projectInfo.settlement_status eq 'SET03'}">
										선정산 신청
									</c:when>
									<c:when test="${projectInfo.settlement_status eq 'SET04'}">
										선정산 완료
									</c:when>
									<c:when test="${projectInfo.settlement_status eq 'SET05'}">
										최종정산 가능
									</c:when>
									<c:when test="${projectInfo.settlement_status eq 'SET06'}">
										최종정산 신청
									</c:when>
									<c:when test="${projectInfo.settlement_status eq 'SET07'}">
										정산 완료
									</c:when>
								</c:choose>
							</td>
							<td><input type="button" class="btnDetail" value="확인"></td>
							<td>
								<c:if test="${projectInfo.settlement_status ne 'SET01' && projectInfo.settlement_status ne 'SET02' && projectInfo.settlement_status ne 'SET03'}">
									<form action="PreExcelDownload" method="get">
										<input type="hidden" name="project_code" value="${projectInfo.project_code}">
										<input type="submit" class="btnSettlement" id="preSettlement" value="선정산 내역서">
									</form>
								</c:if>
<%-- 								<c:when test="${projectInfo.settlement_status eq 'SET07'}"> --%>
								<c:if test="${projectInfo.settlement_status eq 'SET07'}">
									<form action="FinalExcelDownload" method="get">
										<input type="hidden" name="project_code" value="${projectInfo.project_code}">
										<input type="submit" class="btnSettlement" value="최종정산 내역서">
									</form>
								</c:if>
							</td>
						</tr>
					</table>
					<div class="modal">
						<div id="pre-modal" class="modal-content">
							<div class="modal-close">x</div>
							<div class="modal-main">
								<h3>상세정보</h3>
								<div class="table-container">
									<table class="detailTable">
										<tr>
											<th>프로젝트명</th>
											<td>${projectInfo.project_title}</td>
										</tr>
										<tr>
											<th>대표자명</th>
											<td>${projectInfo.representative_name}</td>
										</tr>
										<tr>
											<th>이메일</th>
											<td>${projectInfo.representative_email}</td>
										</tr>
									</table>
									<div class="msg">* 정산된 금액은 페이에 point로 입금됩니다</div>
									<div class="msg">* 총 결제금액이 100만원 이상일 경우 기본이용료가 부과됩니다</div>
								</div>
								<div class="set-container">
									<c:choose>
										<%-- 선정산 신청폼 --%>
										<c:when test="${projectInfo.settlement_status eq 'SET01' or projectInfo.settlement_status eq 'SET02' or projectInfo.settlement_status eq 'SET03'}">
											<form action="PreSettlement" method="post">
												<input type="hidden" name="project_code" value="${projectInfo.project_code}">
												<input type="hidden" name="member_email" value="${projectInfo.representative_email}">
		<%-- 										<c:when test="false"> --%>
												<div class="set-info" style="border-bottom:1px solid #ddd; padding-bottom:15px">
													<div class="title">선정산 지급액</div>
													<div class="amount"><fmt:formatNumber value="${prePaymentAmount}" pattern="#,###" />원</div>
													<input type="hidden" name=pre_amount value="${prePaymentAmount}">
												</div>
												<div class="set-info">
													<div class="title">총 결제금액</div>
													<div class="amount"><fmt:formatNumber value="${totalAmount}" pattern="#,###" />원</div>
													<input type="hidden" name=total_amount value="${totalAmount}">
												</div>
												<div class="set-info">
													<div class="title">수수료</div>
													<div class="amount"><fmt:formatNumber value="${settlementFee}" pattern="#,###" />원</div>
													<input type="hidden" name=fee value="${settlementFee}">
													<div class="msg"><c:choose>
																		 <c:when test="${projectInfo.service_type eq 'pro'}">펀디지 수수료(10%)</c:when>
																		 <c:when test="${projectInfo.service_type eq 'basic'}">펀디지 수수료(5%)</c:when>
																	 </c:choose>
														<c:if test="${totalAmount > 1000000}"> + 기본이용료 90,000원</c:if>
													</div>
												</div>
												<div class="btn-container">
													<c:if test="${projectInfo.settlement_status eq 'SET02'}">
														<input type="submit" value="선정산 신청" class="preBtn">
													</c:if>
													<input type="button" value="닫기" class="closeBtn">
												</div>
											</form>
										</c:when>
										<%-- 최종정산 신청폼 --%>
										<c:when test="${projectInfo.settlement_status eq 'SET04' or projectInfo.settlement_status eq 'SET05' or projectInfo.settlement_status eq 'SET06' or projectInfo.settlement_status eq 'SET07'}">
											<form action="FinalSettlement" method="post">
												<input type="hidden" name="project_code" value="${projectInfo.project_code}">
												<input type="hidden" name="member_email" value="${projectInfo.representative_email}">
												<div class="set-info" style="border-bottom:1px solid #ddd; padding-bottom:15px">
													<div class="title">최종정산 지급액</div>
													<div class="amount"><fmt:formatNumber value="${finalAmount}" pattern="#,###" />원</div>
													<input type="hidden" name=final_amount value="${finalAmount}">
												</div>
												<div class="set-info">
													<div class="title">총 결제금액</div>
													<div class="amount"><fmt:formatNumber value="${totalAmount}" pattern="#,###" />원</div>
												</div>
												<div class="set-info">
													<div class="title">환불 금액</div>
													<div class="amount"><fmt:formatNumber value="${refundAmount}" pattern="#,###" />원</div>
													<input type="hidden" name=refund_amount value="${refundAmount}">
												</div>
												<div class="btn-container">
													<c:if test="${projectInfo.settlement_status eq 'SET05'}">
														<input type="submit" value="최종정산 신청" class="finalBtn">
													</c:if>
													<input type="button" value="닫기" class="closeBtn">
												</div>
											</form>
										</c:when>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			
		</div>
	
	
	
	</div>
	<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	<script>
		$(function() {
			// 새소식 작성하기 버튼 클릭 시 모달창 생성 
			$(".btnDetail").click(function() {
				 $(".modal").fadeIn(200);
				 $(".modal-content").fadeIn(200);
			});
			
	      	// x 버튼 클릭 시 모달창 닫힘
			$(".modal-close, .closeBtn").click(function() {
				 $(".modal").fadeOut(200);
				 $(".modal-content").fadeOut(200, function() {
					location.reload();
				});
			});
	      	
			// 모달 닫기 (배경 클릭)
		    $(".modal").click(function(event) {
		        if (event.target === this) {
		            $(this).fadeOut();
		        }
		    });
			
		});   
	</script>
</body>
</html>