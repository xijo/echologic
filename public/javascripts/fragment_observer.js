// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* Do init stuff. */
$(document).ready(function () {

  startFragmentObservation()
 
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

