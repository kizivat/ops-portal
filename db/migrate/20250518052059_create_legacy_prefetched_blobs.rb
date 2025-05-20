class CreateLegacyPrefetchedBlobs < ActiveRecord::Migration[8.0]
  def change
    create_table :legacy_prefetched_blobs do |t|
      t.string :url, null: false

      t.timestamps
    end

    add_index :legacy_prefetched_blobs, :url, unique: true
  end
end
