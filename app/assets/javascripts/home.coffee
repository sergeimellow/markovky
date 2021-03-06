# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#twitter_submit').click ->
    payload = twitter_username: $('#twitter_username').val()
    $('#word-map-link').data 'username', $('#twitter_username').val()
    $('.container').hide 0
    # Instantiate baffle
    b = baffle('#success-container')
    be = baffle('#error-container')
    b.text(->
      'Generating... (May take a minute or two)'
    ).reveal 3000
    $('#success-container').show 0

    # Maybe separate into it's own method
    $.post '/markov/fetch_twitter_chain.json', payload, (data) ->
      b.stop()
      if data.error
        $('#success-container').hide 0
        be.text(->
          data.error
        ).reveal 250
        $('#error-container').show 0
      else
        $('#error-container').hide 0
        b.text(->
          data.sentence
        ).reveal 250
        $('#success-container').show 0
        $('#word-map-link').show 0
        $('#twitter_submit').val("Generate Another Sentence")
      return
    return

  $('#word-map-link').click ->
    $.get '/markov/fetch_word_map.js', {twitter_username: $('#word-map-link').data 'username'}
