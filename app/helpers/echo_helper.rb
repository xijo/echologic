module EchoHelper

  def echo_button(statement)
    url_options = { :controller => statement.class.name.underscore.pluralize, :id => statement.id }
    unless current_user.supported?(statement)
      link_to_remote "Echo", { :url => url_options.merge(:action => 'echo'), :method => :put}, :id => 'echo_button'
    else
      link_to_remote "UnEcho", { :url => url_options.merge(:action => 'unecho'), :method => :delete }, :id => 'echo_button'
    end
  end

end
