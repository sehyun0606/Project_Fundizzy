document.addEventListener("DOMContentLoaded", function(){
	const checkBox = document.getElementById("toggleCheckbox");
	const grayBox = document.getElementById("graybox");
	
	checkBox.addEventListener("change", function(){
//		if(checkBox.checked){
//			console.log("check");
//		    grayBox.style.display = "block";  // 체크되면 박스 표시
//        } else {
//            grayBox.style.display = "none";   // 체크 해제되면 박스 숨김
//		}
	  grayBox.classList.toggle("hidden", !checkbox.checked);
	});
});