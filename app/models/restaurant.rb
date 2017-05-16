class Restaurant < ApplicationRecord
  include Geocodeable

  MAX_STAR_RATING = 5

  belongs_to :manager, class_name: "Manager", foreign_key: "manager_id", optional: true
  has_many :menu_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates_presence_of :address, :name

  delegate :chefs, to: :manager
  delegate :couriers, to: :manager

  def rating
    menu_item_feedbacks = MenuItemFeedback.where(menu_item: menu_items)
    rated_feedbacks = menu_item_feedbacks.where.not(rating: nil)
    return 0 if rated_feedbacks.count == 0
    star_count = (rated_feedbacks.sum{|feedback| feedback.rating } / rated_feedbacks.count.to_f).round
    return star_count
  end

  def pretty_rating
    return "not-yet-rated" if rating == 0
    "#{rating}-stars"
  end
end
