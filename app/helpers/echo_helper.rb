module EchoHelper
  def echo_button(statement)
    url_options = { :controller => statement.class.name.underscore.pluralize, :id => statement.id }
    unless current_user.supported?(statement)
      link_to_remote '<div>&nbsp;</div>', { :url => url_options.merge(:action => 'echo'), :method => :put}
    else
      link_to_remote '<div>&nbsp;</div>', { :url => url_options.merge(:action => 'unecho'), :method => :delete, :html => {:class => 'active'} }
    end
  end
end
