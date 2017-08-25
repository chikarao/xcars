class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :make
      t.string :model
      t.integer :year
      t.string :color
      t.integer :seats
      t.string :location
      t.string :trasmission
      t.float :price
      t.string :photo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
