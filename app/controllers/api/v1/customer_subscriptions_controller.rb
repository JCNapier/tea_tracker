class Api::V1::CustomerSubscriptionsController < ApplicationController
  def index 
    render(json: SubscriptionSerializer.new(Subscription.where(customer_id: params[:customer_id])))
  end
end