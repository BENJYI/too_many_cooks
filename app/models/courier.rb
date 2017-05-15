class Courier < User
  belongs_to :manager, class_name: "Manager", foreign_key: "manager_id", optional: true
  delegate :restaurant, to: :manager
end