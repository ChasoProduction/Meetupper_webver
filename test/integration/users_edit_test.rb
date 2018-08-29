require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sample)
    @other_user = users(:sample2)
  end

  test 'not loggined user' do
    get edit_user_path(@user)
    #テストではこの時点ではリダイレクトされていない。
    assert_redirected_to login_url
    #リダイレクトに従うことを表している。ここでリダイレクト先に移動する。
    follow_redirect!
    assert_select 'div.alert-danger'
  end

  test 'loggined user invalid edit information' do
    #正しくない情報だとeditに戻り、errorを表示させる
    post login_path, params: { session: { email:@user.email,
                                          password:'Foobar21' } }
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:'',
                    email:'invalid@address',
                    password:'Foo',
                    password_confirmation:'Bar' } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation'
  end

  test 'loggined user valid edit information' do
    post login_path, params: { session: { email:@user.email,
                                          password:'Foobar21' } }
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name:'Sameple2',
                    email:'valid@address.com',
                    password:'ValidPassword1',
                    password_confirmation:'ValidPassword1' } }
    assert_redirected_to user_url(@user)
  end

  test 'loggined user valid edit information without password' do
    post login_path, params: { session: { email:@user.email,
                                          password:'Foobar21' } }
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name:'Sameple2',
                    email:'valid@address.com',
                    password:'',
                    password_confirmation:'' } }
    assert_redirected_to user_url(@user)
  end

  #実装前
  test 'user can`t edit other user' do
    post login_path, params: { session: { email:@user.email,
                                          password:'Foobar21' } }
    get edit_user_path(@other_user)
    assert_redirected_to user_url(@user)
    follow_redirect!
    assert_select 'div.alert-danger'
  end
end
