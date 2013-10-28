PUBLIC_APP.init = ->
  console.log 'public views'

  $('.fancybox').fancybox({})

  $('.iframe').fancybox
    type: 'iframe'

  $('#business_category_carousel').carouFredSel
    items: 1
    width: 370
    height: 341
    scroll:
      items: 1
      duration: 800
      pauseOnHover: true
      fx: 'fade'
    auto:
      play: true
