class UnifyNames < ActiveRecord::Migration[5.0]
  def up
    add_column :rsvps, :names, :string
    Rsvp.connection.execute('UPDATE rsvps SET names=first_name || \' \' || last_name')
    remove_column :rsvps, :first_name
    remove_column :rsvps, :last_name
    remove_column :rsvps, :plus_one
  end

  def down
    add_column :rsvps, :first_name, :string
    add_column :rsvps, :last_name, :string
    add_column :rsvps, :plus_one, :boolean
    Rsvp.connection.execute('UPDATE rsvps SET first_name=split_part(names, \' \', 1), last_name=split_part(names, \' \', 2)')
    remove_column :rsvps, :names
  end
end
