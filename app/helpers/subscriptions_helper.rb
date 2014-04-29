module SubscriptionsHelper

  def days_until(future)
    pluralize ((Time.now - future) / 60 / 60 / 24).abs.round, "day"
  end

  def billing_button_and_form
    method = current_user.stripe_customer.present? ? :patch : :post
    label  = current_user.subscribed? ? "Update Subscription" : "Subscribe"

    form_tag subscriptions_path, method: method do
      content_tag(:script, nil, {
        src:   "https://checkout.stripe.com/checkout.js",
        class: "stripe-button",
        data: {
          "label"       => label,
          "name"        => "Nebel Science",
          "key"         => Rails.configuration.stripe[:publishable_key],
          "email"       => current_user.email,
          "panel-label" => label
        }
      })
    end
  end

end
