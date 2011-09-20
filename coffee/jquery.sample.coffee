$ ->
  prettyPrint()
  $('input.color-input').excolor({
    root_path: 'img/'
  })
  centerContent()
  $(window).resize( centerContent )
  
centerContent = ->
  window_height = $(window).height()
  half_window_height = (window_height / 2) - 40
  fixed_container_height = $('#container').height()
  half_container_height = fixed_container_height / 2

  if (half_window_height - half_container_height > 0)
    new_top = half_window_height - half_container_height
  else
    new_top = 0

  $('#container').css({
    height: fixed_container_height
    position: 'relative'
    top: new_top
    margin: '0 auto'
  })
  console.log('New top is (or should be) ' + new_top)