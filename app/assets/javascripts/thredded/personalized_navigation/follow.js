$(document).ready(function () {

  function updateFollowStatus($svg, $topic, followStatus) {
    var $newSvg = $svg.clone();
    if (followStatus) {
      $topic.removeClass('thredded--topic-notfollowing').addClass('thredded--topic-following')
      $newSvg.find('use').attr('xlink:href', '#thredded-follow-icon');

    } else {
      $topic.removeClass('thredded--topic-following').addClass('thredded--topic-notfollowing')
      $newSvg.find('use').attr('xlink:href', '#thredded-unfollow-icon');
    }
    $svg.replaceWith($newSvg);
    $newSvg.show();
  };

  $('.thredded--topic-follow-icon').click(function () {
    var $svg = $(this).find('svg');
    var $topic = $svg.parents('.thredded--topics--topic');
    var following = $topic.hasClass('thredded--topic-following');
    var topicId = $topic.data("topic");
    var messageboardId = $topic.data("messageboard");
    var $definitions = $('#thredded--definitions');
    var rootPath = $definitions.data('thredded-root');

    var path = "" + rootPath + messageboardId + "/" + topicId + "/" + (following ? 'unfollow.json' : 'follow.json');
    $svg.show();
    $.ajax({
      url: path, type: "POST", success: function (data) {
        updateFollowStatus($svg, $topic,  data["follow"])
      }
    });
  });
});
