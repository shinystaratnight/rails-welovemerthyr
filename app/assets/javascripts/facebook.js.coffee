jQuery ->
  #$('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true

  window.fbAsyncInit = ->
    FB.init(appId: '1410335719200136', status: true, cookie: true)

    $('#subscribe_with_facebook').click (e) ->
      e.preventDefault()
      FB.login (response) ->
        window.location = '/auth/facebook/callback' if response.authResponse
      ,
        scope: 'email,publish_stream,offline_access'

    #$('#sign_out').click (e) ->
    #  FB.getLoginStatus (response) ->
    #    FB.logout() if response.authResponse
    #  true
