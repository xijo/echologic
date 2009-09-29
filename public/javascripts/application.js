// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* Do init stuff. */
$(document).ready(function () {

  makeQTips();

  bindLanguageSelectionEvents();

  bindMoreHideButtonEvents();

  bindStaticMenuClickEvents();

//  bindAjaxClickEvents();

  startFragmentObservation();

  roundCorners();

});

// TODO robustness: if no script can be found make http request.
function startFragmentObservation() {
  /* Turn on fragment observation through jQuery plugin. */
  $.fragmentChange(true);

  /* Do AJAX call on fragment change events for goto. */
  $(document).bind("fragmentChange", function() {
    if (getActionFromHash()) {
      $.getScript(getControllerFromHash()+'/'+getActionFromHash());
    } else {
      $.getScript(getControllerFromHash());
    }
  });

  /* If fragment is present on document load trigger fragmentChange event. */
  if ($.fragment()) {
    $(document).trigger("fragmentChange");
  }
}

/* splits the hash of a location and returns the name of the controller */
function getControllerFromHash() {
  return document.location.hash.split('/')[1];
}

function getActionFromHash() {
  return document.location.hash.split('/')[2];
}


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
}

/* If JS is enabled hijack staticMenuButtons to do AJAX requests. */
function bindStaticMenuClickEvents() {
  $(".staticMenuButton").live("click", function() {
    setActionControllerFragment(this.href);
    return false;
  });

  $(".outerMenuItem").live("click", function() {
//    setActionControllerFragment(this.href);
    $.getScript(this.href);
    return false;
  });

  $(".ajaxTab").live("click", function() {
    setActionControllerFragment(this.href);
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
  $('#languageChooser').bind("mouseenter", function() {
    $('#languageSelector').show();
  });

  $('#languageSelector').bind("mouseleave", function() {
    $('#languageSelector').hide();
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

/* Defines the qTip style for the static content tooltips and attaches it
 * to all instances of the ttLink class. */
function makeQTips() {

  $.fn.qtip.styles.echo_tooltip = {
    width: {
      max: 450
    },
    background: '#7AB030',
    'font-size': 12,
    color: 'white',
    textAlign: 'left',
    border: {
      width: 1,
      radius: 8,
      color: '#7AB030'
    },
    tip: 'topLeft',
    name: 'dark' // Inherit attributes from dark style
  }
    
  $(".ttLink").qtip({
    position: {
      target: 'mouse',
      corner: {
        target: 'bottomMiddle'
      },
      adjust: {
        x: 12,
        y:10
      }
    },
    style: 'echo_tooltip',
    show: {
      effect: {
        type: 'fade',
        length: 0
      }
    }
  });
}


/* Add rounded corners to all div elements with class "roundedBox" */
var roundCorners = function(){
 var str = '<b class="cn tl"></b><b class="cn tr"></b><b class="cn bl"></b><b class="cn br"></b><b class="lr l"></b><b class="lr r"></b><b class="tb b"></b><b class="tb t"></b>';
  $('.roundedBox').addClass("boxc").append(str);
};