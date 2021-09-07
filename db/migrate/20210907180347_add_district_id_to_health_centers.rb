class AddDistrictIdToHealthCenters < ActiveRecord::Migration[6.1]
  def change
    add_column :health_centers, :district_id, :integer
  end
end
