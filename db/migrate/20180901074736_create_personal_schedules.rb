class CreatePersonalSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :personal_schedules do |t|
      t.text :content
      t.references :user, foreign_key: true
      #time型で作ったが、ActiveSupport::TimeWithZoneを使う。
      t.time :starts_at
      t.time :ends_at
      t.integer :importance

      t.timestamps
    end
    add_index :personal_schedules, [:user_id, :starts_at]
  end
end
