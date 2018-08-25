require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:'',
                                        email:'user@invalid',
                                        password:'Foobar21',
                                        password_confirmation:'Foobar21' } }
    end
    assert_template 'users/new'
  end

  test 'valid signup information' do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:'Testuser',
                                         email:'Test@example.com',
                                         password:'Foobar21',
                                         password_confirmation:'Foobar21' } }
    end
    assert_redirected_to root_url
  end
end
