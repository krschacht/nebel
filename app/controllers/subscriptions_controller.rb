class SubscriptionsController < ApplicationController

  before_action :require_user

  def new
  end

  def create
    trial_end = current_user.trial_ends_at.past? ? "now" : current_user.trial_ends_at.to_i

    customer = Stripe::Customer.create({
      email:     current_user.email,
      card:      params[:stripeToken],
      plan:      "basic",
      trial_end: trial_end
    })

    current_user.update_attribute :stripe_customer_id, customer.id

    redirect_to edit_user_path(current_user), notice: "You are now subscribed!"
  end

  def update
    current_user.stripe_customer.update_subscription({
      card: params[:stripeToken],
      plan: "basic"
    })

    redirect_to edit_user_path(current_user), notice: "Your card has been updated!"
  end

  def destroy
    customer = current_user.stripe_customer
    customer.cancel_subscription

    redirect_to edit_user_path(current_user), notice: "Your subscription has been cancelled."
  end

end
