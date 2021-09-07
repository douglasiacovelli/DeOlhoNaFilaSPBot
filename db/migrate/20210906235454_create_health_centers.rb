class CreateHealthCenters < ActiveRecord::Migration[6.1]
  def change
    create_table :health_centers do |t|
      t.string :name
      t.string :address
      t.string :region
      t.string :district
      t.datetime :last_updated_at
      t.string :queue_size
      t.boolean :has_coronavac
      t.boolean :has_pfizer
      t.boolean :has_astrazeneca

      t.timestamps
    end
  end
end
