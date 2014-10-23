class AddFieldsToDeals < ActiveRecord::Migration
	def change
		add_column :deals, :value, :decimal
		add_column :deals, :currency, :string
		add_column :deals, :status, :string
		add_column :deals, :won_time, :datetime
		add_column :deals, :user_id, :integer
		add_column :deals, :add_time, :datetime
		add_column :deals, :update_time, :datetime
	end
end
