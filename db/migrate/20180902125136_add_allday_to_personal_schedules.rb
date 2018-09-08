class AddAlldayToPersonalSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :personal_schedules, :allday, :boolean, default:false
  end
end
