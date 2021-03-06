(function($) {
  'use strict';
  var searchRequest;

  var $form = $();

  var hideResults = function() {
    $('.search-results').fadeOut(150, function() {
      $(this).remove();
    });
  };

  var search = function() {
    var _this = this,
        $this = $(this);
    $form.find('input.hide').val('')
      .filter('[name*=info]').val('{}');
    if (_this.value) {
      if (searchRequest) { searchRequest.abort(); }
      searchRequest = $.ajax({
        url: '/song_requests/search',
        data: { search: this.value },
        success: function (data) {
          if (!$this.is(':focus')) { return; }
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

  var navigateUp = function($results, $selected) {
    if ($selected.length) {
      $selected.removeClass('selected')
        .prev().addClass('selected').end();
    } else {
      $results.find('li').last().addClass('selected');
    }
  }

  var navigateDown = function($results, $selected) {
    if ($selected.length) {
      $selected.removeClass('selected')
        .next().addClass('selected').end();
    } else {
      $results.find('li').first().addClass('selected');
    }
  }

  var navigate = function(e) {
    if ([38, 40, 13].indexOf(e.which) < 0) { return true; }
    e.preventDefault();
    var $results = $('.search-results'),
        $selected = $results.find('.selected');
    switch (e.which) {
      case 38: // up
      	navigateUp($results, $selected);
        break;
      case 40: // down
        navigateDown($results, $selected);
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
    $form.find('input[name=search]').blur();
    for (key in data) {
      if (!data.hasOwnProperty(key)) { continue; }
      $form.find('input[name*=' + key + ']').val(typeof data[key] === 'string' ? data[key] : JSON.stringify(data[key]));
    }
    $form.find('input[name=search]').val(data.name + ' by ' + data.artist)
  };

  var invalidRequest = function(e) {
    alert('Please select a song from the search results');
  };

  $(function() {
    $form = $('#song-request-form');
    $form
      .on('click', '.search-results li', selectSong)
      .on('click', ':invalid :submit', invalidRequest)
      .find('input[name=search]')
        .on('input', $.throttle(150, false, search))
        .on('blur', hideResults)
        .on('keyup', navigate);
  });

}(jQuery));
