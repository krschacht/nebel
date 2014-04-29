class WebhooksController < ApplicationController

  protect_from_forgery with: :null_session

  def stripe
    event = Stripe::Event.retrieve(params[:id])

    render nothing: true and return if event.livemode == false

    if event.type == "charge.failed"
      charge = event.data.object

      if user = User.find_by(stripe_customer_id: charge.customer)
        UserMailer.charge_failed(user).deliver
      end
    end

    render nothing: true
  end

end
