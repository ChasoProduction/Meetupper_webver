class RemoveAlldayFromPersonalSchedule < ActiveRecord::Migration[5.1]
  def change
    remove_column :personal_schedules, :allday
  end
end
