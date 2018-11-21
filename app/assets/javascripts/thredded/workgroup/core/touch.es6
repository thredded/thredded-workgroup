(($) => {
  const Thredded = window.Thredded;
  const ThreddedWorkgroup = window.ThreddedWorkgroup;

  Thredded.onPageLoad(() => {
    ThreddedWorkgroup.touching = undefined;
    $(document)
      .on("touchstart", () => {
        ThreddedWorkgroup.touching = true;
      })
      .on("touchend", () => {
        // timeout to make sure it happens after any spurious hovers have happened
        window.setTimeout(()=>{ ThreddedWorkgroup.touching = undefined; }, 200);
      });
  });
})(jQuery);
