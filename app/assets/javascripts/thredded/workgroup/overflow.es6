(($) => {

  const MAX_HEIGHT = 100; // $thredded-condensed-height
  const MAX_SCROLL_HEIGHT = MAX_HEIGHT + 8; // why ?

  function findOverflows() {
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
      $elem.addClass('thredded--condensable--hover');
    }
  }

  function unhoverOverflow() {
    let $elem = $(this);
    $elem.removeClass('thredded--condensable--hover');
  }

  function clickOverflow(e) {
    e.preventDefault();
    e.stopPropagation();
    console.log("clicking");
    let $elem = $(this);
    if ($elem.hasClass('thredded--condensable--hover')) {
      $elem.removeClass('thredded--condensable--hover');
      $elem.removeClass('thredded--condensable--condensed').addClass('thredded--condensable--expanded');
    } else {
      // touch only or already condensed, so clicking again
      $elem.toggleClass('thredded--condensable--condensed').toggleClass('thredded--condensable--expanded');
    }
  }

  const Thredded = window.Thredded;

  Thredded.onPageLoad(() => {
    findOverflows();
    $('.thredded--condensable.thredded--condensable--overflowing')
      // .hover(hoverOverflow, unhoverOverflow)
      .click(clickOverflow);
  })

})(jQuery);
