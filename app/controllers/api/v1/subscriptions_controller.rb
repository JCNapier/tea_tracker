class Api::V1::SubscriptionsController < ApplicationController 
  def create
    tea = Tea.find(tea_params[:tea_id])
    subscription = Subscription.create(subscription_params)
    TeaSubscription.create(subscription_id: subscription.id, tea_id: tea.id)
    
    if subscription.save 
      render(json: SubscriptionSerializer.new(Subscription.create(subscription_params)), status: 201)
    else 
      render :status => 404
    end
  end

  def update
    subscription = Subscription.update(params[:subscription_id], subscription_params)
    if subscription.save 
      render(json: SubscriptionSerializer.new(Subscription.update(params[:subscription_id], subscription_params)))
    else  
      render :status => 404
    end
  end

  private
  def subscription_params
    params.permit(:title, :price, :status, :frequency, :customer_id)
  end

  def tea_params
    params.permit(:tea_id)
  end
end