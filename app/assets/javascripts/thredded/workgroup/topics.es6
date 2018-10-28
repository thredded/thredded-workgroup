(($) => {

  function hoverTopicTitle() {
    $(this).closest('.thredded--topics--topic').addClass("thredded--topic-hovering");
  }
  function unhoverTopicTitle() {
    $(this).closest('.thredded--topics--topic').removeClass("thredded--topic-hovering");
  }
  function hoverTopic() {
    $(this).find('.thredded--topic-last-post-with-controls').addClass("thredded--topic-hovering");
  }
  function unhoverTopic() {
    $(this).find('.thredded--topic-last-post-with-controls').removeClass("thredded--topic-hovering");
  }
  function viewTopic(e) {
    var $a = $(this).closest('.thredded--topics--topic').find("a.thredded--topic--view-button");
    window.location.href = $a.attr('href');
    e.preventDefault();
    e.stopPropagation();
  }
  function hoverTopicReadToggle() {
    console.log("hoverTopicReadToggle");
    $(this).closest('.thredded--topics--topic').find('.thredded--topic--read-state-toggle').addClass("thredded--topic-hovering");
  }
  function unhoverTopicReadToggle() {
    console.log("unhoverTopicReadToggle");
    $(this).closest('.thredded--topics--topic').find('.thredded--topic--read-state-toggle').removeClass("thredded--topic-hovering");
  }
  function readToggle() {

  }

  function hoverHighlight() {
    $(this).addClass('thredded--topic-hovering');
  }

  function unhoverHighlight() {
    $(this).removeClass('thredded--topic-hovering');
  }

  $(document).ready(() => {
    $('.thredded--topics--topic .thredded--topic-title')
      .hover(hoverTopicTitle, unhoverTopicTitle).click(viewTopic);
    $('.thredded--topic--read-state-toggle')
      .hover(hoverTopicReadToggle, unhoverTopicReadToggle).click(readToggle);
    $('.thredded--topics--topic')
      .hover(hoverTopic, unhoverTopic);
    $('.thredded--topics--topic thredded--topic--view-button')
      .click(viewTopic);
    $('.thredded--topic-last-post-with-controls').hover(hoverHighlight, unhoverHighlight);
  });
})(jQuery);

