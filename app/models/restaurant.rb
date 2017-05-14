class Restaurant < ApplicationRecord
  include Geocodeable

  belongs_to :manager, class_name: "Manager", foreign_key: "manager_id", optional: true
  has_many :menu_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates_presence_of :address, :name

  delegate :chefs, to: :manager
end
