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
	    
		
		
		.profile-image {
		    background: #eee;
		    padding: 10px;
		    text-align: center;
		    font-weight: bold;
		    border-radius: 5px;
		    margin-bottom: 20px;
	        width: 25vh;
		    height: 25vh;
		    margin-left: 8%;
		}
		
		.number {
		    color: #a855f7;
		}
		
		 .sidebar {
            width: 250px;
            background: white;
            padding: 10px;
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
		.settings{
		margin-left: 13%;
	    border: 1px solid mediumpurple;
	    background-color: white;
	    color: mediumpurple;
	    border-radius: 15px;
	    width: 70%;
		}
		.settings:hover{
        	color: white;
        	background-color: mediumpurple;
        }
    </style>
</head>


    <div class="sidebar">
        <div class="profile-image"></div>
        <input type="button" class="settings" value="내 정보 설정" onclick="location.href='SettingMain'">

       
        <div class="menu-item">
        	<span class="menu-title">나의 활동</span>
            <div class="submenu2">
                <div class="submenu-item2"><a>최근본</a></div>
                <div class="submenu-item2"><a>알림 신청</a></div>
            </div>
        </div>
        <div class="menu-item">
        	<span class="menu-title">고객센터</span>
            <div class="submenu2">
                <div class="submenu-item2"><a>채팅 상담</a></div>
                <div class="submenu-item2"><a>도움말 센터</a></div>
            </div>
        </div>
        <div class="menu-item">
        	<span class="menu-title">소식</span>
            <div class="submenu2">
                <div class="submenu-item2"><a>공지사항</a></div>
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
	            $(".sidebar").css("height", $(".main-content").height());
	        }
	        
	        adjustSidebarHeight();
	        
	        $(window).resize(function() {
	            adjustSidebarHeight();
	        });
	    });
	</script>


</html>