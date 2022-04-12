require 'rails_helper'

RSpec.describe 'customer subscriptions endpoints' do
  context 'happy paths' do 
    it 'can get all customer subscriptions' do
      customer_1 = FactoryBot.create(:customer)
      sub_1 = FactoryBot.create(:subscription, status: 0, customer: customer_1)
      sub_2 = FactoryBot.create(:subscription, status: 1, customer: customer_1)
      tea_1 = FactoryBot.create(:tea, subscription: sub_1)
      tea_2 = FactoryBot.create(:tea, subscription: sub_2)
      
      get "/api/v1/customers/#{customer_1.id}/subscriptions"
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful
      
      expect(json).to be_a(Hash)
      expect(json[:data]).to be_an(Array)
      
      json[:data].each do |sub|
        expect(sub[:id]).to be_a(String)
        expect(sub[:type]).to be_a(String)
        expect(sub[:attributes]).to be_a(Hash)
        expect(sub[:attributes][:title]).to be_a(String)
        expect(sub[:attributes][:price]).to be_a(Float)
        expect(sub[:attributes][:status]).to be_a(String)
        expect(sub[:attributes][:frequency]).to be_a(String)
      end
    end
    
    it 'can create a subscription' do 
      customer_1 = FactoryBot.create(:customer)
      
      subscription_params = ({
        title: "Legendary", 
        price: 10.00, 
        status: 0,
        frequency: "High",
        customer_id: customer_1.id
        })
        
      headers = {"CONTENT_TYPE" => "application/json"}
      
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)
      
      created_subscription = Subscription.last
      
      expect(response).to be_successful
      
      expect(created_subscription.id).to be_a(Integer)
      expect(created_subscription.title).to be_a(String)
      expect(created_subscription.price).to be_a(Float)
      expect(created_subscription.status).to be_a(String)
      expect(created_subscription.frequency).to be_a(String)
      expect(created_subscription.customer_id).to be_a(Integer)
    end
    
    it 'can update a subscription' do 
      customer_1 = FactoryBot.create(:customer)
      sub_1 = FactoryBot.create(:subscription, status: 0, customer: customer_1)
      previous_status = Subscription.last.status 
      subscription_params = { status: 1 }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch "/api/v1/subscriptions/#{sub_1.id}", headers: headers, params: JSON.generate({subscription: subscription_params})
      
      subscription = Subscription.find_by(id: sub_1.id)
      
      expect(response).to be_successful 
      expect(subscription.status).to_not eq(sub_1.status)
      expect(subscription.status).to eq("cancelled")
    end
  end

  context 'sad paths' do 
    it 'returns a 404 if subscription cant be created' do 
      customer_1 = FactoryBot.create(:customer)
  
      subscription_params = ({
        title: nil, 
        price: 10.00, 
        status: 0,
        frequency: "High",
        customer_id: customer_1.id
        })
        
      headers = {"CONTENT_TYPE" => "application/json"}
      
      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end

    it 'returns a 404 if subscription cant be updated' do 
      customer_1 = FactoryBot.create(:customer) 
      sub_1 = FactoryBot.create(:subscription, status: 0, customer: customer_1)
      
      subscription_params = { status: nil }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch "/api/v1/subscriptions/#{sub_1.id}", headers: headers, params: JSON.generate({subscription: subscription_params})
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end
  end
end