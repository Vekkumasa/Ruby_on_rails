class CreateStyles < ActiveRecord::Migration[7.0]
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.integer :beer_id
      t.timestamps
    end
  end
end
