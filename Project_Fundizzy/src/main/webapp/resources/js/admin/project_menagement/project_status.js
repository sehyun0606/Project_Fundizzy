$(document).ready(function() {
	 let projectCode;
     // 모달 열기
     $(".project-info").click(function() {
         $("#modal").fadeIn();
         projectCode = $(this).closest("tr").find(".project_code").text();
         console.log(projectCode)
         
          $.ajax({
  			url : "AdminGetProjectInfo",
			type : "GET",
			data : {
				projectCode
			},
			dataType: "json",  
			contentType: "application/json; charset=UTF-8"
		}).done(function(result){
			console.log("응답 받은 데이터: ", result);
			// 받아온 데이터 모달창에 반영
		    $("#project-title").text(result.project_title);
		    $("#category").text(result.category);
		    $("#sub-category").text(result.sub_category);
		    $("#service-type").text(result.service_type);
		    $("#target-amount").text(result.target_amount.toLocaleString() + "원"); // 숫자 포맷 적용
		    $("#adult-check").text(result.adult_check === "Y" ? "성인용" : "일반");
		    
		    // 대표 이미지 처리
		    $("#representative-picture").attr("src", "/resources/upload/" + result.representative_picture);
			
		}).fail(function(){
			console.log("실패..")
		})
     });

     // 모달 닫기 (닫기 버튼 클릭)
     $(".close-btn").click(function() {
         $("#modal").fadeOut();
     });

     // 모달 닫기 (배경 클릭)
     $(".modal-overlay").click(function(event) {
         if (event.target === this) {
             $(this).fadeOut();
         }
     });
     
     // 탭 버튼 클릭 시 내용 변경
     $(".tab-btn").click(function() {
         let tabId = $(this).data("tab");
		console.log(projectCode)				
         // 모든 탭 버튼과 콘텐츠에서 active 제거
         $(".tab-btn").removeClass("active");
         $(".tab-content").removeClass("active");

         // 선택한 탭 버튼과 콘텐츠에 active 추가
         $(this).addClass("active");
         $("#" + tabId).addClass("active");
         
         if(tabId == "basic-info"){
        	 $.ajax({
	  			url : "AdminGetProjectInfo",
				type : "GET",
				data : {
					projectCode
				},
				dataType: "json",  
     			contentType: "application/json; charset=UTF-8"
			}).done(function(result){
				console.log("응답 받은 데이터: ", result);
				// 받아온 데이터 모달창에 반영
			    $("#project-title").text(result.project_title);
			    $("#category").text(result.category);
			    $("#sub-category").text(result.sub_category);
			    $("#service-type").text(result.service_type);
			    $("#target-amount").text(result.target_amount.toLocaleString() + "원"); // 숫자 포맷 적용
			    $("#adult-check").text(result.adult_check === "Y" ? "성인용" : "일반");
			    
			    // 대표 이미지 처리
			    $("#representative-picture").attr("src", "/resources/upload/" + result.representative_picture);
				
			}).fail(function(){
				console.log("실패..")
			})
         }else if(tabId == "reward-info"){
        	 $.ajax({
 		  			url : "AdminGetRewardInfo",
 					type : "GET",
 					data : {
 						projectCode
 					},
 					dataType: "json",  
         			contentType: "application/json; charset=UTF-8"
 				}).done(function(result){
 					console.log("응답 받은 데이터: ", result);
 					
 					let tableBody = $("#reward-info-table tbody");
 				    tableBody.empty(); // 기존 내용 초기화
 				   result.forEach(function(reward) {
 					    // 각 값을 템플릿 리터럴로 넣어준다
 					    let row = `<tr>
 					        <td class="product_name">${reward.product_name}</td>
 					        <td class="product_desc">${reward.product_desc}</td>
 					        <td class="price">${reward.price}</td>
 					        <td class="delivery_fee">${reward.delivery_fee}</td>
 					        <td class="product_limit">${reward.product_limit}</td>
 					    </tr>`;
 					    tableBody.append(row); // 새로운 행을 테이블에 추가

 					    console.log(reward.product_name); // 잘 출력됨
 					});
 					
 				}).fail(function(){
 					console.log("실패..")
 				})
         }
         
      
     });
 });