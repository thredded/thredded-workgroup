(($) => {

  function hoverTopicTitle() {
    $(this).closest('.thredded--topics--topic').addClass("thredded--hovering");
  }
  function unhoverTopicTitle() {
    $(this).closest('.thredded--topics--topic').removeClass("thredded--hovering");
  }
  function hoverTopic() {
    $(this).find('.thredded--topic-post-and-last-user').addClass("thredded--hovering");
  }
  function unhoverTopic() {
    $(this).find('.thredded--topic-post-and-last-user').removeClass("thredded--hovering");
  }
  function viewTopic() {
    var $a = $(this).closest('.thredded--topics--topic').find(".thredded--topic-title a");
    window.location.href = $a.attr('href');
  }
  function hoverTopicReadToggle() {
    console.log("hoverTopicReadToggle");
    $(this).closest('.thredded--topics--topic').find('.thredded--topic--read-state-toggle').addClass("thredded--hovering");
  }
  function unhoverTopicReadToggle() {
    console.log("unhoverTopicReadToggle");
    $(this).closest('.thredded--topics--topic').find('.thredded--topic--read-state-toggle').removeClass("thredded--hovering");
  }
  function readToggle() {

  }
  $(document).ready(() => {
    $('.thredded--topics--topic .thredded--topic-title')
      .hover(hoverTopicTitle, unhoverTopicTitle).click(viewTopic);
    $('.thredded--topic--read-state-toggle')
      .hover(hoverTopicReadToggle, unhoverTopicReadToggle).click(readToggle);
    $('.thredded--topics--topic')
      .hover(hoverTopic, unhoverTopic);
  });
})(jQuery);

