$(function () {
  $('.thredded--topics--topic .thredded--topic-title, .thredded--topics--topic .thredded--topic-followers,' +
    '.thredded--topics--topic .thredded--topics--posts-count').hover(
    function(){$(this).closest('.thredded--topics--topic').addClass("thredded--rollover")},
    function(){$(this).closest('.thredded--topics--topic').removeClass("thredded--rollover")}
  ).click(function() {
    var $a = $(this).closest('.thredded--topics--topic').find(".thredded--topic-title a");
    window.location.href = $a.attr('href');
  });
});

