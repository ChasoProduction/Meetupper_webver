require 'test_helper'

class UserScheduleTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sample)
    @other_user = users(:sample2)
  end
end
