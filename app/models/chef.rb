class Chef < User
  belongs_to :manager, class_name: "Manager", foreign_key: "manager_id", optional: true
  has_many :menu_items, dependent: :destroy
  delegate :restaurant, to: :manager
end
