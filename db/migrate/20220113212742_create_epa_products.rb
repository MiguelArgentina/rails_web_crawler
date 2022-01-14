class CreateEpaProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :epa_products do |t|
      t.string :epa_code
      t.string :price
      t.json :product_info, default: {}

      t.timestamps
    end
  end
end
