class ChangeColumnToUser < ActiveRecord::Migration[5.1]
  def up
    change_column :personal_schedules, :starts_at, :datetime
    change_column :personal_schedules, :ends_at, :datetime
  end

  def down
    change_column :personal_schedules, :starts_at, :time
    change_column :personal_schedules, :ends_at, :time
  end
end
