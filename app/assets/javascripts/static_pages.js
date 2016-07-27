// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require jquery.lettering.js

(function($) {
  'use strict';

  var $callout = $('<div>', { 'class': 'callout', 'data-closable': '' }).append(
      $('<button>', { 'class': 'close-button', type: 'button', 'data-close': '', html: '&times;' })
  );

  var showAlert = function(content, className, parent) {
    $(parent).find('.callout').slideUp(150).promise().done(function() {
      $(this).remove();
      var $newCallout = $callout.clone();
      $newCallout.addClass(className).prepend(content).prependTo(parent).hide().slideDown(150);
    });
  }

  var ajaxError = function(e, xhr, status, error) {
    var message;
    try {
      message = JSON.parse(xhr.responseText).errors || error;
    } catch (er) {
      message = error; 
    }
    showAlert('<strong>Error:</strong> ' + message, 'alert', this);
  };

  var ajaxSuccess = function(e, data, status, xhr) {
    if (data.status === 'ok') {
      showAlert(data.notice, 'success', this);
    } else {
      ajaxError(e, status, xhr, data.errors);
    }
  };

  $(function() {
    $('.arch').lettering();

    $('#rsvp').on({
      'ajax:success': ajaxSuccess,
      'ajax:error': ajaxError
    }, 'form');

  });
}(jQuery));
