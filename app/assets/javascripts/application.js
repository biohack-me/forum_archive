//= require jquery3

$(function() {
  $("#toggle_navigation").click(function() {
    $(".mobile").hide();
    $(".navigation").fadeIn();
    return false;
  });
});