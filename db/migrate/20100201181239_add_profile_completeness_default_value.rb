class AddProfileCompletenessDefaultValue < ActiveRecord::Migration
  def self.up
    change_column :profiles, :completeness, :float, :default => 0.01
  end

  def self.down
    change_column :profiles, :completeness, :string
  end
end
