$(document).on('turbolinks:load', function() {
  $('#cmt-count').click(function() {
    $('.show-it').slideToggle("slow");
  });
});