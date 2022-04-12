require 'rails_helper'

RSpec.describe 'customer subscriptions endpoint' do
  let(:customer_1) { FactoryBot.create(:customer)}
  let(:sub_1) { FactoryBot.create(:subscription, status: 0, customer: customer_1)}
  let(:sub_2) { FactoryBot.create(:subscription, status: 1, customer: customer_1)}
  let!(:tea_1) { FactoryBot.create(:tea, subscription: sub_1)}
  let!(:tea_2) { FactoryBot.create(:tea, subscription: sub_2)}

  it 'can get all customer subscriptions' do
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
end