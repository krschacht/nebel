class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password_hash, :access_token
end
