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
});