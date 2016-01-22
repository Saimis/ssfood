class RenameRestaurantsAboutColumnToWebsite < ActiveRecord::Migration
  def up
    rename_column :restaurants, :about, :website
  end

  def down
    rename_column :restaurants, :website, :about
  end
end
