/**
 * Template to change static menu, tabs and static content via JS.
 */

/* Write render output into JS variables for later use. */
var content = "<%= escape_javascript(render(:partial => request[:action])) %>";
var title   = "<%= request[:action] %>".replace('_', ' ');

$('#dialogContent').html(content);

$('#dialogContent').dialog({
  bgiframe: true,
  modal:    true,
  buttons:  { Ok: function() { $(this).dialog('close'); }},
  close:    function(event, ui) { $(this).dialog('destroy'); },
  width:    650,
  title:    title
});



