class MenuItem < ApplicationRecord
  belongs_to :restaurant

  validates_presence_of :name, :price
end
