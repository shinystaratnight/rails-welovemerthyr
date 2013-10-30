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

  $('#update-guides-form input[type=checkbox]').on 'click', (e) ->
    $('#update-guides-form').submit()

  $("input.uniform").uniform()
