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

  function updateReadStatus($topic, isRead) {
    if(isRead) {
      $topic.addClass("thredded--topic-read").removeClass("thredded--topic-unread");
    } else {
      $topic.addClass("thredded--topic-unread").removeClass("thredded--topic-read");
    }
  }

  function readToggle() {
    console.log("readToggle");
    let $topic = $(this).closest('.thredded--topics--topic');
    let path;
    if($topic.hasClass("thredded--topic-read")) {
      path = $topic.find('a.thredded--topic--read-state-toggle.thredded--topic--mark-as-unread').data("postPath");
    } else{
      path = $topic.find('a.thredded--topic--read-state-toggle.thredded--topic--mark-as-read').data("postPath");
    }
    console.log({path, find: $topic.find('a.thredded--topic--read-state-toggle.thredded--topic--mark-as-unread')})
    $.ajax({
      url: path, type: "POST", success: function (data) {
        console.log("success: ");
        console.log(data);
        updateReadStatus($topic, data["read"]);
      }
    });
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
  }

)
(jQuery);

