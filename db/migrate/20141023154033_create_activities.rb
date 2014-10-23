class CreateActivities < ActiveRecord::Migration
	def change
		create_table :activities do |t|

			t.timestamps

			t.integer :user_id
			t.integer :deal_id
			t.string :type
			t.boolean :done
			t.string :note
			t.datetime :due_time

		end
	end
end