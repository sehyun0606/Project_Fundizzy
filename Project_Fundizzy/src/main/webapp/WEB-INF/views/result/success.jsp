<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<script>
	// 컨트롤러에서 Model 객체를 통해 저장한 msg 속성값을 alert() 함수를 통해 출력
// 	alert("${msg}"); // \${msg} 부분은 서버측에서 뷰페이지 렌더링 시 실제 값으로 치환되어 전송됨
	
	// 서버로부터 전송된 targetURL 속성값이 [비어있을 경우] 이전 페이지로 돌아가기 처리하고
	// 아니면, targetURL 속성에 지정된 페이지로 이동 처리
// 	if("${targetURL}" == "") { // targetURL 이 비어있을 경우
// 		// 이전 페이지로 돌아가기
// 		history.back();
// 	} else { // targetURL 이 비어있지 않을 경우
// 		// 지정된 페이지로 이동
// 		location.href = "${targetURL}";
// 	}
	// -----------------------------------------------------
	// 추가) "isClose" 속성값이 "true" 일 경우(또는 비어있지 않을 경우) 현재 창(자식창) 닫기	
	// => 자바스크립트 코드로 판별할 경우 문자열 "true"/"false" 형태로 판별 필요함
	//    단, true 일 경우에만 값이 전달되고 false 일 경우에는 속성 자체를 전달하지 않기 때문에
	//    문자열 존재 여부만 판별해도 true 판별이 가능함
	if("${isClose}") { // 창 닫기를 수행해야할 경우
		// 이동할 주소 존재 여부 판별
		<c:choose>
			<c:when test="${empty targetURL}"> // 이동할 주소가 없을 경우
				// window.opener 객체를 활용하여 부모창에 접근 가능
				// 부모창 새로고침
				window.opener.location.reload();
			</c:when>
			<c:otherwise> // 이동할 주소가 있을 경우
				// window 객체는 생략 가능하므로 opener.xxx 지정해도 동일함
				opener.location.href = "${targetURL}";
			</c:otherwise>
		</c:choose>
		
		// 현재창(자식창) 닫기
		window.close();
	}
	// -----------------------------------------------------
	// 자식창이 열려있지 않거나 자식창 닫기 작업이 수행되지 않을 경우
	// 아래쪽의 주소 판별 후 이동 작업 코드는 그대로 수행
	// -----------------------------------------------------
	// JSTL 사용할 경우(실제 수행하는 이동처리 코드만 보이고 if 문은 클라이언트측에서 보이지 않음)
	<!-- targetURL 속성값이 비어있는지 판별(EL 로 직접 판별 = empty 활용) -->
	<c:choose>
		<c:when test="${empty targetURL}">
			history.back();
		</c:when>
		<c:otherwise>
			location.href = "${targetURL}";
		</c:otherwise>
	</c:choose>
</script>






