class CreateStatementDocuments < ActiveRecord::Migration
  def self.up
    remove_column :statements, :title
    remove_column :statements, :text
    add_column :statements, :document_id, :integer
    create_table :statement_documents do |t|
      t.string :title
      t.text :text
    end
  end

  def self.down
    add_column :statements, :title, :string
    add_column :statements, :text, :text
    remove_column :statements, :document_id
    drop_table :statement_documents
  end
end
