class DefaultEchoDetailsFlagsToFalse < ActiveRecord::Migration
  def self.up
    change_column :echo_details, :visited, :boolean, :default => false
    change_column :echo_details, :supported, :boolean, :default => false
  end

  def self.down
    # we will never need to bring this down.
  end
end
