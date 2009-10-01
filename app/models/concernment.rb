class Concernment < ActiveRecord::Base

  # Join table implementation, connect users and tags
  belongs_to :user
  belongs_to :tag

  # Validate uniqueness
  validates_uniqueness_of :tag_id, :scope => [:user_id, :sort]

  # Map the different sorts of concernments to their database representation
  # value.
  def self.sorts
    [
      [0, 'Affected'],
      [1, 'Engaged'],
      [2, 'Scientist/Expert'],
      [3, 'Representative']
    ]
  end

end
