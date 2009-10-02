/**
 * @author Joe
 *
 * Template for inserting an error message if concernment tag couldn't be
 * saved. Normally the tag already exists.
 */

$('#concernment_failure_<%= params[:sort] %>').html('Tag already exists.').fadeIn(2000);