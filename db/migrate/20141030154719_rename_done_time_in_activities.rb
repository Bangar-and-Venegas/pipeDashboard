class RenameDoneTimeInActivities < ActiveRecord::Migration
  def change
  	rename_column :activities, :due_time, :marked_as_done_time
  end
end
