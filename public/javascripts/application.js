// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* Do init stuff. */
$(document).ready(function () {

  makeTooltips();

  bindLanguageSelectionEvents();

  bindMoreHideButtonEvents();

  bindStaticMenuClickEvents();

  bindAjaxClickEvents();

  roundCorners();

  /* Always send the authenticity_token with ajax */
  $(document).ajaxSend(function(event, request, settings) {
    if ( settings.type == 'post' ) {
      settings.data = (settings.data ? settings.data + "&" : "")
      + "authenticity_token=" + encodeURIComponent( AUTH_TOKEN );
    }
  });

  $('#user_session_email').focus();
  
  $('textarea').autogrow();

});

/* TODO optimize splitting of url! */
/* TODO action set checking */
/* Sets the fragment to the controller and action of the anchors href attribute. */
function setActionControllerFragment(href) {
  controller = href.toString().split('/')[4];
  action = href.toString().split('/')[5];
  if (href.toString().split('/')[5]) {
    document.location.hash = '/' + controller + '/' + action;
  } else {
    document.location.hash = '/' + controller;
  }
}

/* TODO: unobtrusive check */
function bindAjaxClickEvents() {
  $(".ajaxLink").live("click", function() {
    setActionControllerFragment(this.href);
    return false;
  });

  $(".ajax").live("click", function() {
    $.getScript(this.href);
    return false
  });

  $(".ajax_delete").live("click", function() {
    $.ajax({
      url:      this.href,
      type:     'post',
      dataType: 'script',
      data:   { '_method': 'delete' }
    });
    return false;
  });

}

/* If JS is enabled hijack staticMenuButtons to do AJAX requests. */
function bindStaticMenuClickEvents() {
  $(".staticMenuButton").live("click", function() {
    setActionControllerFragment(this.href);
    return false;
  });

  $(".outerMenuItem").live("click", function() {
    $.getScript(this.href);
    return false;
  });

  $(".prevNextButton").live("click", function() {
    setActionControllerFragment(this.href);
    return false;
  });

  $(".illustrationHolder a").live("click", function() {
    setActionControllerFragment(this.href);
    return false;
  });
}


/* Toggle more text on click, use toggleParams. */
/* IE7 compatibility through IE8.js plugin. */
function bindMoreHideButtonEvents() {
  $('.moreButton').click(function() {
    $(this).next().animate(toggleParams, 300);
    $(this).hide();
    $(this).prev().show();
  });

  $('.hideButton').click(function() {
    $(this).next().next().animate(toggleParams, 300);
    $(this).hide();
    $(this).next().show();
  });
}

/* Show and hide language selection on mouse enter and mouse leave. */
function bindLanguageSelectionEvents() {
  $('#echo_language_button').bind("mouseenter", function() {
    var pos = $("#echo_language_button").position();
    $("#language_selector").css( { "left": (pos.left + 13) + "px", "top": (pos.top + 20) + "px" } );
    $('#language_selector').show();
  });

  $('#language_selector').bind("mouseleave", function() {
    $('#language_selector').hide();
  });
}

/* Remove all activeMenu classes and give it to the static menu item specified
 * through the given parameter. */
function changeMenuImage(item) {
  $('#staticMenu .menuImage').removeClass('activeMenu');
  $('#staticMenu #'+item+' .menuImage').toggleClass('activeMenu');
}

/* Use this parameters to render toggle effects.
 * Checks if browser uses opacity. */
var toggleParams;
if (jQuery.support.opacity) {
  toggleParams = {
    'height' : 'toggle',
    'opacity': 'toggle'
  };
} else {
  toggleParams = {
    'height' : 'toggle'
  };
}

/* Lightweight tooltip plugin initialization to create fancy tooltips
 * all over our site.
 * Options and documentation:
 *   http://bassistance.de/jquery-plugins/jquery-plugin-tooltip */
function makeTooltips() {
  $(".ttLink[title]").tooltip({
    track:  true
  });
}


/* Add rounded corners to all div elements with class "roundedBox" */
var roundCorners = function(){
 var str = '<b class="cn tl"></b><b class="cn tr"></b><b class="cn bl"></b><b class="cn br"></b><b class="lr l"></b><b class="lr r"></b><b class="tb b"></b><b class="tb t"></b>';
  $('.roundedBox').addClass("boxc").append(str);
};


/* Show error or info messages in messagesContainer and hide it with delay. */
function info(text) {
  $('#infoBox').stop().hide();
  $('#errorBox').stop().hide();
  $('#messageContainer #infoBox .message').html(text);
  $('#messageContainer #infoBox').slideDown().animate({opacity: 1.0}, 5000 + text.length*50).slideUp();
}

function error(text) {
  $('#infoBox').stop().hide();
  $('#errorBox').stop().hide();
  $('#messageContainer #errorBox .message').html(text);
  $('#messageContainer #errorBox').slideDown().animate({opacity: 1.0}, 5000 + text.length*50).slideUp();
}
