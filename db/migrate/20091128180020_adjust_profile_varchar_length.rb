class AdjustProfileVarcharLength < ActiveRecord::Migration
  def self.up
    change_column :profiles, :about_me, :text
    change_column :profiles, :motivation, :text
  end

  def self.down
    change_column :profiles, :about_me, :string
    change_column :profiles, :motivation, :string
  end
end
