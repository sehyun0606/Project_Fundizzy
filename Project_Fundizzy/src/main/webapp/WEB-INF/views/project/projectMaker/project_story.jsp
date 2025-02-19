<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스토리 정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            margin: 0px;
        }
        .container {
            width: 60%;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
        }
        h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .image-upload {
        	width: 150px;
   			height: 150px;	
            display: flex;
            flex-direction: column;
            align-items: center;
            border: 2px dashed #ccc;
            padding: 20px;
            margin-top: 10px;
            text-align: center;
            cursor: pointer;
        }
        .image-upload img {
            width: 50px;
            opacity: 0.5;
        }
        .toolbar {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        .toolbar button {
            padding: 5px 10px;
            border: 1px solid #ccc;
            background: white;
            cursor: pointer;
        }
        .toolbar button:hover {
            background: #ddd;
        }
        .helper-text {
            font-size: 12px;
            color: gray;
        }
        .link {
            color: purple;
            font-size: 12px;
            text-decoration: underline;
            cursor: pointer;
        }
        .file-upload{
        	display: flex;
        	justify-content: center;
        	text-align: center;
        	flex-direction: column;
        	max-width: 150px;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div style="width: 100%;">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
	    <div class="container" >
	        <h2>스토리 정보</h2>
	        
	        <label for="title">프로젝트 제목</label>
	        <input type="text" id="title" placeholder="제목을 입력해 주세요">
	        <span class="helper-text">40자 남음</span>
	        
         	<label>대표 이미지</label>
		    <div class="file-upload">
		        <input type="file" id="fileInput" accept="image/*" style="display: none;">
		        <img id="previewImage" class="preview" src="" alt="미리보기" style="display:none;">
		        <input type="button" class="image-upload" value="사진을 넣어주세요">
		        <p id="fileName">0/1</p>
		    </div>
	
	        <label>소개 이미지</label>
	        <div class="image-upload">
	            <img src="placeholder.png" alt="소개 이미지">
	            <p>0/10</p>
	        </div>
	
	        <label for="summary">프로젝트 요약</label>
	        <textarea id="summary" rows="3" placeholder="내용 입력"></textarea>
	        <span class="helper-text">100자 남음</span>
	
	        <label for="story">프로젝트 스토리</label>
	        <div class="toolbar">
	            <button>굵기</button>
	            <button>밑줄</button>
	            <button>색상</button>
	            <button>양쪽 정렬</button>
	            <button>목록</button>
	            <button>이미지</button>
	        </div>
	        <textarea id="story" rows="5" placeholder="내용 입력"></textarea>
	
	        <span class="link">에디터에서 작성된 추천 받기</span>
	    </div>
    </div>
    <script type="text/javascript">
    $(document).ready(function() {
        $(".image-upload").click(function() {
            $("#fileInput").click();
        });

        $("#fileInput").change(function(event) {
            let file = event.target.files[0]; 
            if (file) {
                let reader = new FileReader();
                reader.onload = function(e) {
                    $("#previewImage").attr("src", e.target.result).show(); 
                    $(".image-upload").hide(); 
                };
                reader.readAsDataURL(file); 
                $("#fileName").text(file.name);
            } else {
                $("#previewImage").hide(); 
                $(".image-upload").show(); 
                $("#fileName").text("0/1");
            }
        });
        $(".preview").click(function(){
        	$("#fileInput").click();
        });	
        })
    </script>
</body>
</html>
