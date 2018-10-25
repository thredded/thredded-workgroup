(function($) {
  $(document).ready(function () {
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
      console.log("about to ajax: "+ path);
      $.ajax({
        url: path, type: "POST", success: function (data) {
          console.log("success: ");
          console.log(data);
          updateFollowStatus($topic, data["follow"])
        }
      });
    }

    $('a.thredded-follow-toggle').click(clickFollowToggle);
  });
})(jQuery);
