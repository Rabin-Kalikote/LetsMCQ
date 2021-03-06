(function() {
  $(function() {
    $('#enter-ground-form').submit(function(e) {
      e.preventDefault();
      window.location.href = window.location.href + "grounds/" + ($('#enter-ground-form #name').val()) + "/join";
    });
    $('.copy-ground-name').click(function() {
      var $temp;
      $temp = $('<input>');
      $('body').append($temp);
      $temp.val($('#ground-name').text()).select();
      document.execCommand('copy');
      $temp.remove();
      return $(this).html('Copied');
    });
    return $('.process-selection').click(function() {
      return $.ajax({
        url: window.location.href + "/score",
        type: 'GET',
        data: {
          kind: 'add'
        },
        success: function() {},
        error: function() {}
      });
    });
  });

}).call(this);
