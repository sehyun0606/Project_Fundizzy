<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사이드 메뉴</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style type="text/css">
	    
		
		.sidebar {
		    width: 250px;
		    background: #f9f9f9;
		    padding: 15px;
		    border-right: 1px solid #ddd;
		    height: 100vh;
		}
		
		.project-number {
		    background: #eee;
		    padding: 10px;
		    text-align: center;
		    font-weight: bold;
		    border-radius: 5px;
		    margin-bottom: 20px;
		}
		
		.number {
		    color: #a855f7;
		}
		
		 .sidebar {
            width: 250px;
            background: #f8f8f8;
            padding: 10px;
            border-right: 1px solid #ddd;
        }
        .menu-item {
            padding: 10px;
            cursor: pointer;
            border-bottom: 1px solid #ddd;
        }
        .submenu {
            display: none;
            padding-left: 15px;
        }
        .submenu-item {
            padding: 8px 0;
            color: #black;
            display: flex;
            justify-content: space-between;
        }
        .submenu2 {
            padding-left: 15px;
        }
        .submenu-item2 {
            padding: 8px 0;
            color: #black;
            display: flex;
            justify-content: space-between;
        }
        a:hover{
        	color: mediumpurple;
        }
        a {
        	color:black;
        	text-decoration: none;
        }
        .side-button {
			background: #6c5ce7;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
		}
    </style>
</head>


    <div class="sidebar">
        <div class="project-number">프로젝트 번호 <span class="number">000001</span></div>

       
        <div class="menu-item">
        <span class="menu-title">고객센터</span>
            <div class="submenu2">
                <div class="submenu-item2"><a>고객센터 문의</a></div>
                <div class="submenu-item2"><a>문의 등록</a></div>
            </div>
        </div>
        <div class="menu-item">
        	<span class="menu-title">프로젝트 관리 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <button class="side-button" onclick="location.href='ProjectMaker'"> 관리 홈</button>
            <div class="submenu">
                <div class="submenu-item"><a href="ProjectPlan">서비스 요금</a> <span>작성중</span></div>
                <div class="submenu-item"><a href="ProjectInfo">프로젝트 정보</a> <span>작성전</span></div>
                <div class="submenu-item"><a href="ProjectStory">스토리 작성</a> <span>작성전</span></div>
                <div class="submenu-item"><a href="ProjectReword">리워드 설계</a> <span>작성전</span></div>
                <div class="submenu-item"><a href="MakerInfo">메이커 정보</a> <span>작성전</span></div>
            </div>
        </div>
        <div class="menu-item">
        	<span class="menu-title">프로젝트 현황</span>
            <div class="submenu">
                <div class="submenu-item"><a href="#">프로젝트 현황</a> </div>
                <div class="submenu-item"><a href="#">정산 정보</a> </div>
                <div class="submenu-item"><a href="SettlementDetail">정산 내역</a> </div>
                <div class="submenu-item"><a href="ShipAndRefund">발송,환불 관리</a> </div>
            </div>
        </div>
        <div class="menu-item">
        	<span class="menu-title">프로젝트 부스팅</span>
            <div class="submenu2">
                <div class="submenu-item2"><a>광고</a></div>
                <div class="submenu-item2"><a>메이커 QR 코드 제작</a></div>
                <div class="submenu-item2"><a>AI 어드바이저</a></div>
            </div>
        </div>
    </div>


    <script>
	    $(document).ready(function() {
	        $(".menu-title").click(function() {
	            $(this).siblings(".submenu").slideToggle();
	        });
	    });
	    $(document).ready(function() {
	        function adjustSidebarHeight() {
	            $(".sidebar").css("height", $("body").height());
	        }
	        
	        adjustSidebarHeight();
	        
	        $(window).resize(function() {
	            adjustSidebarHeight();
	        });
	    });
	</script>


</html>