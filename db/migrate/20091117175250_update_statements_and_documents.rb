class UpdateStatementsAndDocuments < ActiveRecord::Migration
  def self.up
    remove_column :statements, :user_id
    add_column :statements, :creator_id, :integer
    add_column :statements, :work_package_id, :integer
    add_column :statements, :published, :boolean
    add_column :statement_documents, :author_id, :integer
  end

  def self.down
    add_column :statements, :user_id, :integer
    remove_column :statements, :creator_id
    remove_column :statements, :work_package_id
    remove_column :statements, :published
    remove_column :statement_documents, :author_id
  end
end
