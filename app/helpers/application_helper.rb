# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Acl9Helpers

  access_control :show_admin_options? do
    allow :admin
  end

# TODO remove google analytics completly as soon as possible.
  
#  @google_analytics_tracker_code = nil
#
#  # Returns the Google Analytics Tracker Code to be inserted just before the </body> tag.
#  def insert_google_analytics_tracker_code
#    if !@google_analytics_tracker_code
#      @google_analytics_tracker_code = build_google_analytics_tracker_code
#    end
#    @google_analytics_tracker_code
#  end
#
#  private
#
#  # Builds the Google Analytics Tracker Code and stores it in a class variable.
#  def build_google_analytics_tracker_code
#    tracker = "<script type=\"text/javascript\">"
#    tracker += "var gaJsHost = ((\"https:\" == document.location.protocol) ? \"https://ssl.\" : \"http://www.\");"
#    tracker +=  "document.write(unescape(\"%3Cscript src='\" + gaJsHost + \"google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E\"));"
#    tracker +=  "</script>"
#    tracker +=  "<script type=\"text/javascript\">"
#    tracker +=  "try{"
#    tracker +=  "var pageTracker = _gat._getTracker(\"UA-10224442-1\");"
#    tracker +=  "pageTracker._trackPageview();"
#    tracker +=  "} catch(err) {}"
#    tracker +=  "</script>"
#  end

end