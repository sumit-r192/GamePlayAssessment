class CreateGamePlays < ActiveRecord::Migration[6.0]
  def change
    create_table :game_plays do |t|

      t.integer :tick
      t.string :image_url
      t.timestamps
    end
  end
end
