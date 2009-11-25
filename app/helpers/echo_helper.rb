module EchoHelper

  def echo_button(statement)
    url_options = { :controller => statement.class.name.underscore.pluralize, :id => statement.id }
    unless current_user.supported?(statement)
      icon = image_tag("page/discuss/echo.png")
      link_to_remote icon, { :url => url_options.merge(:action => 'echo'), :method => :put}, :id => 'echo_button'
    else
      icon = image_tag("page/discuss/unecho.png")
      link_to_remote icon, { :url => url_options.merge(:action => 'unecho'), :method => :delete }, :id => 'echo_button'
    end
  end

end
