<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<script>

	<c:choose>
		<c:when test="${empty msg}">
		</c:when>
		<c:otherwise>
			alert("${msg}");
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${empty targetURL}">
			history.back();
		</c:when>
		<c:otherwise>
			location.href = "${targetURL}";
		</c:otherwise>
	</c:choose>
</script>






