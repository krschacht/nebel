require "bcrypt"
require "securerandom"

class User < ActiveRecord::Base

  include BCrypt

  has_many :messages, foreign_key: :author_id
  has_many :completions

  validates_presence_of :name, :email, :password_hash, :access_token, :trial_ends_at
  validates_uniqueness_of :email

  before_validation :generate_access_token
  before_validation :set_trial_ends_at

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

  def stripe_customer
    return nil unless stripe_customer_id
    @stripe_customer ||= Stripe::Customer.retrieve stripe_customer_id
  end

  def subscribed?
    stripe_customer.present? &&
    stripe_customer.subscription.present? &&
    !(stripe_customer.respond_to?(:deleted) && stripe_customer.deleted)
  end

private

  def generate_access_token
    self.access_token ||= SecureRandom.hex(20)
  end

  def set_trial_ends_at
    self.trial_ends_at ||= 30.days.from_now
  end

end
