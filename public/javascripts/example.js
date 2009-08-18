/**
 * @author xijo
 */

Event.addBehavior({
  'body' : function() {
    $('newsContainer').hide();
  },
  '#headerMessage:click' : function() {
    $('newsContainer').toggle();
    return false;
  },
  '.staticMenuButton:mouseover' : function() {
    var i = 1;
    $('newsContainer').toggle();
    $('newsContainer').update(window._token);

    new Ajax.Request('echo',
      { asynchronous:true, evalScripts:true,
        parameters: {
          authenticity_token: window._token
        }
      });

    return false;
  }

});