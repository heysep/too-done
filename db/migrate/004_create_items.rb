class CreateItems < ActiveRecord::Migration
	def up
		create_table :items do |t|
			t.belongs_to :list
			t.integer :list_id, null: false
			t.string :task, null: false
			t.datetime :due_date
			t.boolean :is_completed?
			t.timestamps null: false
		end
	end

	def down
		drop_table :items
	end
end
