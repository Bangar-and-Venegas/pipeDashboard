class RemoveIdentifierFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :identifier
  end
end
