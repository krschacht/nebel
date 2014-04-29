module SubscriptionsHelper

  def days_until(future)
    pluralize ((Time.now - future) / 60 / 60 / 24).abs.round, "day"
  end

end
