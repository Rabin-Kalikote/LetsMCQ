(function() {
  if ($('html').data('controller') === 'grounds' && $('html').data('action') === 'show') {
    App.grounds = App.cable.subscriptions.create("GroundsChannel", {
      connected: function() {
        return console.log('Ground connection established');
      },
      disconnected: function() {
        return console.log('Ground connection ended');
      },
      received: function(data) {
        console.log(data);
        switch (data.action) {
          case 'joined':
            if (!$(".participants #participant-" + data.user_id).length) {
              return $('.participants').append(data.user);
            }
            break;
          case 'left':
            return $(".participants #participant-" + data.user_id).remove();
          case 'scored':
            if (data.kind === 'add') {
              $(".participants #participant-" + data.user_id + " .score").append('+1');
              return $(".participants #participant-" + data.user_id + "-score").html('add 1 here');
            } else {
              return $(".participants #participant-" + data.user_id).append('+0');
            }
            break;
          case 'started':
            $('.action-start').toggleClass('d-none');
            return $('.mcqs').toggleClass('d-none');
          case 'ended':
            $('.notices').append(data.why);
            return setTimeout(function() {
              return window.location.replace('http://localhost:3000/grounds');
            }, 5000);
          default:
            return console.log('Unknown action');
        }
      }
    });
  }

}).call(this);
