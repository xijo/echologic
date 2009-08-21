// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults




$(document).ready(function () {

    makeQTips();

    bindLanguageSelectionEvents();

    bindMoreHideButtonEvents();

});

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

function bindLanguageSelectionEvents() {
    $('#languageChooser').bind("mouseenter", function() {
        $('#languageSelector').show();
    });

    $('#languageSelector').bind("mouseleave", function() {
        $('#languageSelector').hide();
    });
}

function changeMenuImage(item) {
    $('#staticMenu .menuImage').removeClass('activeMenu');
    $('#staticMenu #'+item+'MenuImage .menuImage').toggleClass('activeMenu');
}


var toggleParams;
if (jQuery.support.opacity) {
    toggleParams = { 'height' : 'toggle', 'opacity': 'toggle' };
} else {
    toggleParams = { 'height' : 'toggle' };
}

/*
 * Defines the qTip style for the static content tooltips, named echo_tooltip.
 */
function makeQTips() {

    $.fn.qtip.styles.echo_tooltip = {
       width: { max: 450 }, background: '#7AB030',
       color: 'white', textAlign: 'left',
       border: { width: 1, radius: 8, color: '#7AB030' },
       tip: 'topLeft', name: 'dark' // Inherit attributes from dark style
    }
    
    $(".ttLink").qtip({
        position: { target: 'mouse', corner: { target: 'bottomMiddle' } },
        style: 'echo_tooltip',
        show: { effect: { type: 'fade', length: 0 } }
    });
}

//jQuery.fn.fadeThenSlideToggle = function(speed, easing, callback) {
//  if (this.is(":hidden")) {
//    return this.slideDown(speed, easing).fadeTo(speed, 1, easing, callback);
//  } else {
//    return this.fadeTo(speed, 0, easing).slideUp(speed, easing, callback);
//  }
//};

//    $("p").click(function () {
//      $(this).slideUp();
//    });
//    $("p").hover(function () {
//      $(this).addClass("hilite");
//    }, function () {
//      $(this).removeClass("hilite");
//    });



jQuery.fn.moreButtonEvents() = function() {
    
}

function bindMoreButtonEvents() {
    
}


//$(this).hide();Effect.Appear($(this).previous(0), {duration:0.3});Effect.Appear($(this).next(0), {duration:0.4});Effect.BlindDown($(this).next(0), {duration:0.3});