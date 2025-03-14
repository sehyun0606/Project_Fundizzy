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
			    <button class="tab-btn " id="find-id" onclick="location.href='FindEmail'">아이디 찾기</button>
			    <button class="tab-btn active" id="find-password" >비밀번호 찾기</button>
			</div>
		
			<!-- ✅ 내용 박스 -->
			<form action="ActionFindPasswd" method="POST">
	      		<div class="content-box">
          			<p><b>가입하셨던 이메일 계정을 입력하시면,<br>
					비밀번호를 새로 만들 수 있는 링크를 이메일로<br>
					발송해드립니다.</b></p>	
			
	          		<!-- ✅ 이메일 입력 필드 -->
					<input type="email" class="input-field" name="email" id="email" placeholder="이메일 계정">
			
					<!-- ✅ 확인 버튼 -->
			        <input type="button" class="confirm-btn" value="확인">
			    </div>
			 </form>
		</section>
		<!-- ✅ 모달창 -->
		<div id="modal-overlay" class="modal-overlay" style="display: none;">
		    <div class="modal-box">
		        <!-- 닫기 버튼 (X 아이콘) -->
		        <button id="close-modal-x" class="close-modal-x">✕</button>
		
		        <h2 id="modal-title"></h2>
		        <p id="modal-message"></p>
		        <button id="close-modal" class="close-modal">확인</button>
		    </div>
		</div>

		
    </article>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/footer.jsp" />
    </footer>

    <script>
	    $(document).ready(function () {
	        // Enter 키 입력 시 폼 제출 방지
	        $(".input-field").on("keydown", function (event) {
	            if (event.key === "Enter") {
	                event.preventDefault(); // 기본 이벤트(폼 제출) 방지
	                $(".confirm-btn").click(); // 대신 "확인" 버튼 클릭 이벤트 실행
	            }
	        });
	    });
        $(document).ready(function () {
            $(".tab-btn").click(function () {
                $(".tab-btn").removeClass("active");
                $(this).addClass("active");
            });
        });
        
        // 이메일 구현
        $(document).ready(function () {
		    $(".confirm-btn").click(function () {
		        let email = $("#email").val().trim();
		        if (email == "") {
		            showModal("입력 오류", "이메일을 입력하세요.");
		        	event.preventDefault(); // 폼 제출 방지
		            return;
		        }
		
		        $.ajax({
		            type: "POST",
		            url: "ActionFindPasswd",
		            data: { email: email },
		            dataType: "json",
		            success: function (result) {
		                if (result == null) {
		                    showModal("발송 실패", "입력하신 이메일은 존재하지 않습니다. 다시 확인해주세요.");
		                } else {
			            	console.log(result);
			            	console.log("이메일 : " + result.email);
 		                    showModal("발송 완료", "작성하신 이메일로 비밀번호를 변경할 수 있는 링크를 발송했으니 이메일을 확인해주세요.");
		                }
		            },
		            error: function () {
		                showModal("오류", "서버 오류가 발생했습니다. 다시 시도해주세요.");
		            }
		        });
		    });
		
		    // ✅ 모달창 띄우기 함수
		    function showModal(title, message) {
		        $("#modal-title").text(title);
		        $("#modal-message").text(message);
		        $("#modal-overlay").fadeIn();
		    }
		
		    // ✅ 모달창 닫기 이벤트 (확인 버튼 및 X 버튼)
		    $("#close-modal, #close-modal-x").click(function () {
		        $("#modal-overlay").fadeOut();
                $("#email").focus();
		    });
		});

    </script>
</body>
</html>
