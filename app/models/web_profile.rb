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

end
