require "bcrypt"
require "securerandom"

class User < ActiveRecord::Base

  include BCrypt

  has_many :messages, foreign_key: :author_id

  validates_presence_of :name, :email, :password_hash, :access_token
  validates_uniqueness_of :email

  before_validation :generate_access_token

  scope :admins,   ->         { where(admin: true) }
  scope :by_email, -> (email) { where("LOWER(email) = LOWER(?)", email) }

  def password
    password_hash ? Password.new(password_hash) : nil
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end

  def initials
    name.split(" ").map(&:first).join.upcase
  end

private

  def generate_access_token
    self.access_token ||= SecureRandom.hex(20)
  end

end
