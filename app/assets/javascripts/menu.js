/*global $*/
$(function(){
  var menu = $("#menu");
  $("#toggle").click(function(){
    menu.toggle();
    return false;
  });
  $(window).resize(function(){
    var win = $(window).width();
    var p = 1024;
    if(win > p){
      $(menu).show();
    }
  });
});