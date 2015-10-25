class ChangeDefaultToNewColumns < ActiveRecord::Migration
  def change
    change_column :archyves, :callers,:text, default: nil
    change_column :archyves, :payers, :text, default: nil
    change_column :archyves, :gcs,    :text, default: nil
  end
end
