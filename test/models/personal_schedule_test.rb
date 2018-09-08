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

require 'test_helper'

class PersonalScheduleTest < ActiveSupport::TestCase
  def setup
    @time = Time.zone.now + 1.hours
    @user = users(:sample)
    @personal_schedule = @user.personal_schedules.build(content:'Lorem ipsum',
                                            starts_at:@time,
                                            ends_at:@time + 1.day,
                                            importance:1)
  end

  test 'should be vaild' do
    #assert_eaual(expect, actual)
    assert_equal @time, @personal_schedule.starts_at
    assert @personal_schedule.valid?
  end

  test 'content should be present' do
    @personal_schedule.content = ''
    assert_not @personal_schedule.valid?
  end

  test 'starts_at should be present' do
    @personal_schedule.starts_at = nil
    assert_not @personal_schedule.valid?
  end

  test 'ends_at should be present' do
    @personal_schedule.ends_at = nil
    assert_not @personal_schedule.valid?
  end

  test 'importance should be 1 or 2 or 3' do
    @personal_schedule.importance = 0
    assert_not @personal_schedule.valid?
  end

  test 'starts_at should be earlier than ends_at' do
    @personal_schedule.ends_at = @personal_schedule.starts_at - 1.day
    assert_equal @time - 1.day, @personal_schedule.ends_at
    assert_not @personal_schedule.valid?
  end

  test 'starts_at should be after than now' do
    @personal_schedule.starts_at = Time.zone.now - 1.hours
    assert_not @personal_schedule.valid?
  end
end
