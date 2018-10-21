(function ($) {
  $(document).ready(function () {
    function removeFollower($followerSelector) {
      $followerSelector.remove();
    };

    function clickRemoveFollower(e) {
      e.preventDefault();
      var $this = $(this);
      console.log(this);
      console.log($this);
      var $followerSelector = $this.closest('.thredded--follower');
      var path = $this.data('kickPath');
      console.log($followerSelector);
      console.log(path);
      $.ajax({
        url: path, type: "POST", success: function (data) {
          removeFollower($followerSelector);
        }
      });
    }

    $('.thredded--follower--remove').click(clickRemoveFollower);
  });
})(jQuery);
