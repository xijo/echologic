class WebProfile < ActiveRecord::Base

  belongs_to :user

  # TODO localize web profile sorts
  def self.sorts
    sorts = Array.new
    sorts << ['Homepage', 'homepage']
    sorts << ['Blog', 'blog']
    sorts << ['Twitter', 'twitter']
    sorts << ['Xing', 'xing']
  end

  def self.sorts2
    [
      I18n.t('users.web_profiles.sorts.homepage'),
      I18n.t('users.web_profiles.sorts.blog'),
      I18n.t('users.web_profiles.sorts.twitter'),
      I18n.t('users.web_profiles.sorts.xing')
    ]

  end

end
