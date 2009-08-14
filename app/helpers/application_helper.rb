# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  @google_analytics_tracker_code = nil
  
  # Returns the Google Analytics Tracker Code to be inserted just before the </body> tag.
  def insert_google_analytics_tracker_code
    if !@google_analytics_tracker_code 
      @google_analytics_tracker_code = build_google_analytics_tracker_code
    end
    @google_analytics_tracker_code
  end
  
  private
  
  # Builds the Google Analytics Tracker Code and stores it in a class variable.
  def build_google_analytics_tracker_code
    @google_analytics_tracker_code = "<script type=\"text/javascript\">"
    @google_analytics_tracker_code += "var gaJsHost = ((\"https:\" == document.location.protocol) ? \"https://ssl.\" : \"http://www.\");"
    @google_analytics_tracker_code +=  "document.write(unescape(\"%3Cscript src='\" + gaJsHost + \"google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E\"));"
    @google_analytics_tracker_code +=  "</script>"
    @google_analytics_tracker_code +=  "<script type=\"text/javascript\">"
    @google_analytics_tracker_code +=  "try{"
    @google_analytics_tracker_code +=  "var pageTracker = _gat._getTracker(\"UA-10224442-1\");"
    @google_analytics_tracker_code +=  "pageTracker._trackPageview();"
    @google_analytics_tracker_code +=  "} catch(err) {}"
    @google_analytics_tracker_code +=  "</script>"
  end

end