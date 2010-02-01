module ProfileHelper
  # Inserts a support ratio bar with the ratio value in its alt-attribute.
  def profile_completeness_bar(completeness,context=nil)
    tooltip = I18n.t('profile.completeness_tooltip', :completeness => completeness)
    val = "<span id='profile_completeness_bar' class='ttLink' title='#{tooltip}' alt='#{completeness}'></span>"
    val += "<script type='text/javascript'>$('#profile_completeness_bar').progressbar({value: #{completeness*100}});</script>"
    val
  end
end
