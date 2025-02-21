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