class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.string :sex, null: false, limit: 1
      t.string :color
      t.date :birth_date
      t.text :description

      t.timestamps
    end
  end
end
