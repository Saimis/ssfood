class AddEndedFieldToSession < ActiveRecord::Migration
  def change
    add_column :archyves, :complete, :integer, false
  end
end
