$(document).ready(function () {
    $(".add-button").click(function () {
        $("#modal").fadeIn();
    });

    $(".close").click(function () {
        $("#modal").fadeOut();
    });

    $(window).click(function (event) {
        if ($(event.target).is("#modal")) {
            $("#modal").fadeOut();
        }
    });
});