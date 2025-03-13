<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 | 비밀번호 찾기</title>
    <link rel="stylesheet" type="text/css" href="resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="resources/css/login/find_info.css">
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
			<form action="ActionFindEmail" method="get">
	      		<div class="content-box">
          			<p><b>펀디즈는 이메일을 아이디로 사용합니다.<br>
            			소유하고 계신 계정을 입력해 주세요.<br>		
            			가입여부를 확인해 드립니다.</b></p>	
			
	          		<!-- ✅ 이메일 입력 필드 -->
					<input type="email" class="input-field" placeholder="이메일 계정" name="email" id="email" required>
			
					<!-- ✅ 확인 버튼 -->
			        <input type="submit" class="confirm-btn" value="확인">
			    </div>
			 </form>
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
