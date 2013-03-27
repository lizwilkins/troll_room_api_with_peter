class CreateMessages < ActiveRecord::Migration
 def change
    create_table :messages do |t|
      t.column :name, :string
      t.column :message, :string

      t.timestamps
    end
  end
end
