(function ($) {
  $(document).ready(function () {
    function removeFollower($followerSelector) {
      $followerSelector.remove();
    };

    function clickRemoveFollower(e) {
      e.preventDefault();
      e.stopPropagation();
      var $this = $(this);
      var $followerSelector = $this.closest('.thredded--follower');
      var path = $this.data('kickPath');
      $.ajax({
        url: path, type: "POST", success: function (data) {
          removeFollower($followerSelector);
        }
      });
    }

    $('.thredded--follower--remove').click(clickRemoveFollower);
  });
})(jQuery);
