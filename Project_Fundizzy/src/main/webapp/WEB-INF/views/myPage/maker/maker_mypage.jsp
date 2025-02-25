<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 리스트</title>
    <style>
        body {
            margin: 0;
        }

        /* 기존 프로젝트 리스트 스타일 */
        .project-container {
            width: 600px;
            margin: 20px auto;
            text-align: left;
            background: white;
            padding: 20px;
            border-radius: 10px;
            border: 0.1px solid mediumpurple;
        }
        .project-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .project-list {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .project-box {
            width: 200px;
            padding: 10px;
            background: #f3f3f3;
            text-align: center;
            border-radius: 8px;
        }
        .project-box .image-placeholder {
            width: 100%;
            height: 120px;
            background: #ccc;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 14px;
            border-radius: 5px;
        }
        .project-box .title-input {
            margin-top: 10px;
            font-size: 14px;
            color: #666;
        }
        .project-status {
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }
        .create-project-button {
            width: 100%;
            padding: 15px;
            background: mediumpurple;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .create-project-button:hover {
            background: purple;
        }

        /* 새로운 UI (오늘 데이터 보기) */
        .data-container {
            width: 600px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            border: 0.1px solid mediumpurple;
        }
        .data-header {
            font-size: 20px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .data-header .refresh-icon {
            cursor: pointer;
            font-size: 16px;
            color: #333;
        }
        .data-summary {
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            color: #666;
            border-top: 1px solid #eee;
            padding-top: 10px;
        }

        /* 새로운 UI (오늘 펀딩·프리오더) */
        .funding-container {
            width: 600px;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            border: 0.1px solid mediumpurple;
        }
        .funding-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .funding-box {
            width: 90%;
            background: #f8f9fa;
            padding: 30px;
            text-align: center;
            border-radius: 8px;
            font-size: 14px;
            color: #666;
        }
        .main{
        	display: flex;
        	
        }
        .main-container{
        	margin-left: 16vh;
        }
        /* 모달 스타일 */
        .modal {
            display: none; /* 초기에는 숨김 */
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        .modal-content {
            background: white;
            width: 550px;
            padding: 20px;
            margin: 15% auto;
            border-radius: 10px;
            text-align: center;
            position: relative;
        }
        .close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 24px;
            cursor: pointer;
            color: #999;
        }
        .close:hover {
            color: black;
        }
        .modal-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .modal-input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .modal-button {
            width: 100%;
            padding: 10px;
            background: mediumpurple;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .modal-button:hover {
            background: purple;
        }
        .project-type-box {
		    background: white;
		    padding: 20px;
		    border-radius: 10px;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    border: 1px solid #ddd;
		    margin-bottom: 1%;
		}
		
		.title {
		    display: block;
		    font-weight: bold;
		    margin-bottom: 10px;
		}
		
		.option {
		    display: flex;
		    align-items: flex-start;
		    gap: 10px;
		    margin-bottom: 10px;
		}
		
		.option input {
		    display: none;
		}
		
		.option label {
		    display: flex;
		    align-items: flex-start;
		    gap: 10px;
		    cursor: pointer;
		}
		
		.radio {
		    width: 16px;
		    height: 16px;
		    border: 2px solid #7c3aed;
		    border-radius: 50%;
		    position: relative;
		    display: inline-block;
		}
		
		.option input:checked + label .radio::after {
		    content: "";
		    width: 8px;
		    height: 8px;
		    background: #7c3aed;
		    border-radius: 50%;
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		}
		
		.option strong {
		    font-size: 16px;
		    color: #333;
		}
		
		.option p {
		    font-size: 14px;
		    color: #666;
		    margin: 0;
		}
		        
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	<div class="main">
	<jsp:include page="/WEB-INF/views/inc/profile_side.jsp"></jsp:include>
		<div class="main-container">
		    <div class="project-container">
		        <div class="project-title">만든 프로젝트 <span style="color: mediumpurple;">2</span></div>
		        <div class="project-list">
		            <div class="project-box">
		                <div class="image-placeholder">이미지 등록 필요</div>
		                <div class="title-input">제목을 입력해주세요</div>
		                <div class="project-status">작성 중</div>
		            </div>
		            <div class="project-box">
		                <div class="image-placeholder">이미지 등록 필요</div>
		                <div class="title-input">제목을 입력해주세요</div>
		                <div class="project-status">작성 중</div>
		            </div>
		        </div>
		        <button class="create-project-button">프로젝트 만들기</button>
		    </div>
		
		    <div class="data-container">
		        <div class="data-header">
		            오늘 데이터 한 번에 보기 <span class="refresh-icon">🔄</span>
		        </div>
		        <div class="data-summary">
		            <div>찜 · 알림신청 -</div>
		            <div>결제(예약) -</div>
		            <div>지지서명 -</div>
		            <div>앵콜요청 -</div>
		        </div>
		    </div>
		
		    <div class="funding-container">
		        <div class="funding-title">오늘 펀딩·프리오더</div>
		        <div class="funding-box">
		            진행 중인 프로젝트가 없어요. <br>
		            지금 바로 펀디지에서 새로운 프로젝트를 시작해 보세요.
		        </div>
		    </div>
	    </div>
	</div>
	<div id="project-modal" class="modal">
        <div class="modal-content">
	            <span class="close">&times;</span>
	            <div class="modal-title">새 프로젝트 만들기</div>
	             <div class="project-type-box">
			        <label class="title">프로젝트 유형</label>
			        <div class="option">
			            <input type="radio" id="funding" name="project-type" checked>
			            <label for="funding">
			                <span class="radio"></span>
			                <strong>펀딩</strong>
			                <p>한번도 출시된 적 없는 새 제품을 선보여요</p>
			            </label>
			        </div>
			        <div class="option">
			            <input type="radio" id="preorder" name="project-type">
			            <label for="preorder">
			                <span class="radio"></span>
			                <strong>프리오더</strong>
			                <p>기존에 출시된 제품을 특별한 혜택과 함께 제공하세요</p>
			            </label>
			        </div>
			    </div>
	            <button class="modal-button">프로젝트 생성</button>
        </div>
    </div>
    <script>
        $(document).ready(function() {
            // 모달 열기
            $(".create-project-button").click(function() {
                $("#project-modal").fadeIn();
            });

            // 모달 닫기 (× 버튼)
            $(".close").click(function() {
                $("#project-modal").fadeOut();
            });

            // 모달 닫기 (배경 클릭)
            $(window).click(function(event) {
                if ($(event.target).is("#project-modal")) {
                    $("#project-modal").fadeOut();
                }
            });
        });
    </script>
</body>
</html>
