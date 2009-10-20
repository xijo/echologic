# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Acl9Helpers

  # If user is an admin the admin options should be shown.
  access_control :show_admin_options? do
    allow :admin
  end

end
