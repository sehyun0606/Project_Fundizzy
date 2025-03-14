<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 | 비밀번호 찾기</title>
    <link rel="stylesheet" type="text/css" href="resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="resources/css/login/find_success_email.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/main_top.jsp" />
    </header>

    <article class="main-container">
        <section class="find-account-container">
            <div class="find-header"><h2>아이디 | 비밀번호 찾기</h2></div>
            
            <!-- ✅ 탭 메뉴 -->
            <div class="tab-menu">
                <button class="tab-btn active" id="find-id">아이디 찾기</button>
                <button class="tab-btn" id="find-password" onclick="location.href='FindPasswd'">비밀번호 찾기</button>
            </div>

            <!-- ✅ 내용 박스 -->
            <div class="content-box">
            	<h3>${DBInfo.email}</h3>
                <p><b>회원으로 등록된 이메일 아이디입니다.<br>
				해당 이메일로 로그인하고 펀디즈를 이용하세요!</b></p>

                <!-- ✅ 이메일 입력 필드 -->
                <button class="login-button" onclick="location.href='Login'">로그인 하러가기</button>

                <!-- ✅ 확인 버튼 -->
                <button class="confirm-btn" onclick="history.back()">다시 확인</button>
            </div>
        </section>
    </article>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/footer.jsp" />
    </footer>

    <script>
        $(document).ready(function () {
            $(".tab-btn").click(function () {
                $(".tab-btn").removeClass("active");
                $(this).addClass("active");
            });
        });
    </script>
</body>
</html>
