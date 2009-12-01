class EchoDetail < ActiveRecord::Base
  belongs_to :echo
  belongs_to :user
  belongs_to :statement, :foreign_key => 'echo_id', :primary_key => 'echo_id'
  
  named_scope :visited, lambda { { :conditions => { :visited => true } } }
  named_scope :supported, lambda { { :conditions => { :supported => true } } }
  
  named_scope :for_user, lambda { |user_id| { :conditions => { :user_id => user_id } } }
  
  class << self
    # Finds the EchoDetail based on the given :echo in the options hash and
    # updates it's attributes with the remaining options.
    # If the EchoDetail doesn't exist yet, it is created instead.
    def create_or_update!(options)
      (ed = find(:first, :conditions => { :echo_id => options[:echo].id })) ? ed.update_attributes!(options) :
        ed = create!(options) ; ed
    end
  end
end
