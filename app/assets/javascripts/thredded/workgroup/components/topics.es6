(($) => {
  const ThreddedWorkgroup = window.ThreddedWorkgroup;

  function updateFollowStatus($topic, followStatus) {
    if (followStatus) {
      $topic.removeClass('thredded--topic-notfollowing').addClass('thredded--topic-following')
    } else {
      $topic.removeClass('thredded--topic-following').addClass('thredded--topic-notfollowing')
    }
  };

  function clickFollowToggle(e) {
    e.preventDefault();
    e.stopPropagation();
    var $this = $(this);
    var $topic = $this.parents('.thredded--topics--topic');
    var following = $topic.hasClass('thredded--topic-following');
    var topicId = $topic.data("topic");
    var messageboardId = $topic.data("messageboard");
    var rootPath = $('#thredded--container').data('thredded-root-url');

    var path = "" + rootPath + messageboardId + "/" + topicId + "/" + (following ? 'unfollow.json' : 'follow.json');
    // console.log("about to ajax: " + path);
    $.ajax({
      url: path, type: "POST", success: function (data) {
        updateFollowStatus($topic, data["follow"])
      }
    });
  }

  function hoverTopicFollowToggle(){
    if (ThreddedWorkgroup.touching) {
      return;
    }
    console.log("i am trying to hover");
    $(this).closest('.thredded--topics--topic').find('.js-thredded-follow-toggle').addClass("thredded--topic-hovering");
  }
  function unhoverTopicFollowToggle(){
    $(this).closest('.thredded--topics--topic').find('.js-thredded-follow-toggle').removeClass("thredded--topic-hovering");
  }
  function hoverTopicTitle() {
    if (ThreddedWorkgroup.touching) {
      return;
    }
    $(this).closest('.thredded--topics--topic').addClass("thredded--topic-hovering");
  }

  function unhoverTopicTitle() {
    $(this).closest('.thredded--topics--topic').removeClass("thredded--topic-hovering");
  }

  function hoverTopic() {
    if (ThreddedWorkgroup.touching) {
      return;
    }
    $(this).find('.thredded--topic-last-post-with-controls').addClass("thredded--topic-hovering");;
  }

  function revealControls($topic){
    $topic
  }

  function toggleControlsOnTouch() {
    if (ThreddedWorkgroup.touching) {
      $(this).closest('.thredded--topics--topic').find('.thredded--topic-last-post-with-controls').toggleClass("thredded--topic-hovering");;
    }
  }

  function unhoverTopic() {
    if (ThreddedWorkgroup.touching) {
      return;
    }
    $(this).find('.thredded--topic-last-post-with-controls').removeClass("thredded--topic-hovering");
  }

  function viewTopic(e) {
    var $a = $(this).closest('.thredded--topics--topic').find("a.thredded--topic--view-button");
    window.location.href = $a.attr('href');
    e.preventDefault();
    e.stopPropagation();
  }

  function hoverTopicReadToggle() {
    if (ThreddedWorkgroup.touching) {
      return;
    }
    $(this).closest('.thredded--topics--topic').find('.thredded--topic--read-state-toggle').addClass("thredded--topic-hovering");
  }

  function unhoverTopicReadToggle() {
    $(this).closest('.thredded--topics--topic').find('.thredded--topic--read-state-toggle').removeClass("thredded--topic-hovering");
  }

  function updateReadStatus($topic, isRead) {
    if (isRead) {
      $topic.addClass("thredded--topic-read").removeClass("thredded--topic-unread");
    } else {
      $topic.addClass("thredded--topic-unread").removeClass("thredded--topic-read");
    }
  }

  function readToggle() {
    let $topic = $(this).closest('.thredded--topics--topic');
    let path;
    if ($topic.hasClass("thredded--topic-read")) {
      path = $topic.find('a.thredded--topic--read-state-toggle.thredded--topic--mark-as-unread').data("postPath");
    } else {
      path = $topic.find('a.thredded--topic--read-state-toggle.thredded--topic--mark-as-read').data("postPath");
    }
    $.ajax({
      url: path, type: "POST", success: function (data) {
        updateReadStatus($topic, data["read"]);
      }
    });
  }

  function hoverHighlight() {
    if (ThreddedWorkgroup.touching) {
      return;
    }
    $(this).addClass('thredded--topic-hovering');
  }

  function unhoverHighlight() {
    $(this).removeClass('thredded--topic-hovering');
  }

  const Thredded = window.Thredded;

  Thredded.onPageLoad(() => {
    console.log("I am load");
    $('.js-thredded-follow-toggle')
      .hover(hoverTopicFollowToggle, unhoverTopicFollowToggle)
      .click(clickFollowToggle);
    $('.thredded--topics--topic .thredded--topic-title')
      .hover(hoverTopicTitle, unhoverTopicTitle)
      .click(viewTopic);
    $('.thredded--topic--read-state-toggle')
      .hover(hoverTopicReadToggle, unhoverTopicReadToggle)
      .click(readToggle);
    $('.thredded--topics--topic')
      .hover(hoverTopic, unhoverTopic)
    $('.thredded--topics--topic thredded--topic--view-button')
      .click(viewTopic);
    $('.thredded--topic-last-post-with-controls')
      .hover(hoverHighlight, unhoverHighlight)
      .click(toggleControlsOnTouch);
  });

})(jQuery);

