class CreateLists < ActiveRecord::Migration
	def up
		create_table :lists do |t|
			t.belongs_to :user
			t.integer :user_id, null: false
			t.string :name, null: false
			t.timestamps null: false
		end
	end

	def down
		drop_table :lists
	end
end
