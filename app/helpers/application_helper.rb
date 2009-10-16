# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Acl9Helpers

  # If user is an admin the admin options should be shown.
  access_control :show_admin_options? do
    allow :admin
  end

  # Get formatted error string from error partial for a given object, then show
  # it on the page object as an error message.
  def show_javascript_errors(object, page)
    message = render :partial => 'layouts/components/error', :locals => {:object => object}
    page << "error('#{escape_javascript(message)}');"
  end

end