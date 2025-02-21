<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
						<li><a href="#">정산 정보</a>에 입력한 정보로 정산이 진행돼요.</li>
						<li>프로젝트 종료 후 2일 후에 정산 신청 알림을 보내드려요.</li>
						<li>선정산 단계에서는 최종 정산 금액의 일부가 먼저 지급돼요.</li>
						<li>리워드 발송과 환불 처리가 완료되면 최종 정산 금액이 확정돼요.</li>
						<li>정산금을 지급받은 후 법인세법, 소득세법, 부가가치세법 등 관계법령에 따라 세금 신고 및 납부해야 합니다.</li>
					</ul>
				</div>
			</div>
			
			<h3>정산 내역</h3>
			<table>
				<tr>
					<th width="40%">프로젝트명</th>
					<th width="10%">진행률</th>
					<th width="10%">정산 상태</th>
					<th width="10%">정산 신청</th>
					<th width="15%">내역서 받기</th>
				</tr>
				<tr>
					<td>[발받침대] 편안함을 선사하는 2단 쿠션 발받침대</td>
					<td>130%</td>
					<td>선정산</td>
					<td><input type="button" class="btnApplication" value="신청"></td>
					<td><input type="button" class="btnSettlement" value="선정산 내역서"></td>
				</tr>
			</table>
			<div class="settlement-detail">
				<h2>선정산 내역서</h2>
				<div>
					<h3>프로젝트명 (프로젝트 번호 123456)</h3>
					<span>[발받침대] 편안함을 선사하는 2단 쿠션 발받침대</span>
				</div>
				<div>
					<h3>선정산 지급액</h3>
					<span>600,000원</span><br>
					<span>해당 프로젝트의 선정산금이 지급됩니다.</span>
				</div>
				<div>
					<h3>최종 결제완료 금액</h3>
					<span>1,000,000원</span><br>
					<span>배송료 21,000원 포함</span>
				</div>
			</div>
			
		</div>
	
	
	
	</div>
</body>
</html>