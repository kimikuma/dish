class CreateUserRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :user_rooms do |t|
      t.references :user
      t.references :room

      t.timestamps
    end
  end
end
