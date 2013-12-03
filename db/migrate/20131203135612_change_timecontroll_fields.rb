class ChangeTimecontrollFields < ActiveRecord::Migration
  def change
    remove_column :timecontrolls, :start
    remove_column :timecontrolls, :end
    remove_column :timecontrolls, :gap
    add_column :timecontrolls, :timebarrier, :datetime
  end
end
