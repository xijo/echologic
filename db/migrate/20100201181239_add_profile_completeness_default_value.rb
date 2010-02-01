class AddProfileCompletenessDefaultValue < ActiveRecord::Migration
  def self.up
    change_column :profiles, :completeness, :float, :defaul => 0.1
  end

  def self.down
    change_column :profiles, :completeness, :string
  end
end
