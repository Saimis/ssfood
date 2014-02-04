class RenameTablesToProperEnglish < ActiveRecord::Migration
  def change
  	remove_column :userarchyves, :archyves_id, :archives_id
  	rename_table :userarchyves, :userarchives
  	rename_table :archyves, :archives
  end
end
