(function() {
  var centerContent;
  $(function() {
    prettyPrint();
    $('input.color-input').excolor({
      root_path: 'img/'
    });
    centerContent();
    return $(window).resize(function() {
      return centerContent;
    });
  });
  centerContent = function() {
    var fixed_container_height, half_container_height, half_window_height, window_height;
    window_height = $(window).height();
    half_window_height = (window_height / 2) - 50;
    fixed_container_height = $('#container').height();
    half_container_height = fixed_container_height / 2;
    return $('#container').css({
      height: fixed_container_height,
      position: 'relative',
      clear: 'both',
      margin: '0 auto'
    }).before('<div class="fixed-center" style="height: ' + half_window_height + 'px; float: left; margin-bottom: -' + half_container_height + 'px; overflow: hidden;"></div>');
  };
}).call(this);
