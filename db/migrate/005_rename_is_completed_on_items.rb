class RenameIsCompletedOnItems < ActiveRecord::Migration
	def up
		change_table :items do |t|
			t.rename :is_completed?, :is_completed
		end
	end
	def down
		change_table :items do |t|
			t.rename :is_compelted, :is_completed?
		end
	end
end
