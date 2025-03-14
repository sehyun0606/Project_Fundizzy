<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fundizzy</title>
<link rel="stylesheet" type="text/css" href="resources/css/helpCenter/helpCenter_main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<article class="help-center">
	    <!-- 상단 배경 및 검색바 -->
	    <div class="hero">
	        <div class="hero-content">
	            <h2>일상과 새로운 가능성을 그려가는 곳,<br> 펀디지 도움말 센터입니다.</h2>
	            <form action="">
		            <div class="search-box">
					    <input type="text" placeholder="궁금한 내용을 입력해주세요">
					    <i class="fas fa-search search-icon"></i> 
					</div>
	            </form>
	        </div>
	    </div>
	
	    <!-- 자주 묻는 질문 -->
	    <section class="faq-section">
	        <h2 class="faq-title">자주 묻는 질문</h2>
	
	        <!-- ✅ 서포터 / 메이커 탭 -->
			<div class="faq-tabs">
			    <span class="tab-btn active" data-target="supporter">서포터</span>
			    <span class="tab-btn" data-target="maker">메이커</span>
			</div>
	
	        <!-- 카테고리 버튼 -->
	        <div class="faq-categories">
	            <button>회원정보</button>
	            <button>결제</button>
	            <button>상품/배송</button>
	            <button>서비스 이용</button>
	            <button>사이트 위치/기능 문의</button>
	        </div>
	
	        <!-- ✅ 서포터 FAQ 리스트 -->
			<div class="faq-list tab-content active" id="supporter">
			    <div class="faq-item">
			        <h3>📌 배송지 정보를 어떻게 바꿀 수 있나요?</h3>
			        <p>A. <span class="check-icon">✔</span> 로그인 후 '내 정보'에서 배송지 정보를 수정할 수 있습니다.</p>
			    </div>
			    <div class="faq-item">
			        <h3>📌 배송은 얼마나 걸리나요?</h3>
			        <p>A. <span class="check-icon">✔</span> 일반적으로 결제 후 3~5일 소요됩니다.</p>
			    </div>
			    <div class="faq-item">
			        <h3>📌 환불은 어떻게 진행되나요?</h3>
			        <p>A. <span class="check-icon">✔</span> 결제 후 7일 이내에 요청하시면 환불이 가능합니다.</p>
			    </div>
			    <div class="faq-item">
			        <h3>📌 제품 A/S 신청은 어디서 하나요?</h3>
			        <p>A. <span class="check-icon">✔</span> 고객센터를 통해 A/S 신청이 가능합니다.</p>
			    </div>
			    <div class="faq-item">
			        <h3>📌 회원 정보 변경은 어디서 하나요?</h3>
			        <p>A. <span class="check-icon">✔</span> 마이페이지에서 변경 가능합니다.</p>
			    </div>
			    <div class="faq-item">
			        <h3>📌 포인트는 어떻게 적립되나요?</h3>
			        <p>A. <span class="check-icon">✔</span> 결제 금액의 일정 비율이 적립됩니다.</p>
			    </div>
			</div>
			
			<!-- ✅ 메이커 FAQ 리스트 -->
			<div class="faq-list tab-content" id="maker">
			    <div class="faq-item">
			        <h3>📌 프로젝트 심사는 얼마나 걸리나요?</h3>
			        <p>A. 심사는 평균 5~7일 소요됩니다.</p>
			    </div>
			    <div class="faq-item">
			        <h3>📌 프로젝트 심사 기준이 무엇인가요?</h3>
			        <p>A. 펀딩의 목적과 리워드의 명확성을 기준으로 평가합니다.</p>
			    </div>
			    <div class="faq-item">
			        <h3>📌 프로젝트 개설 비용은 얼마인가요?</h3>
			        <p>A. 개설 비용은 무료이며, 펀딩 성공 시 일정 수수료가 부과됩니다.</p>
			    </div>
			    <div class="faq-item">
			        <h3>📌 정산은 언제 이루어지나요?</h3>
			        <p>A. 프로젝트 종료 후 약 14일 이내에 정산됩니다.</p>
			    </div>
			    <div class="faq-item">
			        <h3>📌 프로젝트 취소는 어떻게 하나요?</h3>
			        <p>A. 프로젝트 시작 전에는 자유롭게 취소할 수 있습니다.</p>
			    </div>
			    <div class="faq-item">
			        <h3>📌 리워드 배송 지연 시 어떻게 해야 하나요?</h3>
			        <p>A. 서포터들에게 공지 및 고객센터에 문의하세요.</p>
			    </div>
			</div>
	
	        <!-- 전체 보기 버튼 -->
	        <div class="view-more">
	            <button onclick="location.href='Notice'">전체 보기</button>
	        </div>
	    </section>
	
    	<!-- 공지사항 & 문의 등록 -->
	    <section class="bottom-section">
		    <!-- 공지사항 -->
		    <div class="notice-box">
		        <h3>공지사항</h3>
		        <ul>
		            <li>고객센터 설 명절 휴무 안내 <span>1개월 전</span></li>
		            <li>기상 악화로 인한 화배송 주문 건의 출고 지연 <span>3개월 전</span></li>
		            <li>와디즈 고객센터 전화 상담 서비스 종료 안내 <span>5개월 전</span></li>
		        </ul>
		        <a href="Notice">더 보기 ></a>
		    </div>
		
		    <!-- 고객센터 -->
		    <div class="customer-center">
		        <h3>고객센터</h3>
		        <p class="phone-number">📞 <b>1001-2233</b></p>
		        <p class="center-info">상담 가능시간: 평일 오전 9시 ~ 오후 6시 <br> (주말, 공휴일 제외)</p>
		    </div>
		
		    <!-- 문의 등록 -->
		    <div class="inquiry-box">
		        <h3>문의 등록하기</h3>
		        <ul>
		            <li><a href="#">와디즈 서비스 문의하기 ></a></li>
		            <li><a href="#">서포터 서비스 문의하기 ></a></li>
		            <li><a href="#">메이커 서비스 문의하기 ></a></li>
		        </ul>
		    </div>
		</section>
	</article>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
	
	<script>
	    $(document).ready(function () {
	        // ✅ 탭 버튼 클릭 시 FAQ 리스트 변경
	        $(".tab-btn").click(function () {
	            $(".tab-btn").removeClass("active"); // 기존 active 제거
	            $(this).addClass("active"); // 클릭된 탭에 active 추가
	            
	            let target = $(this).data("target"); // 클릭한 탭의 data-target 값 가져오기
	            $(".faq-list").removeClass("active"); // 기존 FAQ 리스트 숨기기
	            $("#" + target).addClass("active"); // 클릭된 탭에 해당하는 FAQ 리스트 보이기
	        });
	    });
	</script>
</body>
</html>