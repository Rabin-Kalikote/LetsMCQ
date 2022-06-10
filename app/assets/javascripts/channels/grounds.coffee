# $(document).on 'turbolinks:load', ->
if $('html').data('controller') == 'grounds' and $('html').data('action') == 'show'
  App.grounds = App.cable.subscriptions.create "GroundsChannel",
    connected: ->
      console.log 'Ground connection established'
      # Called when the subscription is ready for use on the server
    disconnected: ->
      console.log 'Ground connection ended'
      # Called when the subscription has been terminated by the server
    received: (data) ->
      console.log data
      switch data.action
        when 'joined'
          $('.participants').append(data.user) if !$(".participants #participant-#{data.user_id}").length
        when 'left'
          $(".participants #participant-#{data.user_id}").remove()
        when 'scored'
          if data.kind == 'add'
            $(".participants #participant-#{data.user_id} .score").append('+1')
            $(".participants #participant-#{data.user_id}-score").html('add 1 here')
          else
            $(".participants #participant-#{data.user_id}").append('+0')
        when 'started'
          $('.action-start').toggleClass('d-none')
          $('.mcqs').toggleClass('d-none')
        when 'ended'
          $('.notices').append(data.why)
          setTimeout ->
            window.location.replace('http://localhost:3000/grounds')
          , 5000
        else
          console.log 'Unknown action'

      # Called when there's incoming data on the websocket for this channel
