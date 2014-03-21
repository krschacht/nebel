require "bcrypt"
require "securerandom"

class User < ActiveRecord::Base

  include BCrypt

  validates_presence_of :name, :email, :password_hash, :access_token

  before_validation :generate_access_token

  def password
    Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end

private

  def generate_access_token
    self.access_token ||= SecureRandom.hex(20)
  end

end
