require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sample)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:'', password:'' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select 'div.alert-danger'
    get root_path
    assert flash.empty?
  end

  test 'login with valid information　and logout' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:@user.email,
                                          password:'Foobar21' } }
    assert_redirected_to @user
    delete logout_path
    assert_redirected_to root_url
  end
end
