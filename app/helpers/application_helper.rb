# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Acl9Helpers

  access_control :show_admin_options? do
    allow :admin
  end

end