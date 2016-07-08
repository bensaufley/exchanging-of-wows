class CreateRsvps < ActiveRecord::Migration[5.0]
  def change
    create_table :rsvps do |t|
      t.string :first_name
      t.string :last_name
      t.integer :guests
      t.string :ip

      t.timestamps
    end
  end
end
