APP.init = ->
  $("a[rel=popover]").popover()
  $(".popover").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  $("input[type='text']")[1].focus()
