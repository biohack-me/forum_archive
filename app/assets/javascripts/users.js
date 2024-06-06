function toggle_discussions() {
  $("#user_discussions").fadeToggle();
  $("#toggle_discussions").text($("#toggle_discussions").text() == 'show discussions' ? 'hide discussions' : 'show discussions');
}

function toggle_comments() {
  $("#user_comments").fadeToggle();
  $("#toggle_comments").text($("#toggle_comments").text() == 'show comments' ? 'hide comments' : 'show comments');
}