$(document).ready(function() {
    // 오늘 날짜 이전 선택 불가능하게 설정
    let today = new Date().toISOString().split("T")[0];
    $("input[type='date']").attr("min", today);
    
    function setDateRange(startSelector, endSelector, resultSelector) {
        let startDate = $(startSelector).val();
        let endDate = $(endSelector).val();
        
        if (!startDate || !endDate) {
            $(resultSelector).text("날짜를 모두 선택해주세요.");
            return;
        }
        
        let start = new Date(startDate);
        let end = new Date(endDate);
        
        if (end < start) {
            $(resultSelector).text("종료 날짜는 시작 날짜 이후여야 합니다.");
            return;
        }
        
        $(resultSelector).text(`선택한 기간: ${startDate} ~ ${endDate}`);
    }
    
    function setDateLimits(startSelector, endSelector) {
        $(startSelector).change(function() {
            let minEndDate = new Date($(this).val());
            let maxEndDate = new Date($(this).val());
            minEndDate.setDate(minEndDate.getDate() + 14); // 최소 2주 후
            maxEndDate.setDate(maxEndDate.getDate() + 30); // 최대 1달 후
            $(endSelector).attr("min", minEndDate.toISOString().split("T")[0]);
            $(endSelector).attr("max", maxEndDate.toISOString().split("T")[0]);
        });
    }
    
    setDateLimits("#openStartDate", "#openEndDate");
    
    $("#openSetDates").click(function() {
        setDateRange("#openStartDate", "#openEndDate", "#openResult");
    });
    
    $("#fundSetDates").click(function() {
        setDateRange("#fundStartDate", "#fundEndDate", "#fundResult");
    });
    
    // 오픈예정 종료 날짜 선택 시 펀딩 시작 날짜를 다음 날로 설정하고, 펀딩 종료 날짜 제한 적용
    $("#openEndDate").change(function() {
        let nextDay = new Date($(this).val());
        nextDay.setDate(nextDay.getDate() + 1); // 다음 날 설정
        let formattedNextDay = nextDay.toISOString().split("T")[0];
        
        // 펀딩 시작 날짜 설정 및 비활성화
        $("#fundStartDate").val(formattedNextDay).attr("min", formattedNextDay).prop("disabled", true);
        
		$("#fundStartDate2").val(formattedNextDay);
		
        
        // 펀딩 종료 날짜 제한 설정 (최소 2주 후, 최대 1달 후)
        let minFundEndDate = new Date(formattedNextDay);
        let maxFundEndDate = new Date(formattedNextDay);
        minFundEndDate.setDate(minFundEndDate.getDate() + 14); // 최소 2주 후
        maxFundEndDate.setDate(maxFundEndDate.getDate() + 30); // 최대 1달 후
        $("#fundEndDate").attr("min", minFundEndDate.toISOString().split("T")[0]);
        $("#fundEndDate").attr("max", maxFundEndDate.toISOString().split("T")[0]);
    });

	
});
