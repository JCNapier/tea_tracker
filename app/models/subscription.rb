class Subscription < ApplicationRecord
  validates_presence_of :title, 
                        :price, 
                        :status,
                        :frequency
                      
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions 
end
