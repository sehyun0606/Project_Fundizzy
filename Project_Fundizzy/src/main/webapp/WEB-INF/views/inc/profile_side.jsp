<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사이드 메뉴</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style type="text/css">
	    
		
		
		.profile-image {
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
        
        .toggle-container {
            display: inline-flex;
            align-items: center;
            background: #e5e7eb;
            border-radius: 20px;
            padding: 4px;
            width: 190px;
            position: relative;
            cursor: pointer;
            margin-left: 10%;
    		margin-bottom: 10%;
		}

        /* 라벨 스타일 */
        .toggle-label {
            flex: 1;
            text-align: center;
            font-size: 14px;
            color: #555;
            user-select: none;
            transition: color 0.3s ease-in-out;
        }

        /* 실제 체크박스 숨기기 */
        .toggle-checkbox {
            display: none;
        }

        /* 토글 스위치 버튼 */
        .toggle-slider {
            position: absolute;
            left: 4px;
            width: 50%;
            height: 24px;
            background: #222;
            border-radius: 20px;
            transition: left 0.3s ease-in-out;
        }

        .toggle-slider::before {
            content: "서포터";
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            color: white;
            font-size: 14px;
            font-weight: bold;
        }
		.toggle-checkbox:checked + .toggle-slider::before {
            content: "메이커";
        }
        /* 체크되었을 때(오른쪽 이동) */
        .toggle-checkbox:checked + .toggle-slider {
            left: 50%;
        }

        /* 체크되었을 때 텍스트 스타일 변경 */
        .toggle-checkbox:checked ~ .supporter {
            color: #aaa;
        }

        .toggle-checkbox:not(:checked) ~ .maker {
            color: #aaa;
        }
        
        #pay_btn{
        width: 230px;
        height: 40px;
        margin-top: 10px;
        }
        .profile-image img {
		    width: 80px;
		    height: 80px;
		    border-radius: 10%; /* 원형 */
		    border: 3px solid #c85fdf; /* 보라색 테두리 */
		}
    </style>
</head>


    <div class="sidebar">
        <div class="profile-image">
        	<c:choose>
        		<c:when test="${empty sessionScope.profileImg }">
        			<img src="/resources/images/myPage/noImg.jpeg"/>
        		</c:when>
        		<c:otherwise>
        			<img src="/resources/upload/${sessionScope.profileImg}"/>
        		</c:otherwise>
        	</c:choose>
        </div>
        <input type="button" class="settings" value="내 정보 설정" onclick="location.href='SettingMain'">

       <input type="button" value="페이" id="pay_btn" onclick="location.href='PayPage'">
        <div class="menu-item">
        	<span class="menu-title">프로젝트</span>
            <div class="submenu2">
                <div class="submenu-item2"><a>프로젝트 정산</a></div>
            </div>
        </div>
        <div class="menu-item">
        	<span class="menu-title">고객센터</span>
            <div class="submenu2">
                <div class="submenu-item2"><a href="HelpCenter">도움말 센터</a></div>
            </div>
        </div>
        <div class="menu-item">
        	<span class="menu-title">소식</span>
            <div class="submenu2">
                <div class="submenu-item2"><a href="Notice">공지사항</a></div>
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
	        
	        $(".toggle-checkbox").change(function() {
                if ($(this).is(":checked")) {
                    window.location.href = "MakerPage"; 
                }
                else {
                	window.location.href = "SupporterPage";
                }
            });
	        
	    });
	</script>


</html>