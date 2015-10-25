class AddPayerAndGarbageCollectors < ActiveRecord::Migration
  def change
    add_column :archyves, :payer, :integer,  default: nil
    add_column :archyves, :gc,    :integer,  default: nil
  end
end
