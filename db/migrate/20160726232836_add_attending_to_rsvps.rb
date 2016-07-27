class AddAttendingToRsvps < ActiveRecord::Migration[5.0]
  def change
    add_column :rsvps, :attending, :boolean
  end
end
