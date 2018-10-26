(($) => {
  console.log("topic_last_post.es6 loaded");
  const MAX_HEIGHT = 100; // $thredded-condensed-height
  const MAX_SCROLL_HEIGHT = MAX_HEIGHT + 8; // why ?

  function findOverflows() {
    console.log("topic_last_post.findOverflows running");
    $('.thredded--condensable').each((i, elem) => {
      let $elem = $(elem);
      let sH = $elem.prop('scrollHeight');
      if (sH > MAX_SCROLL_HEIGHT) {
        // let h = $elem.height();
        // let oH = $elem.prop('offsetHeight');;
        // let overflow = sH - h;
        // let id = $elem.closest(".thredded--topics--topic").attr("id");
        // console.log({i, id, sH, h, oH, overflow});
        $elem.addClass("thredded--condensable--overflowing");
        $elem.find(".thredded--condensable--overflow-only").fadeIn()
      }
    });
  }

  function hoverOverflow() {
    console.log("hovering");
    let $elem = $(this);
    if ($elem.hasClass('thredded--condensable--condensed')) {
      $elem.addClass('thredded--hover-revealing');
      $elem.removeClass('thredded--condensable--condensed').addClass('thredded--condensable--expanded');
    }
  }

  function unhoverOverflow() {
    console.log("unhovering");
    let $elem = $(this);
    if ($elem.hasClass('thredded--hover-revealing')) {
      $elem.removeClass('thredded--hover-revealing');
      $elem.addClass('thredded--condensable--condensed').removeClass('thredded--condensable--expanded');
    }
  }

  function clickOverflow(e) {
    e.preventDefault();
    e.stopPropagation();
    console.log("clicking");
    let $elem = $(this);
    if ($elem.hasClass('thredded--hover-revealing')) {
      // non touch
      $elem.removeClass('thredded--hover-revealing');
      $elem.removeClass('thredded--condensable--condensed').addClass('thredded--condensable--expanded');
    } else {
      // touch
      $elem.toggleClass('thredded--condensable--condensed').toggleClass('thredded--condensable--expanded');
    }
  }

  function hoverHighlight() {
    $(this).addClass('thredded--hovering');
  }

  function unhoverHighlight() {
    $(this).removeClass('thredded--hovering');
  }

  $(document).ready(() => {
    console.log("topic_last_post.es6 running");
    findOverflows();
    $('.thredded--condensable.thredded--condensable--overflowing').hover(hoverOverflow, unhoverOverflow).click(clickOverflow);
    $('.thredded--condensable').hover(hoverHighlight, unhoverHighlight);
  })
})(jQuery);
