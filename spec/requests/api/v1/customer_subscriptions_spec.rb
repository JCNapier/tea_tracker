require 'rails_helper'

RSpec.describe 'customer subscriptions endpoints' do
  let(:customer_1) {Customer.create!(first_name: "Oswald", last_name: "Cobblepot", email: "penguin@gotham.com", address: "936 IceBox Ave.")}
  let!(:sub_1) {customer_1.subscriptions.create!(title: "legendary", price: 10.00, status: 0, frequency: "High", customer_id: customer_1)}
  let!(:sub_2) {customer_1.subscriptions.create!(title: "common", price: 5.00, status: 1, frequency: "Medium", customer_id: customer_1)}
  let!(:tea_1) {Tea.create!(title: "Chamomile", description: "Promotes Sleep", temperature: 100, brew_time: 8)}
  
  context 'happy paths' do 
    it 'can get all customer subscriptions' do
      
      get api_v1_customer_subscriptions_path(customer_1)
      
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
      subscription_params = ({
        title: "Legendary", 
        price: 10.00, 
        status: 0,
        frequency: "High",
        tea_id: tea_1.id
        })
        
      headers = {"CONTENT_TYPE" => "application/json"}
      
      post api_v1_customer_subscriptions_path(customer_1), headers: headers, params: JSON.generate(subscription_params)
      
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
      previous_status = Subscription.last.status 
      
      subscription_params = { status: 0 }
      
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch api_v1_customer_subscription_path(customer_1, sub_1), headers: headers, params: JSON.generate(subscription_params)
      
      subscription = Subscription.find_by(id: sub_1.id)
      
      expect(response).to be_successful 
      expect(subscription.status).to_not eq(previous_status)
      expect(subscription.status).to eq("active")
    end
  end

  context 'sad paths' do 
    it '#create returns a 404 if title is left blank' do 
      subscription_params = ({
        title: nil, 
        price: 10.00, 
        status: 0,
        frequency: "High",
        tea_id: tea_1.id
        })
        
      headers = {"CONTENT_TYPE" => "application/json"}
      
      post api_v1_customer_subscriptions_path(customer_1), headers: headers, params: JSON.generate(subscription_params)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end

    it '#create returns a 404 if price is left blank' do 
      subscription_params = ({
        title: "Legendary", 
        price: nil, 
        status: 0,
        frequency: "High",
        tea_id: tea_1.id
        })
        
      headers = {"CONTENT_TYPE" => "application/json"}
      
      post api_v1_customer_subscriptions_path(customer_1), headers: headers, params: JSON.generate(subscription_params)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end

    it '#create returns a 404 if status is left blank' do 
      subscription_params = ({
        title: "Legendary", 
        price: 10.00, 
        status: nil,
        frequency: "High",
        tea_id: tea_1.id
        })
        
      headers = {"CONTENT_TYPE" => "application/json"}
      
      post api_v1_customer_subscriptions_path(customer_1), headers: headers, params: JSON.generate(subscription_params)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end

    it '#create returns a 404 if frequency is left blank' do 
      subscription_params = ({
        title: "Legendary", 
        price: 10.00, 
        status: 0,
        frequency: nil,
        tea_id: tea_1.id
        })
        
      headers = {"CONTENT_TYPE" => "application/json"}
      
      post api_v1_customer_subscriptions_path(customer_1), headers: headers, params: JSON.generate(subscription_params)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end

    it '#create returns a 404 if tea_id is left blank' do 
      subscription_params = ({
        title: "Legendary", 
        price: 10.00, 
        status: 0,
        frequency: "high",
        tea_id: nil
        })
        
      headers = {"CONTENT_TYPE" => "application/json"}
      
      post api_v1_customer_subscriptions_path(customer_1), headers: headers, params: JSON.generate(subscription_params)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end

    it '#update returns a 404 if title is nil' do 
      subscription_params = { title: nil }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch api_v1_customer_subscription_path(customer_1.id, sub_1.id), headers: headers, params: JSON.generate(subscription_params)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end

    it '#update returns a 404 if price is nil' do 
      subscription_params = { price: nil }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch api_v1_customer_subscription_path(customer_1.id, sub_1.id), headers: headers, params: JSON.generate(subscription_params)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end
    
    it '#update returns a 404 if status is nil' do 
      subscription_params = { status: nil }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch api_v1_customer_subscription_path(customer_1.id, sub_1.id), headers: headers, params: JSON.generate(subscription_params)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end

    it '#update returns a 404 if frequency is nil' do 
      subscription_params = { frequency: nil }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch api_v1_customer_subscription_path(customer_1.id, sub_1.id), headers: headers, params: JSON.generate(subscription_params)
      
      expect(response).to_not be_successful 
      expect(response.status).to eq(404)
    end
  end
end