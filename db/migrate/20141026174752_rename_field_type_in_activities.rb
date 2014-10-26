class RenameFieldTypeInActivities < ActiveRecord::Migration
  def change
  	rename_column :activities, :type, :activity_type
  end
end
