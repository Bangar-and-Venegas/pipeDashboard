class FixFieldsInActivitiesAndDeals < ActiveRecord::Migration
	def change
		remove_column :deals, :created_at
		remove_column :deals, :updated_at
  	rename_column :activities, :created_at, :add_time
  	rename_column :activities, :updated_at, :update_time
	end
end
