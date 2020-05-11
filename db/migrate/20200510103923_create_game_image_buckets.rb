class CreateGameImageBuckets < ActiveRecord::Migration[6.0]
  def change
    create_table :game_image_buckets do |t|

      t.timestamps
    end
  end
end
