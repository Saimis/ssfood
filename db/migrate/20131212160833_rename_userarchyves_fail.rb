class RenameUserarchyvesFail < ActiveRecord::Migration
  def change
  	rename_table :uaserarchyves, :userarchyves
  end
end
