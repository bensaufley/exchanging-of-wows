(function($) {
  'use strict';

  var $form = $();

  var hideResults = function() {
    $('.search-results').fadeOut(150, function() {
      $(this).remove();
    });
  };

  var search = function() {
    var _this = this,
        $this = $(this);
    if (_this.value) {
      $.ajax({
        url: '/song_requests/search',
        data: { search: this.value },
        success: function (data) {
          $('.search-results').remove();
          let pos = $(_this).position();
          $('<ul>', {
            'class': 'search-results',
            html: data.html,
            css: {
              top: pos.top + $this.outerHeight(false), left: pos.left
            }
          }).insertAfter(_this);
        }
      })
    } else {
      $form.find('[type=hidden]').val('');
      hideResults();
    }
  };

  var navigate = function(e) {
    if ([38, 40, 13].indexOf(e.which) < 0) { return true; }
    e.preventDefault();
    var $results = $('.search-results'),
        $selected = $results.find('.selected');
    switch (e.which) {
      case 38: // up
        if ($selected.length) {
          $selected.removeClass('selected')
            .prev().addClass('selected').end();
        } else {
          $results.find('li').last().addClass('selected');
        }
        break;
      case 40: // down
        if ($selected.length) {
          $selected.removeClass('selected')
            .next().addClass('selected').end();
        } else {
          $results.find('li').first().addClass('selected');
        }
        break;
      case 13: // enter/return
        $results.find('.selected').trigger('click');
    }
    if (!($selected = $results.find('.selected')).length) {
      $selected = $results.find('li').first().addClass('selected');
    }
    $results.animate({ scrollTop: $selected.position().top }, 150);
  };

  var selectSong = function() {
    var data = $(this).data(),
        $form = $('#song-request-form'),
        key;
    hideResults();
    for (key in data) {
      if (!data.hasOwnProperty(key)) { continue; }
      $form.find('input[name*=' + key + ']').val(typeof data[key] == 'string' ? data[key] : JSON.stringify(data[key]));
    }
    $form.find('input[name=search]').val(data.name + ' by ' + data.artist)
  };

  $(function() {
    $form = $('#song-request-form');
    $form
      .on('click', '.search-results li', selectSong)
      .find('input[name=search]')
        .on('input', $.throttle(150, false, search))
        .on('blur', hideResults)
        .on('keyup', navigate);
  });

})(jQuery);
