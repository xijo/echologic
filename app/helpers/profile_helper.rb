module ProfileHelper
  def profile_complete
    "("+I18n.t("layouts.my_echo.profile_complete", :complete => current_user.profile.percent_completed || 0)+")"
  end
end
