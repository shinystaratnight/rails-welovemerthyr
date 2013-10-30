# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

PUBLIC_APP.pages =
  businesses_category: ->
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

  guides: ->
    $('#update-guides-form input[type=checkbox]').on 'click', (e) ->
      $('#update-guides-form').submit()

    $("input").uniform()
