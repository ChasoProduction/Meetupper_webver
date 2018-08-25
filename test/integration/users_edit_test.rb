require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sample)
  end

  test 'invalid edit information' do
    #正しくない情報だとeditに戻り、errorを表示させる
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name:'',
                    email:'invalid@address',
                    password:'Foo',
                    password_confirmation:'Bar' } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation'
  end

  test 'valid edit information' do
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name:'Sameple2',
                    email:'valid@address.com',
                    password:'ValidPassword1',
                    password_confirmation:'ValidPassword1' } }
    assert_redirected_to user_url(@user)
  end

  test 'valid edit information without password' do
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name:'Sameple2',
                    email:'valid@address.com',
                    password:'',
                    password_confirmation:'' } }
    assert_redirected_to user_url(@user)
  end
end
