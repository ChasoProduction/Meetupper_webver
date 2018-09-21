require 'test_helper'

class PersonalSchedulesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sample)
    @other_schedule = personal_schedules(:sample_schedule2)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'PersonalSchedule.count' do
      post personal_schedules_path params: { schedule: { content:'Sample schedule',
                                                    starts_at:Time.now + 1.hour,
                                                    ends_at:Time.now + 2.hours,
                                                    importance:1 } }
    end
    assert_redirected_to login_url
    follow_redirect!
    assert_select 'div.alert-danger'
  end
end
