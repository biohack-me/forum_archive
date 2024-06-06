$(function() {

  $("#toggle_leaders").click(function() {
    $(".leaderboard ol").fadeToggle();
    $("#toggle_leaders").text($("#toggle_leaders").text() == 'show leaderboard' ? 'hide leaderboard' : 'show leaderboard');
    return false;
  });

  $("#toggle_badge_winners").click(function() {
    $(".recipients").fadeToggle();
    $("#toggle_badge_winners").text($("#toggle_badge_winners").text() == 'show recipients' ? 'hide recipients' : 'show recipients');
    return false;
  });

});