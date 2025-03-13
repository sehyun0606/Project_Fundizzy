<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발송·환불 관리</title>
<link rel="styleSheet" type="text/css" href="resources/css/projectState/project_state_default.css" >
<link rel="styleSheet" type="text/css" href="resources/css/projectState/shipment_refund.css" >
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="resources/js/projectState/shipment_refund.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp" />
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp" />
		<div class="content">
			<h1>발송·환불 관리</h1>
			<h3>서포터 관리</h3>
		    <div class="status-container">
		        <div class="section">
		            <div class="title">발송·배송 상태</div>
		            <div class="status">
		                <div>
		                	<span>미발송</span>
		                	<c:set var="found" value="false" />
		                	<c:forEach var="ship" items="${shipStateCount}">
			                    <c:if test="${ship.common_code eq 'SHI01'}">
		                    		<span class="count">${ship.count}<span>건</span></span>
				                	<c:set var="found" value="true" />
		                    	</c:if>
		                    </c:forEach>
		                    <!-- status가 존재하지 않을 시 0건 -->
		                    <c:if test="${!found}">
	                    		<span class="count">0<span>건</span></span>
		                    </c:if>
		                </div>
		                <div>
       						<span>발송완료</span>
					        <c:set var="found" value="false" />
					        <c:forEach var="ship" items="${shipStateCount}">
					            <c:if test="${ship.common_code eq 'SHI02'}">
					                <span class="count">${ship.count}<span>건</span></span>
					                <c:set var="found" value="true" />
					            </c:if>
					        </c:forEach>
		                    <!-- status가 존재하지 않을 시 0건 -->
					        <c:if test="${!found}">
					            <span class="count">0<span>건</span></span>
					        </c:if>
					    </div>
		                <div>
		                 	<span>배송중</span>
					        <c:set var="found" value="false" />
					        <c:forEach var="ship" items="${shipStateCount}">
					            <c:if test="${ship.common_code eq 'SHI03'}">
					                <span class="count">${ship.count}<span>건</span></span>
					                <c:set var="found" value="true" />
					            </c:if>
					        </c:forEach>
		                    <!-- status가 존재하지 않을 시 0건 -->
					        <c:if test="${!found}">
					            <span class="count">0<span>건</span></span>
					        </c:if>
		                </div>
		                <div>
		                 	<span>배송완료</span>
					        <c:set var="found" value="false" />
					        <c:forEach var="ship" items="${shipStateCount}">
					            <c:if test="${ship.common_code eq 'SHI04'}">
					                <span class="count">${ship.count}<span>건</span></span>
					                <c:set var="found" value="true" />
					            </c:if>
					        </c:forEach>
		                    <!-- status가 존재하지 않을 시 0건 -->
					        <c:if test="${!found}">
					            <span class="count">0<span>건</span></span>
					        </c:if>
					    </div>
		            </div>
		        </div>
		        <div class="section">
		            <div class="title">환불 상태</div>
		            <div class="status">
		                <div>
		                    <span>신청</span>
		                    <c:set var="found" value="false" />
		                    <c:forEach var="refund" items="${refundStateCount}">
			                    <c:if test="${refund.refund_stat eq 'REF01'}">
		                    		<span class="count">${refund.count}<span>건</span></span>
				                    <c:set var="found" value="true" />
		                    	</c:if>
		                    </c:forEach>
		                    <!-- status가 존재하지 않을 시 0건 -->
					        <c:if test="${!found}">
					            <span class="count">0<span>건</span></span>
					        </c:if>
		                </div>
		                <div>
		                    <span>승인</span>
		                    <c:set var="found" value="false" />
		                    <c:forEach var="refund" items="${refundStateCount}">
			                    <c:if test="${refund.refund_stat eq 'REF02'}">
		                    		<span class="count">${refund.count}<span>건</span></span>
				                    <c:set var="found" value="true" />
		                    	</c:if>
		                    </c:forEach>
		                    <!-- status가 존재하지 않을 시 0건 -->
					        <c:if test="${!found}">
					            <span class="count">0<span>건</span></span>
					        </c:if>
		                </div>
		                <div>
		                    <c:set var="found" value="false" />
		                    <span>거절</span>
		                    <c:forEach var="refund" items="${refundStateCount}">
			                    <c:if test="${refund.refund_stat eq 'REF03'}">
		                    		<span class="count">${refund.count}<span>건</span></span>
				                    <c:set var="found" value="true" />
		                    	</c:if>
		                    </c:forEach>
		                    <!-- status가 존재하지 않을 시 0건 -->
					        <c:if test="${!found}">
					            <span class="count">0<span>건</span></span>
					        </c:if>
		                </div>
		            </div>
		        </div>
		    </div>
	        <div class="note">
	            리워드 발송을 완료하면 발송 정보 입력을 통해 발송 처리를 진행해 주세요.<br>
	            상태 건수는 발송 받는 기준으로 계산돼요.
	        </div>

		    <div class="refund-amt">
	        	<div class="title">환불 가능 금액</div>
	        </div>
			
			<div class="order-summary">
				<span>목록</span>
				<span>총 <span>${orderCount}</span>건</span>
			</div>
			<div class="table-container">
				<table class="list">
					 <thead>
			            <tr>
			                <th width="103px">목록</th>
			                <th width="171px">서포터 정보</th>
			                <th width="120px">결제일</th>
			                <th width="120px">결제 금액</th>
			                <th width="120px">발송 정보</th>
			                <th width="120px">발송 예정일</th>
			                <th width="120px">발송 상태</th>
			                <th width="86px">발송 번호</th>
			                <th width="86px">환불</th>
			                <th width="50px"></th>
			            </tr>
		            </thead>
		            <tbody>
			            <c:forEach var="order" items="${orderList}" varStatus="status">
				            <tr>
				                <td width="103px">${status.index + 1}<input type="hidden" class="payment_code" value="${order.payment_code}"></td>
				                <td width="171px">
				                    ${order.name}<br>
				                    ${order.supporter_email}<br>
				                    ${order.phone_num}
				                </td>
				                <td width="120px"><fmt:formatDate value="${order.payment_complete_date}" pattern="yyyy-MM-dd"/> </td>
				                <td width="120px">${order.payment_amount}원</td>
				                <td width="120px">
				                	<c:choose>
				                		<c:when test="${empty order.tracking_num}">
							                <input type="button" value="입력" class="shipInfoBtn">
				                		</c:when>
				                		<c:when test="${not empty order.tracking_num}">
							                <input type="button" value="삭제" class="shipDelBtn">
				                		</c:when>
				                	</c:choose>
		                		</td>
				                <td width="120px">2025-01-01</td>
				                <td width="120px">
					                <c:choose>
						            	<c:when test="${order.shipment_common_code eq 'SHI01'}">
						            		미발송
						            	</c:when>
						            	<c:when test="${order.shipment_common_code eq 'SHI02'}">
						            		발송 완료
						            	</c:when>
						            	<c:when test="${order.shipment_common_code eq 'SHI03'}">
						            		배송 중
						            	</c:when>
						            	<c:when test="${order.shipment_common_code eq 'SHI04'}">
						            		배송 완료
						            	</c:when>
						            </c:choose>
			           			</td>
				                <td width="86px"><c:if test="${not empty order.tracking_num}">${order.tracking_num}</c:if></td>
		                		<td width="86px" 
			                		<c:if test="${order.refund_status eq '완료'}">
			                		style="color:blue;"</c:if>>
		                		${order.refund_status}</td>
				                <td width="50px" class="toggleBtn">
				                	<button><img src="/resources/images/projectState/arrow_right.png" style="width: 10px; height: 10px;"></button>
			                	</td>
				            </tr>
				            <tr class="details">
				                <td colspan="10">
				                    <table>
				                        <tr>
				                            <th width="92px"></th>
				                            <th width="382px">리워드명</th>
				                            <th width="153px">리워드 금액</th>
				                            <th width="138px">수량</th>
				                            <th width="169px">펀딩금 반환</th>
				                            <th width="117px"></th>
				                            <th width="45px"></th>
				                        </tr>
		            					<c:forEach begin="1" end="${order.fund_count}" varStatus="status2">
					                        <tr>
					                            <td>${status.index + 1}-${status2.index}</td>
					                            <td class="product_name"></td>
					                            <td class="result_point"></td>
					                            <td class="product_count"></td>
					                            <td class="refund_status"></td>
					                            <td class="statusBtn"><input type="hidden" class="refund_code"></td>
					                            <td></td>
					                        </tr>
		          				  		</c:forEach>
				                    </table>
				                </td>
				            </tr>
			            </c:forEach>
		            </tbody>
			    </table>
		    </div>
		    <!-- 발송 정보 입력 모달창 -->
			<div id="ship-modal" class="modal-content">
				<div class="modal-close">x</div>
				<div class="modal-main">
					<h3>발송 정보</h3>
					<form action="ShipmentInfo" method="post">
						<div class="receiver-container">
							<div class="receiver-info">
								<span>결제번호</span>
								<span></span>
								<input type="hidden" name="payment_code" class="payment_code">
							</div>
							<div class="receiver-info">
								<span>총금액</span>
								<span></span>
							</div>
							<div class="receiver-info">
								<span>수취인</span>
								<span></span>
							</div>
							<div class="receiver-info">
								<span>연락처</span>
								<span></span>
							</div>
							<div class="receiver-info">
								<span>우편번호</span>
								<span></span>
							</div>
							<div class="receiver-info">
								<span>주소</span>
								<span></span>
							</div>
						</div>
						<div class="ship-container">
							<h4>발송방법</h4>
							<div>택배</div>
							<h4>택배사</h4>
							<select name="courier" class="courier">
								<option selected>선택해주세요</option>
								<option value="01">우체국택배</option>
								<option value="04">cj대한통운</option>
								<option value="05">한진택배</option>
								<option value="06">로젠택배</option>
								<option value="08">롯데택배</option>
							</select>
							<div class="ship-info">
								<h4>송장번호</h4>
								<input type="number" class="tracking-num" name="tracking_num" placeholder="운송장 번호 - 없이 입력">
							</div>
						</div>
						<div class="btn-container">
							<input type="submit" value="완료" class="finBtn">
	   						<input type="button" value="닫기" class="closeBtn">
						</div>
					</form>
				</div>
			</div>
			<!-- 환불정보 확인/거절 모달창 -->
			<div id="refund-modal" class="modal-content">
				<div class="modal-back"><img src="/resources/images/projectState/backBtn.png"></div>
				<div class="modal-close">x</div>
				<div class="modal-main">
					<h3>환불 요청 정보</h3>
					<form action="RefundInfo" method="post">
						<input type="hidden" name="refund_code" id="refund_code">
						<div class="receiver-container">
							<div class="receiver-info">
								<span>결제번호</span>
								<span></span>
							</div>
							<div class="receiver-info">
								<span>서포터명</span>
								<span></span>
								<input type="hidden" name="email" class="email">
							</div>
						</div>
