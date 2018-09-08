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

class User < ApplicationRecord
  has_many :personal_schedules, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence:true, length:{ maximum:30 }
  validates :email, presence:true, length:{ maximum:255 },
          format: { with:VALID_EMAIL_REGEX },
          uniqueness:{ case_sensitive:true }

  has_secure_password
  #パスワードは半角英数小文字、大文字、数字8~100
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{8,100}+\z/
  validates :password, presence:true,
          format: { with:VALID_PASSWORD_REGEX },
          allow_nil:true

  #ハッシュを渡す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost:cost)
  end
end
