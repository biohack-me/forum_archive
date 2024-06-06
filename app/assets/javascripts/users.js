$(function() {

  $("#toggle_discussions").click(function() {
    $("#user_discussions").fadeToggle();
    $("#toggle_discussions").text($("#toggle_discussions").text() == 'show discussions' ? 'hide discussions' : 'show discussions');
    return false;
  });

  $("#toggle_comments").click(function() {
    $("#user_comments").fadeToggle();
    $("#toggle_comments").text($("#toggle_comments").text() == 'show comments' ? 'hide comments' : 'show comments');
    return false;
  });

});