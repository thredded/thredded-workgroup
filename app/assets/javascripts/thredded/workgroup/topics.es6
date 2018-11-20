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
    $(this).closest('.thredded--topics--topic').find('.thredded--topic--read-state-toggle').addClass("thredded--topic-hovering");
  }

  function unhoverTopicReadToggle() {
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
    let $topic = $(this).closest('.thredded--topics--topic');
    let path;
    if($topic.hasClass("thredded--topic-read")) {
      path = $topic.find('a.thredded--topic--read-state-toggle.thredded--topic--mark-as-unread').data("postPath");
    } else{
      path = $topic.find('a.thredded--topic--read-state-toggle.thredded--topic--mark-as-read').data("postPath");
    }
    $.ajax({
      url: path, type: "POST", success: function (data) {
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
        .mouseover(hoverTopicTitle).mouseleave(unhoverTopicTitle).click(viewTopic);
      $('.thredded--topic--read-state-toggle')
        .mouseover(hoverTopicReadToggle).mouseleave(unhoverTopicReadToggle)
        .click(readToggle);
      $('.thredded--topics--topic')
        .mouseover(hoverTopic).mouseleave(unhoverTopic);
      $('.thredded--topics--topic thredded--topic--view-button')
        .click(viewTopic);
      $('.thredded--topic-last-post-with-controls').mouseover(hoverHighlight).mouseleave(unhoverHighlight);
    });
  }

)
(jQuery);

