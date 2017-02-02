class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.integer :year
      t.text :materials
      t.decimal :width, precision: 3, scale: 2
      t.decimal :height, precision: 3, scale: 2
      t.decimal :price, precision: 5, scale: 2
      t.string :img_loc
      t.string :img_sml_loc

      t.timestamps null: false
    end
  end
end
