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
    $newSvg.click(clickFollowIcon);
    $svg.replaceWith($newSvg);
    $newSvg.show();
  };
  function clickFollowIcon(){
    var $icon = $(this);
    var $topic = $icon.parents('.thredded--topics--topic');
    var following = $topic.hasClass('thredded--topic-following');
    var topicId = $topic.data("topic");
    var messageboardId = $topic.data("messageboard");
    var rootPath = $('#thredded--container').data('thredded-root-url');

    var path = "" + rootPath + messageboardId + "/" + topicId + "/" + (following ? 'unfollow.json' : 'follow.json');
    $icon.show();
    $.ajax({
      url: path, type: "POST", success: function (data) {
        updateFollowStatus($icon, $topic,  data["follow"])
      }
    });
  }
  $('.thredded--topics--follow-icon').click(clickFollowIcon);
});
