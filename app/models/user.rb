class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence:true, length:{ maximum:30 }
  validates :email, presence:true, length:{ maximum:255 },
          format: { with:VALID_EMAIL_REGEX },
          uniqueness:{ case_sensitive:true }

  has_secure_password
  #パスワードは半角英数小文字、大文字、数字8~100
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{8,100}+\z/
  validates :password, presence:true,
          format: { with:VALID_PASSWORD_REGEX }
end
