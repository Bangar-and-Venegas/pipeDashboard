class RenameFieldsFromUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :created_at, :created
  	rename_column :users, :updated_at, :modified
  end
end
