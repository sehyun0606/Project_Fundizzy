$(document).ready(function() {

   // Quill 에디터 초기화
	var quill = new Quill("#editor-container", {
	    modules: {
	        toolbar: {
	            container: "#toolbar",
	            handlers: {
	                image: imageHandler // 이미지 업로드 핸들러 추가
	            }
	        }
	    },
	    theme: "snow"
	});

// 이미지 업로드 핸들러 함수
	function imageHandler() {
	    const input = document.createElement("input");
	    input.setAttribute("type", "file");
	    input.setAttribute("accept", "image/*");
	    input.click();
	
	    input.onchange = async () => {
	        const file = input.files[0];
	        const formData = new FormData();
	        formData.append("image", file);
	
	        try {
	            const response = await fetch("StoryImg", {
	                method: "POST",
	                body: formData
	            });
	
	            const imageUrl = await response.text(); 
	
	            if (imageUrl !== "error") {
	                const range = quill.getSelection();
	                quill.insertEmbed(range.index, "image", imageUrl);
	            } else {
	                console.error("Image upload failed");
	            }
	        } catch (error) {
	            console.error("Image upload error:", error);
	        }
	    };
	}
	// MutationObserver를 사용하여 텍스트 업데이트 감지
	let targetNode = $("#editor-container")[0];
	let observer = new MutationObserver(function() {
	    let text = $(".ql-editor").html();
	    $("#storyText").val(text);
	});
	
	let config = { childList: true, subtree: true, characterData: true };
	observer.observe(targetNode, config);


    // 대표 이미지 업로드 기능
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

    // 다중 파일 업로드 기능
    let selectedFiles = [];

    $(".multi-upload").click(function() {
        $("#multiFileInput").click();
    });

    $("#multiFileInput").on("change", function(event) {
        let newFiles = Array.from(event.target.files);
        let dataTransfer = new DataTransfer();
        let previewContainer = $("#multiPreviewContainer");

        newFiles.forEach(file => {
            if (!selectedFiles.some(f => f.name === file.name && f.size === file.size)) {
                selectedFiles.push(file);
            }
        });

        selectedFiles.forEach(file => dataTransfer.items.add(file));
        $("#multiFileInput")[0].files = dataTransfer.files;

        // 미리보기 UI 업데이트
        previewContainer.empty();
        selectedFiles.forEach(file => {
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

                    //삭제 후 개수 업데이트 추가
                    updateFileCount();
                });

                imgWrapper.append(img).append(removeBtn);
                previewContainer.append(imgWrapper);
            };
            reader.readAsDataURL(file);
        });

        //파일 개수 업데이트 추가
        updateFileCount();
    });

    //파일 개수 업데이트 함수 추가
    function updateFileCount() {
        $("#multiFileCount").text(selectedFiles.length + "/10");
    }

    // 폼 제출 시 파일 전송
    $("#form").on("submit", function(event) {
        event.preventDefault();
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
    });

    function createFileList(files) {
        let dataTransfer = new DataTransfer();
        files.forEach(file => dataTransfer.items.add(file));
        return dataTransfer.files;
    }

});
