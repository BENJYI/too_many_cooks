class Restaurant < ApplicationRecord
  belongs_to :manager, class_name: "Manager", foreign_key: "manager_id", optional: true
  has_many :menu_items

  delegate :chefs, to: :manager
end
