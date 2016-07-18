class CreateSongRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :song_requests do |t|
      t.string :name
      t.string :artist
      t.string :album
      t.json :info
      t.string :ip

      t.timestamps
    end
  end
end
