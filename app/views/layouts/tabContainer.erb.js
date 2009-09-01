/**
 * @author Joe
 *
 * Template to change static menu, tabs and static content via JS.
 */

/* Write render output into JS variables for later use. */
var tabs = "<%= escape_javascript(render(:partial => 'tabs')) %>";
var content = "<%= escape_javascript(render(:partial => request[:action])) %>";
var item = "<%= escape_javascript(request[:controller].split('/')[1]) %>";

/* Replace content of tab container with render output */
$('#tabContainer').html(tabs);

/* If tab container isn't visible, toggle it and hide echologic container.
 * For parameter details see toggleParams in application.js */
$('#tabContainer:hidden').animate(toggleParams, 500,
    function() { $('#echologicContainer').animate(toggleParams, 500); });

/* Replace content with new rendered content. */
$('#staticContent').hide();
$('#staticContent').html(content);
$('#staticContent').appear(400);

/* Change css class through javascript for setting state of staticMenu. */
changeMenuImage(''+item);

/* Render tooltips. */
makeQTips();

/* Bind click event handlers for more and hide buttons. */
bindMoreHideButtonEvents();
