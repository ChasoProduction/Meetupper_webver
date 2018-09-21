require 'test_helper'

class UserScheduleTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sample)
    @other_schedule = personal_schedules(:sample_schedule2)
    @time = Time.zone.local(2100, 2, 10, 0, 0, 0)
  end

  test 'valid scheduling' do
    post login_path params: { session: { email:@user.email,
                                         password:'Foobar21' } }
    assert_redirected_to user_url(@user)
    follow_redirect!
    assert_select 'div.schedule-form'
    assert_difference 'PersonalSchedule.count', 1 do
      post personal_schedules_path params: { schedule: { content:'Test',
                                                    starts_at:@time,
                                                    ends_at:@time + 1.hours,
                                                    importance:1 } }
    end
  end

  test 'delete other user`s schedule' do
    post login_path params: { session: { email:@user.email,
                                         password:'Foobar21' } }
    assert_no_difference 'PersonalSchedule.count' do
      delete personal_schedule_path(@other_schedule)
    end
  end
end
