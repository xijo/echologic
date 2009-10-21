/**
 * Template to view the upload picture modal dialog.
 */

/* Write render output into JS variables for later use. */
var content = "<%= escape_javascript(render(:partial => 'users/profile/upload_picture')) %>";

$('#dialogContent').html(content);

$('#dialogContent').dialog({
  bgiframe: true,
  modal:    true,
  buttons:  { 
    Close: function() { $(this).dialog('close'); },
    Send: function() { $('#upload_picture_form').submit(); }
     },
  close:    function(event, ui) { $(this).dialog('destroy'); },
  width:    650,
  title:    'Upload picture'
});

