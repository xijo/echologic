class WebProfile < ActiveRecord::Base

  belongs_to :user

  include ProfileUpdater
  
  validates_presence_of :sort, :location, :user_id

  # Map the different sorts of web profiles to their database representation
  # value, translate them ..
  @@sorts = {
    0 => I18n.t('users.web_profiles.sorts.email'),
    1 => I18n.t('users.web_profiles.sorts.homepage'),
    2 => I18n.t('users.web_profiles.sorts.blog'),
    3 => I18n.t('users.web_profiles.sorts.xing'),
    4 => I18n.t('users.web_profiles.sorts.linkedin'),
    5 => I18n.t('users.web_profiles.sorts.facebook'),
    6 => I18n.t('users.web_profiles.sorts.twitter'),
    99 => I18n.t('users.web_profiles.sorts.other')
  }

  # ..and make it available as class method.
  def self.sorts
    @@sorts
  end

  # Validate that sort is correct
  validates_inclusion_of :sort, :in => WebProfile.sorts

  # Validate if location has valid format
  validates_format_of :location, :with => /^((www\.|http:\/\/)([a-z\-0-9]*\.)+([a-z]{2,4}){1}(\/[a-z0-9]+)*(\.[a-z0-9]{1,4})?)|(([a-z0-9)+[a-z0-9\.\_-]*)@[a-z0-9]{1,}[a-z0-9-\.]*\.[a-z]{2,4})$/i

end
