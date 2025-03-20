<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>펀딩한 상품</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        
        .container {
            width: 60%;
            margin: 50px auto;
        }
        
        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        
        .product-box {
            border: 1px solid #c69df1;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            position: relative;
        }
        
        .category {
            font-size: 14px;
            color: gray;
        }
        
        .status {
            font-size: 14px;
            color: #8a2be2;
            font-weight: bold;
        }
        
        .product-name {
            font-size: 20px;
            font-weight: bold;
            margin: 5px 0;
        }
        
        .company {
            font-size: 14px;
            color: black;
        }
        
        .payment-info {
            font-size: 14px;
            color: black;
        }
        
        .refund, .refund_cancel {
            position: absolute;
            right: 20px;
            top: 20px;
            color: #8a2be2;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        
        .refund_complete {
        	position: absolute;
            right: 20px;
            top: 20px;
            color: #8a2be2;
            font-size: 14px;
            font-weight: bold;
        }
        
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        
        .pagination a {
            text-decoration: none;
            color: black;
            padding: 8px 12px;
            margin: 0 5px;
            border-radius: 5px;
        }
        
        .pagination a.active {
            background-color: black;
            color: white;
        }
        
        .pagination a:hover {
            background-color: #ddd;
        }
        
        .main{
        	display: flex;
        }
        
        .img-section{
        	width: 100px;
        }
        
        .info{
	        display: flex;
		    justify-content: space-between;
		    margin-bottom: 20px;
        }
        
        .payment-info {
        	margin-top: auto;
        }
        
        .modal {
            display: none; 
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 8px;
            width: 300px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .close-btn {
            cursor: pointer;
            padding: 5px 10px;
            background: #ff4d4d;
            color: white;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
        }
        .submit-btn {
            cursor: pointer;
            padding: 5px 10px;
            background: black;
            color: white;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
        }
        .button-section{
        	display: flex;
        	justify-content: space-between;
        	width: 290px;
        }
        form {
		    display: flex;
		    flex-direction: column;
		}
		
		label {
		    font-weight: bold;
		    margin-top: 10px;
		}
		
		
		/* input-group: 단위(원, 개)를 오른쪽에 표시 */
		.input-group {
		    display: flex;
		    align-items: center;
		}
		
		.input-group span {
		    margin-left: 10px;
		}
		.text-count{
			display: flex;
			color: #bbb;
		}
		#rewardDesc{
			height: 100px;
			resize: none;
		}
		/* 페이지네이션 버튼 그룹 */
		.page_btn_group {
		    position: relative;
		}
		
		/* 페이지네이션 버튼 컨테이너 */
		.page_btn {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 10px;
		    margin-top: 20px;
		    
		}
		
		/* 페이지네이션 숫자 & 링크 스타일 */
		.page_btn a, .page_btn b {
		    padding: 5px;
		    font-size: 16px;
		    text-decoration: none;
		    color: black;
		}
		
		/* 현재 페이지 강조 */
		.page_btn b {
		    font-weight: bold;
		    color: mediumpurple;
		}
		
		/* 페이지 버튼 스타일 */
		.page_btn input[type="button"] {
		    padding: 10px;
		    border: 1px solid #aaa;
		    background-color: #fff;
		    cursor: pointer;
		    border-radius: 3px;
		    width: fit-content;
		}
		
		/* 비활성화된 버튼 */
		.page_btn input[type="button"]:disabled {
		    background-color: #ddd;
		    cursor: not-allowed;
		    width: fit-content;
		}
		
/* 		.underContainer { */
/* 			display: flex; */
/* 			justify-content: flex-end; */
/* 		} */
		
		/* 배송완료, 배송조회 버튼 */
		.ship {
			display: flex;
			justify-content: flex-end;
			gap: 10px;
		}
		
		.shipCompleteBtn, .shipCheckBtn {
			margin: 0;
			width: unset;
			cursor: pointer;
			background-color: #eee;
		    border: 1px solid #ddd;
		    border-radius: 5px;
		    padding: 5px;
		}
		.funding-box {
		   	width: 90%;
		    background: #f8f9fa;
		    padding: 30px;
		    text-align: center;
		    align-items: center;
		    border-radius: 8px;
		    display: flex;
		    justify-content: center;
		    font-size: 14px;
		    height: 150px;
		    color: #666;
		}
		.page_btn_group {
		    text-align: center;
		    margin-top: 20px;
		}
		
		.page_btn a, 
		.page_btn span {
		    display: inline-block;
		    padding: 8px 12px;
		    margin: 0 4px;
		    border-radius: 5px;
		    text-decoration: none;
		    font-size: 14px;
		    color: #6a0dad;
		    border: 1px solid #6a0dad;
		    transition: 0.2s;
		}
		
		.page_btn a:hover {
		    background-color: #6a0dad;
		    color: white;
		}
		
		.page_btn .active {
		    background-color: #6a0dad;
		    color: white;
		    font-weight: bold;
		    cursor: default;
		}
		
		.page_btn .disabled {
		    color: #ccc;
		    border: 1px solid #ccc;
		    cursor: not-allowed;
		}
		.img{
			width: inherit;
		}
				
    </style>
   	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
<div class="main">
	<div >
		<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>

	</div>
	<div class="container">
	    <div class="title">펀딩한 상품</div>
		<c:if test="${empty fundList}">
    		<div class="funding-box">
	            구매한 상품이 없어요. <br>
	            지금 바로 펀디지에서 프로젝트에 참해 보세요.
        	</div>
		</c:if>	    
	    <c:forEach items="${fundList}" var="fund">
		    <div class="product-box">
		    	<input type="hidden" value="${fund.reward_code}" class="reward_code">
		    	<input type="hidden" value="${fund.fund_idx}" class="fund_idx">
		    	<input type="hidden" value="${fund.payment_code}" class="payment_code">
		        <div class="category">${fund.project_title}</div>
		        <div class="product-name">${fund.product_name}</div>
		        <div class="info">
		        	<div class="img-section">
		        		<img class="img" src="${fund.representative_picture }"/>
		        	</div>
		        	<div class="payment-info">
		        		<div><fmt:formatDate value="${fund.purchase_date}" pattern="yyyy-MM-dd" /></div>
				        <div class="company">${fund.business_name}</div>
				        <c:choose>
				        	<c:when test="${fund.send_stat eq 'SHI01'}">
						        <div>미발송</div>
				        	</c:when>
				        	<c:when test="${fund.send_stat eq 'SHI02'}">
						        <div>발송완료</div>
				        	</c:when>
				        	<c:when test="${fund.send_stat eq 'SHI03'}">
						        <div>배송중</div>
				        	</c:when>
				        	<c:when test="${fund.send_stat eq 'SHI04'}">
						        <div>배송완료</div>
				        	</c:when>
				        </c:choose>
				        <div>결제금액 <fmt:formatNumber value="${fund.result_point}" type="number" />POINT</div>
		        	</div>
		        </div>
		        <c:choose>
			        <c:when test="${fund.send_stat eq 'SHI04' && fund.refund_stat ne 'REF01' && fund.refund_stat ne 'REF02' && fund.refund_stat ne 'REF03'}">
			        	<div class="refund">환불신청</div>
			        </c:when>
			        <c:when test="${fund.refund_stat eq 'REF01'}">
			        	<div class="refund_cancel">환불 취소하기</div>
			        </c:when>
			        <c:when test="${fund.refund_stat eq 'REF02'}">
			        	<div class="refund_complete">환불 처리됨</div>
			        </c:when>
			        <c:when test="${fund.refund_stat eq 'REF03'}">
			        	<div class="refund_complete">환불 거절됨</div>
			        </c:when>
		        </c:choose>
				<div class="ship">
			        <c:if test="${fund.send_stat eq 'SHI03'}">
						<input type="button" value="배송완료" class="shipCompleteBtn">
			        </c:if>
			        <c:if test="${fund.send_stat eq 'SHI03' || fund.send_stat eq 'SHI04'}">
					        <input type="hidden" id="t_key" name="t_key" value="2n3pmCsoZ4CJC0Fqu54m1Q">
					        <input type="hidden" name="t_code" id="t_code">
					        <input type="hidden" name="t_invoice" id="t_invoice">
							<input type="button" value="배송조회" class="shipCheckBtn">
			        </c:if>
				</div>
		    </div>
		    
	    </c:forEach>
		<div class="page_btn_group">
			    <div class="page_btn">
			        <c:if test="${pageInfo.maxPage != 0}">
			            <!-- 이전 페이지 버튼 -->
			            <c:choose>
			                <c:when test="${pageInfo.pageNum eq 1}">
			                    <span class="disabled">이전</span>
			                </c:when>
			                <c:otherwise>
			                    <a href="FundHistory?pageNum=${pageInfo.pageNum - 1}">이전</a>
			                </c:otherwise>
			            </c:choose>
			
			            <!-- 페이지 숫자 버튼 -->
			            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			                <c:choose>
			                    <c:when test="${pageInfo.pageNum eq i}">
			                        <span class="active">${i}</span>
			                    </c:when>
			                    <c:otherwise>
			                        <a href="FundHistory?pageNum=${i}">${i}</a>
			                    </c:otherwise>
			                </c:choose>
			            </c:forEach>
			
			            <!-- 다음 페이지 버튼 -->
			            <c:choose>
			                <c:when test="${pageInfo.pageNum eq pageInfo.maxPage}">
			                    <span class="disabled">다음</span>
			                </c:when>
			                <c:otherwise>
			                    <a href="FundHistory?pageNum=${pageInfo.pageNum + 1}">다음</a>
			                </c:otherwise>
			            </c:choose>
			        </c:if>
			    </div>
			</div>	
	</div>
	
</div>
<div id="myModal" class="modal">
       <div class="modal-content">
           <form action="RefundReqeust" method="POST" enctype="multipart/form-data">
           	<input type="hidden" value="${sessionScope.sId}" name="member_email">
           	<input type="hidden" name="reward_code" id="reward_code">
           	<input type="hidden"  name="fund_idx" id="fund_idx">
           	<input type="hidden"  name="project_code" id="project_code">
           	<input type="hidden"  name="payment_code" id="payment_code">
           	<div class="title-section">
            	<h2 class="title">환불 신청</h2>
       		</div>
       		
               <label for="amount">환불 금액</label>
               <div class="input-group">
                   <input type="number" id="amount" value="환불 금액 들고오기" name="refund_amound" readonly="readonly" required="required">
                   <span>원</span>
               </div>
               <!-- 리워드 명 -->
               <label for="rewardName">리워드 명</label>
               <input type="text" id="rewardName"  maxlength="60" name="product_name" readonly="readonly" required="required">

               <!-- 리워드 설명 -->
               <label for="rewardDesc">환불 사유</label>
               <textarea id="rewardDesc" placeholder="환불 사유를 설명해 주세요" maxlength="500" name="refund_reason" required="required"></textarea>
               <small class="text-count">500자</small>

               <!-- 제한 수량 -->
               <label for="limit">증빙 사진</label>
               <div class="input-group">
                   <input type="file" id="limit" name="refundImg" required="required">
               </div>
			
		<div class="button-section">
            <button type="button" class="close-btn">닫기</button>
			<button type="submit" class="submit-btn">제출</button>			
		</div>
           </form>
       </div>
   </div>
   
<script type="text/javascript">
	$(document).ready(function () {
	    // 모달 열기
	    $(".refund").click(function () {
	        $("#myModal").fadeIn();
	        let fund_idx = $(this).parent().children().filter(".fund_idx").val();
			  $.ajax({
	  			url : "GetFundInfo",
				type : "GET",
				data : {
					fund_idx
				},
				dataType: "json",  
       			contentType: "application/json; charset=UTF-8"
			}).done(function(result){
				console.log("응답 받은 데이터: ", result);
				
				$("#fund_idx").val(result.fund_idx);
				$("#amount").val(result.result_point);
				$("#rewardName").val(result.product_name);
				$("#fund_idx").val(result.fund_idx);
				$("#reward_code").val(result.reward_code);
				$("#project_code").val(result.project_code);
				$("#payment_code").val(result.payment_code);
			}).fail(function(){
				console.log("실패..")
			})
	    });
	
	    // 모달 닫기 (버튼 클릭)
	    $(".close-btn").click(function () {
	        $("#myModal").fadeOut();
	    });
	
	    // 모달 닫기 (바깥 영역 클릭)
	    $(window).click(function (event) {
	        if ($(event.target).is("#myModal")) {
	            $("#myModal").fadeOut();
	        }
	    });
	    
	    $(document).on("click", ".shipCompleteBtn", function() {
			let payment_code = $(this).parent().parents().children().filter(".payment_code").val();
			let fund_idx = $(this).parent().parents().children().filter(".fund_idx").val();
	    	
			if(!confirm("정말 배송이 완료되었나요?\n확정 후엔 변경하실 수 없습니다")) {
				return false;
			} else {
				$.ajax({
					type : "POST",
					url : "ShipComplete",
					data : {
						payment_code,
						fund_idx
					}
				}).done(function(response) {
					alert(response.msg);
					location.href = response.targetURL;
				});
			}
		});
	    
	    // 배송조회창 열림
	    $(".shipCheckBtn").click(function() {
	    	let payment_code = $(this).closest(".product-box").children().filter(".payment_code").val();
	    	let courier; 		// 택배사
	    	let tracking_num;	// 운송장 번호
	    	
	    	$.ajax({
	    		type : "GET",
	    		url : "ShipmentInvoiceInfo",
	    		data : {
	    			payment_code
	    		}
	    	}).done(function(shipList) {
				for(let ship of shipList) {
					if(ship.courier == "우체국택배") {
						courier = $("#t_code").val(01);
					} else if(ship.courier == "cj대한통운") {
						$("#t_code").val(04);
						courier = courier = "04";
					} else if(ship.courier == "한진택배") {
						$("#t_code").val(05);
						courier = courier = "05";
					} else if(ship.courier == "로젠택배") {
						$("#t_code").val(06);
						courier = courier = "06";
					} else if(ship.courier == "롯데택배") {
						$("#t_code").val(08);
						courier = courier = "08";
					}
					tracking_num = ship.tracking_num;
					$("#t_invoice").val(tracking_num);
				}
				
				// 배송조회 새창으로 열기
				window.open("https://info.sweettracker.co.kr/tracking/4?t_key=2n3pmCsoZ4CJC0Fqu54m1Q&t_code="
						+ courier + "&t_invoice=" + tracking_num, "_blank", "width=500,height=700,top=100,left=200");
			});
	    	
				
		});
	    
	    $(".refund_cancel").on("click", function() {
	    	let fund_idx = $(this).parent().children().filter(".fund_idx").val();

	    	if(confirm("환불 신청을 취소하시겠습니까?")) {
				$.ajax({
					type : "GET",
					url : "CancelRefund",
					data : {
						fund_idx
					}
				}).done(function() {
					alert("환불이 취소되었습니다");
					location.reload();
				});
			}
		});
	    

	    
	});
</script>
</body>
</html>
