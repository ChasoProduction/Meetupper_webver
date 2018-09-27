require 'test_helper'

class UserScheduleTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sample)
    @schedule = @user.personal_schedules.first
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
      post personal_schedules_path params: { personal_schedule: { content:'Test',
                                                    starts_at:@time,
                                                    ends_at:@time + 1.hours,
                                                    importance:1 } }
    end
  end

  test 'delete user`s schedule' do
    post login_path params: { session: { email:@user.email,
                                         password:'Foobar21' } }
    assert_no_difference 'PersonalSchedule.count' do
      delete personal_schedule_path(@other_schedule)
    end
    assert_redirected_to user_url(@user)
    follow_redirect!
    assert_difference 'PersonalSchedule.count', -1 do
      delete personal_schedule_path(@schedule)
    end
  end

  test 'edit user`s schedule' do
    post login_path params: { session: { email:@user.email,
                                         password:'Foobar21' } }
    #他人の予定を変更しようとする
    get edit_personal_schedule_path(@other_schedule)
    assert_redirected_to user_url(@user)
    follow_redirect!
    assert_select 'div.alert-danger'
    #自身の予定
    get edit_personal_schedule_path(@schedule)
    #正常な場合のviewの確認
    assert_select 'div#schedule-edit'
    #無効な変更
    patch personal_schedule_path params: { personal_schedule: { content:'',
                                                starts_at:@time,
                                                ends_at:@time - 1.hours,
                                                importance:4 } }
    #画面を繰り返し、エラーメッセージが現れる。（要確認）
    assert_redirected_to edit_personal_schedule_url(@schedule)
    follow_redirect!
    assert_select 'div#error_explanation'
    #有効な変更
    patch personal_schedule_path params: { personal_schedule: { content:'Another',
                                                starts_at:@time,
                                                ends_at:@time + 1.days,
                                                importance:2 } }
    #ホーム画面に戻り、変更完了のflashが現れる。
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'div.alert-info'
  end
end
