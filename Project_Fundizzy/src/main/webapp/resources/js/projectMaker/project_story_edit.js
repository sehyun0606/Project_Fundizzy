$(document).ready(function () {
    // 첫 번째 Quill 에디터 초기화
    var quill1 = new Quill("#editor-container", {
        modules: {
            toolbar: {
                container: "#toolbar",
                handlers: {
                    image: function () {
                        imageHandler(quill1);
                    }
                }
            }
        },
        theme: "snow"
    });

    // 두 번째 Quill 에디터 초기화
    var quill2 = new Quill("#editor-container2", {
        modules: {
            toolbar: {
                container: "#toolbar2",
                handlers: {
                    image: function () {
                        imageHandler(quill2);
                    }
                }
            }
        },
        theme: "snow"
    });
	quill1.enable(false);
	quill2.enable(false);

    // **🔥 기존 데이터 불러와서 Quill 에디터에 삽입**
    let storyContent = $("#storyText").val();
    let openContent = $("#openText").val();

    if (storyContent) {
        quill1.clipboard.dangerouslyPasteHTML(storyContent);
    }
    if (openContent) {
        quill2.clipboard.dangerouslyPasteHTML(openContent);
    }

    // 🔥 Quill의 text-change 이벤트를 이용해 숨겨진 input 업데이트
    function observeEditor(quill, inputSelector) {
        quill.on("text-change", function () {
            let text = quill.root.innerHTML;
            $(inputSelector).val(text);
        });
    }

    observeEditor(quill1, "#storyText");
    observeEditor(quill2, "#openText");

    // 이미지 업로드 핸들러
    function imageHandler(quill) {
        const input = document.createElement("input");
        input.setAttribute("type", "file");
        input.setAttribute("accept", "image/*");
        input.click();

        input.onchange = async () => {
            const file = input.files[0];
            if (!file) return;

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

    // 대표 이미지 업로드 기능
    $(".image-upload").click(function () {
        $("#fileInput").click();
    });

    $("#fileInput").change(function (event) {
        let file = event.target.files[0];
        if (file) {
            let reader = new FileReader();
            reader.onload = function (e) {
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

    $(".preview").click(function () {
        $("#fileInput").click();
    });

    // 다중 파일 업로드 기능
    let selectedFiles = [];

    $(".multi-upload").click(function () {
        $("#multiFileInput").click();
    });

    $("#multiFileInput").on("change", function (event) {
        let newFiles = Array.from(event.target.files);
        let previewContainer = $("#multiPreviewContainer");

        newFiles.forEach(file => {
            if (!selectedFiles.some(f => f.name === file.name && f.size === file.size)) {
                selectedFiles.push(file);
            }
        });

        updateFileInput(); // 🔥 기존 input을 유지한 채 파일 추가

        // 미리보기 UI 업데이트
        previewContainer.empty();
        selectedFiles.forEach(file => {
            let reader = new FileReader();
            reader.onload = function (e) {
                let imgWrapper = $("<div class='multi-preview-wrapper'></div>");
                let img = $("<img class='multi-preview'>").attr("src", e.target.result);
                let removeBtn = $("<button class='remove-btn'>&times;</button>");

                removeBtn.click(function () {
                    imgWrapper.remove();
                    selectedFiles = selectedFiles.filter(f => f !== file);
                    updateFileInput(); // 🔥 삭제 후 input 업데이트
                    updateFileCount();
                });

                imgWrapper.append(img).append(removeBtn);
                previewContainer.append(imgWrapper);
            };
            reader.readAsDataURL(file);
        });

        updateFileCount();
    });

    // 파일 개수 업데이트
    function updateFileCount() {
        $("#multiFileCount").text(selectedFiles.length + "/10");
    }

    // 🔥 기존 input을 유지한 채 파일 목록 갱신
    function updateFileInput() {
        let fileInput = $("#multiFileInput")[0];
        let dataTransfer = new DataTransfer();
        selectedFiles.forEach(file => dataTransfer.items.add(file));
        fileInput.files = dataTransfer.files;
    }

    // 폼 제출 시 파일 전송
    $("#form").on("submit", function (event) {
        event.preventDefault();
        let formData = new FormData($("#form")[0]);

        selectedFiles.forEach(file => {
            formData.append("productPicture", file); // 🔥 "file" → "productPicture"
        });

        $("#form")[0].submit();
    });
});
