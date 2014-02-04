class ReturnMistakenlyRemovedColumn < ActiveRecord::Migration
  def change
  	add_column :userarchives, :archives_id, :integer
  end
end
