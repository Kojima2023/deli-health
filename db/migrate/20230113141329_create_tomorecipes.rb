class CreateTomorecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :tomorecipes do |t|
      t.string :title
      t.text :ingredient
      t.text :recipe
      t.text :point
      t.string :cost
      t.string :time
      t.integer :user_id
      t.string :image
      t.string :image2
      t.string :image3
      t.string :image4
      t.string :video
      t.string :category

      t.timestamps
    end
  end
end
