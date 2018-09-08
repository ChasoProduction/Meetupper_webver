# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:'Testname', email:'chasobakun@gmail.com',
                    password:'Foobar21',
                    password_confirmation:'Foobar21')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ' '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'password should be present' do
    @user.password = ' '
    assert_not @user.valid?
  end

  test 'name should be less than 30 character' do
    @user.name = 'a' * 31
    assert_not @user.valid?
  end

  test 'email should be less than 255 character' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'invalid email should not be accepted' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                        foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'valid email should be accepted' do
    valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'invalid password should not be accepted' do
    invalid_passwords = %w[password1 PASSWORD2 Passwordthree]
    invalid_passwords.each do |invalid_password|
      @user.password = invalid_password
      @user.password_confirmation = invalid_password
      assert_not @user.valid?
    end
  end

  test 'valid password should be accepted' do
    valid_passwords = %w[Password1 pasSword2 3passworD]
    valid_passwords.each do |valid_password|
      @user.password = valid_password
      @user.password_confirmation = valid_password
      assert @user.valid?
    end
  end
end
