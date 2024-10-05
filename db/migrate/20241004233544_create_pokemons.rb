class CreatePokemons < ActiveRecord::Migration[7.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :types
      t.string :image
      t.boolean :captured
      t.datetime :captured_at

      t.timestamps
    end
  end
end
