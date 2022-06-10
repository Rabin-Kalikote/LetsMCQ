# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # if $('#letsmcq').length
  #   $(window).bind 'beforeunload', ->
  #     return 'Leave the Game?'
  #   $(document).on 'turbolinks:before-visit', (event) ->
  #     return event.preventDefault() if !confirm('Leave the Game?')
  #     return

  $('#enter-ground-form').submit (e) ->
    e.preventDefault()
    window.location.href = "#{window.location.href}grounds/#{$('#enter-ground-form #name').val()}/join"
    return

  $('.copy-ground-name').click ->
    $temp = $('<input>')
    $('body').append $temp
    $temp.val($('#ground-name').text()).select()
    document.execCommand 'copy'
    $temp.remove()
    $(this).html('Copied')

  $('.process-selection').click ->
    $.ajax
      url: "#{window.location.href}/score"
      type: 'GET'
      data: {kind: 'add'}
      success: -> return
      error: -> return
