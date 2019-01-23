class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :type1
      t.string :type2
      t.integer :hitpoints
      t.integer :attack
      t.integer :defense
      t.integer :speed
      t.boolean :legendary
      t.string :img

      t.timestamps
    end
  end
end
