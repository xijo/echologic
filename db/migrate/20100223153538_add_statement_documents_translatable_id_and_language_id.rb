class AddStatementDocumentsTranslatableIdAndLanguageId < ActiveRecord::Migration
  def self.up
    remove_column :statements, :document_id
    add_column :statement_documents, :statement_id, :integer
    add_column :statement_documents, :translated_statement_id, :integer
    add_column :statement_documents, :language_id, :string
  end

  def self.down
    add_column :statements, :document_id, :integer
    remove_column :statement_documents, :statement_id
    remove_column :statement_documents, :language_id
    remove_column :statement_documents, :translated_statement_id
  end
end
