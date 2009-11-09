# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Acl9::Helpers

  # If user is an admin the admin options should be shown.
  access_control :show_admin_options? do
    allow :admin
  end

  # Return a progressbar
  def insert_progressbar(percent)
    val =  "<div id='progressbar' class='ttLink' title='#{percent}%'></div>"
    val += "<script type='text/javascript'>$('#progressbar').progressbar({value: #{percent}});</script>"
    val
  end

end
