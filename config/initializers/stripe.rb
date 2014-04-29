ENV["STRIPE_SECRET_KEY"]      ||= "sk_test_6OOkT65unRE9GbdKUrCc7Yb7"
ENV["STRIPE_PUBLISHABLE_KEY"] ||= "pk_test_ENQOtb1H1LzkJ2HEgi205nNJ"

Rails.configuration.stripe = {
  secret_key:      ENV["STRIPE_SECRET_KEY"],
  publishable_key: ENV["STRIPE_PUBLISHABLE_KEY"]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
