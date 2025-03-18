<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <title>스토리 정보</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/projectMaker/project_story.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/projectMaker/project_story_edit.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/project_maker_side.jsp"></jsp:include>
	<div style="width: 100%;">
		<jsp:include page="/WEB-INF/views/inc/project_maker_top.jsp"></jsp:include>
	    <div class="container" >
        	<form id="form" action="ProjectStoryUpdate" enctype="multipart/form-data" method="post">
        		<input type="hidden" name="project_code" value="${sessionScope.project_code}">
		    	<div class="title-section">
			        <h2>스토리 정보</h2>
		    		<button class="side-button" type="submit"> 제출하기</button>
		    	</div>
		        <label for="title">프로젝트 제목</label>
		        <input type="text" id="title" name="project_title" value="${projectStory.project_title}" placeholder="제목을 입력해 주세요">
		        <span class="helper-text">40자 남음</span>
		        
	         	<label>대표 이미지</label>
			    <div class="file-upload">
			        <input type="file" id="fileInput" name="representativePicture" accept="image/*" style="display: none;">
			        <img id="previewImage" class="preview" name="representativePicture" src="${projectStory.representative_picture}" alt="미리보기" >
			        <input type="button" class="image-upload" value="사진을 넣어주세요" style="display: none;">
			        <p id="fileName">1/1</p>
			    </div>
		
		       <label>소개 이미지 (다중 파일 업로드)</label>
			   <div class="file-upload">
			       <input type="file" id="multiFileInput" name="productPicture" accept="image/*" multiple >
			       <input type="button" class="multi-upload" value="사진 다시 선택하기">
			       <div class="multi-preview-container" id="multiPreviewContainer">
			       		<c:forEach items="${imgList}" var="img">
			       			<div class="multi-preview-wrapper">
			       				<img class="multi-preview" src="/resources/upload/${img}">
			       				<button type="button" class="remove-btn">x</button>
			       			</div>
			       		</c:forEach>
			       </div>
			       <p id="multiFileCount">${fn:length(imgList) }/10</p>
			   </div>	
			   	<div id="project-summary">
			        <div><label for="summary">프로젝트 요약</label></div>
			        <div><a class="ai-link">ai어드바이저에게 추천받기</a></div>
			   	</div>
		        <span class="helper-text">소개 이미지와 함깨 보이는 글이에요 프로젝트를 쉽고 간결하게 소개해 주세요</span>
		        <textarea id="summary"  name="project_content" placeholder="내용 입력">${projectStory.project_content}</textarea>
		        <span class="helper-text">100자 남음</span>
		
		        <label for="story">프로젝트 스토리</label>
		        <span class="helper-text">이미지의 너비는 720px 이상으로 등록해야 상세페이지 스토리에 여백이 생기지 않아요</span>
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
			  <input id="storyText" value='${projectStory.project_story}' type="text" name="project_story">
			  
			 <label for="story">오픈예정 스토리</label>
		        <span class="helper-text">이미지의 너비는 720px 이상으로 등록해야 상세페이지 스토리에 여백이 생기지 않아요</span>
		        <div id="toolbar2">
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
			  	<div id="editor-container2"></div>
			  	<input id="openText" value='${projectStory.open_story}' type="text" name="open_story">
	        </form>
	    </div>
    </div>
    <footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp" />
	</footer>
     <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
</body>
</html>
