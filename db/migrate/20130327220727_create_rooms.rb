class CreateRooms < ActiveRecord::Migration
 def change
    create_table :rooms do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end
