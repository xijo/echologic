class Concernment < ActiveRecord::Base

  # Join table implementation, connect users and tags
  belongs_to :user
  belongs_to :tag

  # Map the different sorts of concernments to their database representation
  # value.
  def sorts
    [
      [0, 'Affected'],
      [1, 'Engaged'],
      [2, 'Scientist/Expert'],
      [3, 'Representative']
    ]
  end

end
