// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* Do init stuff. */
$(document).ready(function () {

  makeQTips();

  bindLanguageSelectionEvents();

  bindMoreHideButtonEvents();

  bindStaticMenuClickEvents();
  bindAjaxClickEvents();

  startFragmentObservation();


});

// TODO robustness: if no script can be found make http request.
function startFragmentObservation() {
  /* Turn on fragment observation through jQuery plugin. */
  $.fragmentChange(true);

  /* Do AJAX call on fragment change events for goto. */
  $(document).bind("fragmentChange", function() {
//    alert(document.location.hash);
//    alert($.fragment().toString);
//    $.getScript($.fragment().go);
    $.getScript(document.location.hash);
    
    if ($.fragment().and) {
      alert($.fragment().and)
    }
    if ($.fragment().go) {
      alert($.fragment().go);
    }
  });

  /* TODO double loading on fragment and changes. */
//  $(document).bind("fragmentChange.and", function() {
//    //$.getScript($.fragment().go+'/'+$.fragment().and);
//    $.getScript($.fragment().and);
//  });

  /* If fragment is present on document load trigger fragmentChange event. */
  if ($.fragment()) {
    $(document).trigger("fragmentChange");
  }
}

/* TODO: unobtrusive check */
function bindAjaxClickEvents() {
  $(".ajaxLink").live("click", function() {
    $.setFragment({ 'go' : this.href });
    return false;
  });
}



/* If JS is enabled hijack staticMenuButtons to do AJAX requests. */
function bindStaticMenuClickEvents() {
  $(".staticMenuButton").live("click", function() {
//    $.setFragment({ 'go' : this.id });
    document.location.hash = this.href.toString().split('/')[4];
    return false;
  });
  $(".outerMenuItem").live("click", function() {
    $.setFragment({ 'go' : 'echologic/'+this.id });
    return false;
  });

  /* TODO optimize splitting of url! */
  $("#tabContainer a").live("click", function() {
    var and = 'index'
    if (this.href.split('/')[5]) {
      and = this.href.split('/')[5];
    }
    $.setFragment({ 'and' : and });
    return false;
  });
  
  $(".prevNextButton").live("click", function() {
    $.setFragment({ 'and' : this.href.split('/')[5] });
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
