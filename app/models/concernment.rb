class Concernment < ActiveRecord::Base

  # module to update the profile (e.g. completeness) after_save, after_destroy
  include ProfileUpdater
  
  # Join table implementation, connect users and tags
  belongs_to :user
  belongs_to :tag

  # Validate uniqueness
  validates_uniqueness_of :tag_id, :scope => [:user_id, :sort]
  validates_presence_of :tag_id, :user_id

  # Named scopes
  named_scope :affected,       :conditions => { :sort => 0 }
  named_scope :engaged,        :conditions => { :sort => 1 }
  named_scope :scientist,      :conditions => { :sort => 2 }
  named_scope :representative, :conditions => { :sort => 3 }

  # Map the different sorts of concernments to their database representation
  # value..
  @@sorts = {
  #  0 => I18n.t('users.concernments.sorts.affected'),
  #  1 => I18n.t('users.concernments.sorts.engaged'),
  #  2 => I18n.t('users.concernments.sorts.scientist'),
  #  3 => I18n.t('users.concernments.sorts.representative')
    0 => :affected,
    1 => :engaged,
    2 => :scientist,
    3 => :representative
  }

  # ..and make it available as class method.
  def self.sorts
    @@sorts
  end

  # Validate correctness of sort
  validates_inclusion_of :sort, :in => Concernment.sorts

end
