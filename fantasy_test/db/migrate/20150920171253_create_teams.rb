class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :code, null: false
      t.string :full_name, null: false

      t.timestamps null: false
    end

    add_index :teams, :code, unique: true
  end
end
