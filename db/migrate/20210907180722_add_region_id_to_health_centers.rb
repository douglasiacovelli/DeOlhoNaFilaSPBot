class AddRegionIdToHealthCenters < ActiveRecord::Migration[6.1]
  def change
    add_column :health_centers, :region_id, :integer
  end
end
