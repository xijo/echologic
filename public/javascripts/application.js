// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* Do init stuff. */
$(document).ready(function () {

    makeQTips();

    bindLanguageSelectionEvents();

    bindMoreHideButtonEvents();

});

/* Toggle more text on click, use toggleParams. */
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
    $('#staticMenu #'+item+'MenuImage .menuImage').toggleClass('activeMenu');
}

/* Use this parameters to render toggle effects.
 * Checks if browser uses opacity. */
var toggleParams;
if (jQuery.support.opacity) {
    toggleParams = { 'height' : 'toggle', 'opacity': 'toggle' };
} else {
    toggleParams = { 'height' : 'toggle' };
}

/* Defines the qTip style for the static content tooltips and attaches it
 * to all instances of the ttLink class. */
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
