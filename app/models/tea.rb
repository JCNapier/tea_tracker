class Tea < ApplicationRecord
  validates_presence_of :title, 
                        :description, 
                        :temperature, 
                        :brew_time, 
                        :subscription_id

  belongs_to :subscription 
end
