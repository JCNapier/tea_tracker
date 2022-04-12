class Subscription < ApplicationRecord
  validates_presence_of :title, 
                        :price, 
                        :status,
                        :frequency
                      
  belongs_to :customer

  enum status: {
    "active" => 0,
    "cancelled" => 1
  }
end
