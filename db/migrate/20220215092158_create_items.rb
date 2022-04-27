class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      
      t.integer :genre_id
      t.string :name
      t.text :description
      t.string :image_id
      t.boolean :status, default: false
      t.integer :price

      t.timestamps
    end
  end
end
