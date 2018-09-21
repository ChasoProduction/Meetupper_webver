# == Schema Information
#
# Table name: personal_schedules
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  starts_at  :datetime
#  ends_at    :datetime
#  importance :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PersonalSchedule < ApplicationRecord
  belongs_to :user

  validates :user_id, presence:true
  validates :content, presence:true
  validates :starts_at, presence:true
  validates :ends_at, presence:true
  validates :importance, presence:true, inclusion: { in: 1..3 }
  validate :start_validate
  validate :time_validate

  def starts_at_format
    starts_at.strftime("%Y年%-m月%-d日%H:%M")
  end

  def ends_at_format
    ends_at.strftime("%Y年%-m月%-d日%H:%M")
  end

  private
    def time_validate
      if !starts_at.blank? && !ends_at.blank?
        if starts_at > ends_at
          errors.add(:starts_at, 'Invalid time duration.')
        end
      end
    end

    def start_validate
      if !starts_at.blank?
        if starts_at < Time.zone.now
          errors.add(:starts_at, 'Invalid start time.')
        end
      end
    end
end
