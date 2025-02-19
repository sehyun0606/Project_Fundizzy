<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>펀딩한 상품</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/myPage/supporter/funding_prod.css">
</head>

<body>

<header>
    <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
</header>


<article>


	
    <div class="container">
        <h1 class="title">펀딩한 상품</h1>

        <div class="funding-list">
            <!-- 펀딩 상품 카드 -->
            <div class="funding-card">
                <div class="funding-info">
                    <p class="category">펀딩유형/카테고리</p>
                    <p class="status">진행여부 표시</p>
                    <h2 class="project-title">프로젝트 명</h2>
                    <p class="company">by 회사명</p>
                    <p class="price">결제금액 <strong>15,000원</strong></p>
                    <p class="payment-method">결제방식 <span>체크카드</span></p>
                    <a href="#" class="refund-btn">환불신청</a>
                </div>
            </div>

            <div class="funding-card">
                <div class="funding-info">
                    <p class="category">펀딩유형/카테고리</p>
                    <p class="status">진행여부 표시</p>
                    <h2 class="project-title">프로젝트 명</h2>
                    <p class="company">by 회사명</p>
                    <p class="price">결제금액 <strong>15,000원</strong></p>
                    <p class="payment-method">결제방식 <span>체크카드</span></p>
                    <a href="#" class="refund-btn">환불신청</a>
                </div>
            </div>
             <div class="funding-card">
                <div class="funding-info">
                    <p class="category">펀딩유형/카테고리</p>
                    <p class="status">진행여부 표시</p>
                    <h2 class="project-title">프로젝트 명</h2>
                    <p class="company">by 회사명</p>
                    <p class="price">결제금액 <strong>15,000원</strong></p>
                    <p class="payment-method">결제방식 <span>체크카드</span></p>
                    <a href="#" class="refund-btn">환불신청</a>
                </div>
            </div>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <a href="#" class="prev-btn">&lt; 이전</a>
            <a href="#" class="page active">1</a>
            <a href="#" class="page">2</a>
            <a href="#" class="page">3</a>
            <span>...</span>
            <a href="#" class="page">8</a>
            <a href="#" class="next-btn">다음 &gt;</a>
        </div>
    </div>
</article>

<footer>
    <jsp:include page="/WEB-INF/views/inc/footer.jsp" />
</footer>

</body>
</html>
