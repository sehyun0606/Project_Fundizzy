<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="styleSheet" type="text/css" href="resources/css/projectState/projectStateDefault.css" >
<link rel="stylesheet" type="text/css" href="resources/css/projectState/settlement_detail.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp" />
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp" />
		<div class="content">
			<h1>정산 내역</h1>
			<table>
				<tr>
					<th width="400px">프로젝트명</th>
					<th width="50px">진행률</th>
					<th width="50px">정산 상태</th>
					<th width="50px">정산 신청</th>
					<th width="50px">내역서 받기</th>
				</tr>
				<tr>
					<td>[발받침대] 편안함을 선사하는 2단 쿠션 발받침대</td>
					<td>130%</td>
					<td>선정산</td>
					<td><input type="button" value="신청"></td>
					<td><input type="button" value="선정산 내역서"></td>
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