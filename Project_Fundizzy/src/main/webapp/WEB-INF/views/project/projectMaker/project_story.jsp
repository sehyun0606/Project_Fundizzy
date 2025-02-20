<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
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
            resize: none;
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
        .multi-upload {
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
        .multi-preview{
	        width: 150px;
	        height: 150px;
        }
        .multi-preview-container{
        	display: flex;
        }
        .multi-preview-wrapper{
        	margin: 10%;
        }
        #editor-container {
	      	height: 300px;
	    }

    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div style="width: 100%;">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
	    <div class="container" >
	        <h2>스토리 정보</h2>
	        <form id="form">
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
	
	       <label>소개 이미지 (다중 파일 업로드)</label>
		   <div class="file-upload">
		       <input type="file" id="multiFileInput" accept="image/*" multiple >
		       <input type="button" class="multi-upload" value="사진 여러 개 추가">
		       <div class="multi-preview-container" id="multiPreviewContainer"></div>
		       <p id="multiFileCount">0/10</p>
		   </div>	
		   
	        <label for="summary">프로젝트 요약</label>
	        <textarea id="summary"  placeholder="내용 입력"></textarea>
	        <span class="helper-text">100자 남음</span>
	
	        <label for="story">프로젝트 스토리</label>
	        <div id="toolbar">
			    <button class="ql-bold"></button>
			    <button class="ql-italic"></button>
			    <button class="ql-underline"></button>
			    <button class="ql-strike"></button>
			    <select class="ql-header">
			      <option selected></option>
			      <option value="1">Header 1</option>
			      <option value="2">Header 2</option>
			    </select>
			    <button class="ql-blockquote"></button>
			    <button class="ql-code-block"></button>
			    <button class="ql-link"></button>
			    <button class="ql-image"></button>
		  	</div>
		
		  <!-- 편집기 -->
		  <div id="editor-container"></div>
		  <input id="storyText" type="text" name="project_story">

	
	        <span class="link">에디터에서 작성된 추천 받기</span>
	        </form>
	    </div>
    </div>
     <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function() {
    	
    	//스토리 작성 텍스트박스 함수
    	 var quill = new Quill('#editor-container', {
    	      modules: {
    	        toolbar: '#toolbar'
    	      },
    	      theme: 'snow'  // 'bubble' 테마도 가능
    	    });
		
    	//작성한 스토리를 hidden에 넣는 코드
    	 let targetNode = $("#editor-container")[0]; // jQuery 객체에서 DOM 요소 가져오기

        let observer = new MutationObserver(function() {
            let text = $(".ql-editor").html(); // div 내부 텍스트 가져오기
            $("#storyText").val(text); // input에 자동 반영
        });
			
        var toolbar = quill.getModule("toolbar");
        toolbar.addHandler("image", function () {
          let input = document.createElement("input");
          input.setAttribute("type", "file");
          input.setAttribute("accept", "image/*");
          input.click();

          input.onchange = function () {
            let file = input.files[0];
            let reader = new FileReader();
            reader.onload = function () {
              let base64Image = reader.result;
              let range = quill.getSelection();
              quill.insertEmbed(range.index, "image", base64Image);
            };
            reader.readAsDataURL(file);
          };
        });
        let config = { childList: true, subtree: true, characterData: true };
        observer.observe(targetNode, config);
    	
    	let multiFileCount = 0;
    	
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
        
        $(".multi-upload").click(function() {
            $("#multiFileInput").click();
        });
        
        $(function () {
            let selectedFiles = [];

            $("#multiFileInput").on("change", function(event) {
                let newFiles = Array.from(event.target.files);
                let dataTransfer = new DataTransfer();
                let previewContainer = $("#multiPreviewContainer");

                newFiles.forEach(file => {
                    // 중복 방지 (파일 이름과 크기가 같으면 추가 안 함)
                    if (!selectedFiles.some(f => f.name === file.name && f.size === file.size)) {
                        selectedFiles.push(file);
                        dataTransfer.items.add(file);

                        // 이미지 미리보기 추가
                        let reader = new FileReader();
                        reader.onload = function(e) {
                            let imgWrapper = $("<div class='multi-preview-wrapper'></div>");
                            let img = $("<img class='multi-preview'>").attr("src", e.target.result);
                            let removeBtn = $("<button class='remove-btn'>&times;</button>");

                            removeBtn.click(function() {
                                imgWrapper.remove();
                                selectedFiles = selectedFiles.filter(f => f !== file);

                                let updatedDataTransfer = new DataTransfer();
                                selectedFiles.forEach(f => updatedDataTransfer.items.add(f));
                                $("#multiFileInput")[0].files = updatedDataTransfer.files;
                            });

                            imgWrapper.append(img).append(removeBtn);
                            previewContainer.append(imgWrapper);
                        };
                        reader.readAsDataURL(file);
                    }
                });

                $("#multiFileInput")[0].files = dataTransfer.files;
                updateFileList();
                console.log(selectedFiles)
            });

            function updateFileList() {
                $("#fileList").empty();
                selectedFiles.forEach((file, index) => {
                    $("#fileList").append(
                        `<li>${file.name} <button type="button" class="removeFile" data-index="${index}">삭제</button></li>`
                    );
                });
            }

            $("#fileList").on("click", ".removeFile", function () {
                let index = $(this).data("index");
                selectedFiles.splice(index, 1);
                updateFileList();
            });

            $("#btnMultipleFile").on("click", function () {
                submitFormWithFiles();
            });

            $("#form").on("submit", function (event) {
                event.preventDefault();
                submitFormWithFiles();
            });

            function submitFormWithFiles() {
                let formData = new FormData($("#form")[0]);

                selectedFiles.forEach(file => {
                    formData.append("file", file);
                });

                $("#multiFileInput").remove();
                let newFileInput = $("<input>").attr({
                    type: "file",
                    name: "file",
                    multiple: true
                });

                newFileInput[0].files = createFileList(formData.getAll("file"));
                $("#form").append(newFileInput);
                $("#form")[0].submit();
            }

            function createFileList(files) {
                let dataTransfer = new DataTransfer();
                files.forEach(file => dataTransfer.items.add(file));
                return dataTransfer.files;
            }
        });

      
	        
	        
        })
    </script>
</body>
</html>
