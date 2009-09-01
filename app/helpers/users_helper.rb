module UsersHelper
  include Acl9Helpers

  access_control :show_admin_options? do
    allow :admin
  end
end
