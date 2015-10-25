class AnotherPgMigr < ActiveRecord::Migration
  def change
    remove_column :archyves, :callers
    remove_column :archyves, :payers
    remove_column :archyves, :gcs
    add_column :archyves, :callers,:text, array: true, default: []
    add_column :archyves, :payers, :text, array: true, default: []
    add_column :archyves, :gcs,    :text, array: true, default: []
  end
end
