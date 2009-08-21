/**
 * @author Joe
 *
 * Template to change static menu, tabs and static content via JS.
 */

/* Set local template parameters to ruby variables. */
"<% menu_item = local_assigns[:menu_item] %>"
"<% submenu_item = local_assigns.include?(:submenu_item) ? '_'+local_assigns[:submenu_item] : '' %>"

/* Write render output into JS variables for later use. */
var tabs = "<%= escape_javascript(render(:partial => 'tabs_' + menu_item)) %>";
var content = "<%= escape_javascript(render(:partial => menu_item + submenu_item)) %>";
var item = "<%= escape_javascript(menu_item) %>";

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
