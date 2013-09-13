APP.init = ->
  $("a[rel=popover]").popover()
  $(".popover").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  if $("input[type='text']")[1]?
    $("input[type='text']")[1].focus()
