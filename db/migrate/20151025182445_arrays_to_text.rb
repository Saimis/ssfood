class ArraysToText < ActiveRecord::Migration
  def change
    remove_column :archyves, :callers
    remove_column :archyves, :payers
    remove_column :archyves, :gcs
    add_column :archyves, :callers,:text, default: "--- []\n"
    add_column :archyves, :payers, :text, default: "--- []\n"
    add_column :archyves, :gcs,    :text, default: "--- []\n"
  end
end
