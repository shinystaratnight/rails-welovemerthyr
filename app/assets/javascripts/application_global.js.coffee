PUBLIC_APP.init = ->
  console.log 'public views'

  $('.fancybox').fancybox({})

  $('.iframe').fancybox
    type: 'iframe'
