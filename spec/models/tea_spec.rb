require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do 
    it { should belong_to(:subscription) }
  end

  describe 'validations' do 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:temperature) }
    it { should validate_presence_of(:brew_time) }
    it { should validate_presence_of(:subscription_id) }
  end
end
