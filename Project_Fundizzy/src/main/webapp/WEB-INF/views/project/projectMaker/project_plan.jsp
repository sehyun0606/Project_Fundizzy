<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서비스 요금</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0px;
            display: flex;
        }
        .container {
            width: 60%;
            margin: auto;
        }
        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .pricing-card {
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .pro {
            background: #9b51e0;
            color: white;
        }
        .basic {
            background: white;
            border: 1px solid #ddd;
            color: black;
        }
        .pricing-info {
            display: flex;
            flex-direction: column;
        }
        .plan-title {
            font-size: 18px;
            font-weight: bold;
        }
        .price {
            font-size: 24px;
            font-weight: bold;
            margin: 5px 0;
        }
        .description {
            font-size: 16px;
            font-weight: bold;
        }
        .list-items {
            margin-top: 10px;
            padding-left: 15px;
        }
        .select-btn {
            background: #555;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
        .default-plan {
	        border: 1px solid #ddd; 
	        padding: 20px; 
	        width: 650px;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div style="width: 100%;">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
 	<div class="container">
        <div class="title">서비스 요금</div>
        
        <div class="pricing-card pro">
            <div class="pricing-info">
                <span class="plan-title">프로</span>
                <span class="price">$100</span>
                <span class="description">프로 요금에 관한 요약</span>
                <ul class="list-items">
                    <li>List item</li>
                    <li>List item</li>
                    <li>List item</li>
                    <li>List item</li>
                </ul>
            </div>
            <input class="service-type" type="hidden" value="pro">
            <c:choose>
            	<c:when test="${serviceType eq 'pro'}">
            		<button class="select-btn">선택됨</button>
            	</c:when>
            	<c:otherwise>
		            <button class="select-btn">선택하기</button>
            	</c:otherwise>
            </c:choose>
        </div>

        <div class="pricing-card basic">
            <div class="pricing-info">
                <span class="plan-title">기본</span>
                <span class="price">$50</span>
                <span class="description">기본 요금에 관한 요약</span>
                <ul class="list-items">
                    <li>List item</li>
                    <li>List item</li>
                    <li>List item</li>
                    <li>List item</li>
                </ul>
            </div>
            <input class="service-type" type="hidden" value="basic">
            <c:choose>
            	<c:when test="${serviceType eq 'basic'}">
            		<button class="select-btn">선택됨</button>
            	</c:when>
            	<c:otherwise>
		            <button class="select-btn">선택하기</button>
            	</c:otherwise>
            </c:choose>
        </div>
        <div class="default-plan" style="">
		    <h3 style="margin-bottom: 10px;">기본 서비스 이용료</h3>
		    <p style="color: #666; font-size: 14px;">
		        펀디지가 프로젝트 성공을 위해 기본으로 제공하는 서비스에 대한 이용료예요.<br>
		        결제 성공 금액 기준으로 100만 원 이상 달성한 성공 프로젝트인 경우, 서비스 이용료가 적용됩니다.
		    </p>
		    <p style="font-size: 18px; font-weight: bold; margin: 10px 0;">90,000원</p>
		</div>
    </div>	
	</div>
   <script type="text/javascript">
		$(function(){
			//버튼 클릭 시 ajax 활용해서 서비스 등록
			$(".select-btn").click(function(){
				let service_type = $(this).parent().children().filter(".service-type").val();
				let btn = $(this);
				
				$.ajax({
					type : "GET",
					url : "GetServiceType",
					data : {
						service_type
					}
				}).done(function(result){
					$(".select-btn").text("선택하기");
					btn.text('선택됨')
				}).fail(function(){
					console.log("실패..")
				})
				
			})
		})
   </script>
</body>
</html>
