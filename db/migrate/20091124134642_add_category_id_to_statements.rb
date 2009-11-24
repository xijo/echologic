class AddCategoryIdToStatements < ActiveRecord::Migration
  def self.up
    add_column :statements, :category_id, :integer
  end

  def self.down
    remove_column :statements, :category_id
  end
end
