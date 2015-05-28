class ArrayListOfCallerPayerGc < ActiveRecord::Migration
  def change
    add_column :archyves, :callers,:string, array: true, default: []
    add_column :archyves, :payers, :string, array: true, default: []
    add_column :archyves, :gcs,    :string, array: true, default: []
  end
end