<!-- 						<div class="reward-container"> -->
<!-- 							<div class="reward-title"></div> -->
<!-- 							<div class="reward-info"></div> -->
<!-- 						</div> -->
						
						<div class="refund-reason">
							<h4>펀딩금 반환 신청 사유</h4>
							<div></div>
						</div>
						<div class="reject-reason">
<!-- 							<h4>반환 거절 사유</h4> -->
<!-- 							<textarea rows="7" cols="15" ></textarea> -->
<!-- 							<div>600자</div> -->
						</div>
						<div class="refund-amount">
							<h4>반환 금액</h4>
							<div class="refund-info">
								<span>반환금 신청 금액</span>
								<span></span>
								<input type="hidden" name="refund_amount" class="refund_amount">
							</div>
						</div>
						<div class="btn-container">
							<input type="submit" value="환불 승인" class="approveBtn">
	   						<input type="button" value="거절" class="rejectBtn">
	   						<input type="button" value="닫기" class="closeBtn">
						</div>
					</form>
				</div>
			</div>
	    </div>
	</div>
			
	<script>
		$(function() {
			
			// json 객체로 저장된 오더리스트 변수에 저장
			var jsonOrderList = ${jsonOrderList};

			// 아코디언 형식으로 주문 상세내역 표시
	    	$(".toggleBtn button").click(function() {
				let img = $(this).find("img");
	    		let detail =  $(this).closest("tr").next(".details");

	    		let productName = detail.find(".product_name"); // details 행 내부의 .product_name 선택
		        detail.toggle(); // 다음 .details 행들을 토글
		        
		        // 맨 오른쪽 토글 버튼 아이콘 변경
		        if(detail.css("display") != "none") {
		        	detail.css("display", "table-row");
		        	img.attr("src", "/resources/images/projectState/arrow_down.png");

		        } else {
		        	img.attr("src", "/resources/images/projectState/arrow_right.png");
		        }
		        
		        // 클릭한 테이블 목록의 결제 코드 받아오기
				let payment_code = $(this).closest("tr").find(".payment_code").val();
		        
		        $.ajax({
					type : "GET",
					url : "PaymentRewardDetail",
					data : {
						payment_code
					}
				}).done(function(rewardList) {
					 let rows = detail.find("tr:gt(0)"); // 첫 번째 tr(제목 행) 이후의 모든 tr 선택
					 console.log(rewardList);
					 
				     rows.each(function(index) {
				        if (index < rewardList.length) {
				            $(this).find(".refund_code").val(rewardList[index].refund_code);
				            $(this).find(".product_name").text(rewardList[index].product_name);
				            $(this).find(".result_point").text(rewardList[index].result_point + "원");
				            $(this).find(".product_count").text(rewardList[index].product_count + "개");
				            
				            let refundStatus;
				            switch (rewardList[index].refund_stat) {
							case "REF01" : 
								refundStatus = "신청";
								$(this).find(".statusBtn button").remove();
				            	$(this).find(".statusBtn").prepend("<button class='refundInfoBtn'>확인하기</button>");
								break;
							case "REF02" : 
								refundStatus = "승인";
								break;
							case "REF03" : 
								refundStatus = "거절";
								break;
							default: refundStatus = "";
							}
				            
			            	$(this).find(".refund_status").text(refundStatus);
				        }
				     });
				     
				}).fail(function() {
					console.log("실패");
					
				}); 

	    	});
			
	    	// (발송정보) 입력 버튼 클릭 시 모달창 생성 
			$(document).on("click", ".shipInfoBtn", function() {
				$("#ship-modal").fadeOut(0, function() {
					$("#ship-modal").fadeIn();
				});
				$("#refund-modal").css("display", "none");
				
				let payment_code = $(this).closest("tr").find(".payment_code").val();
				
				// 발송정보 입력 모달창에 정보 출력
				for(let order of jsonOrderList) {
					if(order.payment_code == payment_code) {
						let address = order.address + " " + order.address1;
// 						console.log(order);
						$("#ship-modal .receiver-info:nth-child(1) span:nth-child(2)").text(order.payment_code);
						$("#ship-modal .receiver-info:nth-child(2) span:nth-child(2)").text(order.payment_amount);
						$("#ship-modal .receiver-info:nth-child(3) span:nth-child(2)").text(order.name);
						$("#ship-modal .receiver-info:nth-child(4) span:nth-child(2)").text(order.phone_num);
						$("#ship-modal .receiver-info:nth-child(5) span:nth-child(2)").text(order.post_code);
						$("#ship-modal .receiver-info:nth-child(6) span:nth-child(2)").text(address);

						$("#ship-modal .payment_code").val(payment_code);
					}
				}
				
				$.ajax({
					type : "GET",
					url : "PaymentRewardDetail",
					data : {
						payment_code
					}
				}).done(function(rewardList) {
					// 발송정보 입력 폼에 주문 리워드 정보 출력
					$("#ship-modal .reward-container").empty()
					for(let reward of rewardList) {
						console.log(reward);
						$("#ship-modal form").prepend(
							"<div class='reward-container'>"
							+ "<div class='reward-title'>" + reward.product_name + "</div>"
							+ "<div class='reward-info'>" + reward.result_point + "원 / " + reward.product_count + "개</div>"
							+ "</div>"		
						)
					}
				}).fail(function() {
					console.lof("실패");
				});
				
				
			}); 

	    	// (환불) 확인하기 버튼 클릭 시 모달창 생성
			$(document).on("click", ".refundInfoBtn", function() {
				
				$("#refund-modal").fadeOut(0, function() {
					$("#refund-modal").fadeIn();
				});
				$("#ship-modal").css("display", "none");
				
				 initModal();
				
				// 결제코드 저장
				let payment_code = $(this).closest("tr.details").prev("tr").find(".payment_code").val();
				// 환불코드 저장
				let refund_code = $(this).siblings(".refund_code").val();
				$("#refund_code").val(refund_code);
				console.log(refund_code);
				let detail =  $(this).closest("tr.details");
				
				$.ajax({
					type : "GET",
					url : "PaymentRewardDetail",
					data : {
						payment_code
					}
				}).done(function(rewardList) {
					// 환불 요청 폼에 주문 리워드 정보 출력
					$("#refund-modal .reward-container").empty();

					let rows = detail.find("tr:gt(0)"); // 첫 번째 tr(제목 행) 이후의 모든 tr 선택
					 
				    rows.each(function(index) {
				        if (index < rewardList.length) {
				        	// 주문한 리워드 정보 출력
							if(rewardList[index].refund_code == refund_code) {
								$("#refund-modal .receiver-container").after(
									"<div class='reward-container'>"
									+ "<div class='reward-title'>" + rewardList[index].product_name + "</div>"
									+ "<div class='reward-info'>" + rewardList[index].result_point + "원 / " + rewardList[index].product_count + "개</div>"
									+ "</div>"		
								);
								$("#refund-modal .refund-info span:nth-child(2)").text(rewardList[index].result_point + "원");
								$("#refund-modal .refund-reason div").text(rewardList[index].refund_reason);
								$("#refund-modal .receiver-info:nth-child(1) span:nth-child(2)").text(rewardList[index].payment_code);
								$("#refund-modal .receiver-info:nth-child(2) span:nth-child(2)").text(rewardList[index].nickname);
								
								$("#refund-modal .refund_amount").val(rewardList[index].result_point);
								$("#refund-modal .email").val(rewardList[index].member_email);
								
							}
				        }
				     });
					
				}).fail(function() {
					console.log("실패");
				});
			});
		
	        // x 버튼 클릭 시 모달창 닫힘
			$(document).on("click", ".modal-close, .closeBtn", function() {
				$(".modal-content").css("display", "none");
				$(".reject-reason").empty();
				
				initModal();
			});
	        
			function initModal() {
				$(".reject-reason").empty();
							
				$("#refund-modal .btn-container").html(
					`<input type="submit" value="환불 승인" class="approveBtn">
					 <input type="button" value="거절" class="rejectBtn">
					 <input type="button" value="닫기" class="closeBtn">`
				);
				
				$(".reject-reason").css({
					"border-top": "none",
					"padding-bottom": "0"
				});
				
				$(".modal-back img").css("display", "none");
			}
	        
			
		});
		
		
	</script>
	
	
</body>
</html>






















