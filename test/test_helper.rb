ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  ActiveRecord::Migration.check_pending!

  fixtures :all

  setup do
    ActionMailer::Base.deliveries.clear
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def login_as(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def login_as_user
    login_as users(:avand)
  end

  def login_as_admin
    login_as users(:admin)
  end

  def assert_user_required
    assert_redirected_to root_path
    assert_equal flash[:alert], "You must be logged in to do that."
  end

  def assert_admin_required
    assert_redirected_to root_path
    assert_equal flash[:alert], "You must be an admin to do that."
  end

end
