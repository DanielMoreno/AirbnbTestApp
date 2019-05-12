class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      ## Foriegn Key
      t.references :user, foreign_key: true

      ## Base Information
      t.string  :home_type
      t.string  :room_type
      t.integer :accommodates
      t.string  :city

      ## Pricing
      t.integer :price

      ## Overview Information
      t.string  :title
      t.string  :summary

      ## Amenities
      t.boolean :has_kitchen
      t.boolean :has_shampoo
      t.boolean :has_heating
      t.boolean :has_air_conditioning
      t.boolean :has_washer
      t.boolean :has_dryer
      t.boolean :has_wifi
      t.boolean :has_breakfast
      t.boolean :has_indoor_fireplace
      t.boolean :has_hangers
      t.boolean :has_iron
      t.boolean :has_hair_dryer
      t.boolean :has_laptop_workspace
      t.boolean :has_tv
      t.boolean :has_crib
      t.boolean :has_high_chair
      t.boolean :has_self_check_in
      t.boolean :has_smoke_detector
      t.boolean :has_carbon_monoxide_detector
      t.boolean :has_private_bathroom

      ## Listing Information
      t.integer :bedrooms
      t.integer :beds
      t.integer :bathrooms
      
      ## Location Information
      t.string  :address
      t.float   :longitude 
      t.float   :latitude

      ## Functional data
      t.boolean   :is_active
      t.boolean   :is_published
      t.boolean   :contract_agreement
      t.timestamps
    end
  end
end

