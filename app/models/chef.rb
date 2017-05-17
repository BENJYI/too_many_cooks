class Chef < User
  belongs_to :manager, class_name: "Manager", foreign_key: "manager_id", optional: true
  has_many :menu_items, dependent: :destroy
  delegate :restaurant, to: :manager
  enum status: { fired: -2, danger: -1, neutral: 0, good: 1, great: 2, excellent: 3 }

  PROMOTION_STEPS = Chef.statuses.keys.freeze

  def upvote
    return if excellent?
    vote amount: 1
  end

  def downvote
    return if fired?
    vote amount: -1
  end

  def reset_promotion_step!(status: :neutral, updown: 0)
    self.update status: status, updown: updown
  end

  private
  def reset_updown_if_necessary!
    self.update(updown: 0) if self.updown.abs >= 3
  end

  def promote_or_demote_if_necessary!
    curr_index = PROMOTION_STEPS.find_index(self.status)
    new_status = if self.updown >= 3 # PROMOTE
      PROMOTION_STEPS[curr_index + 1]
    elsif self.updown <= -3 # DEMOTE!
      PROMOTION_STEPS[curr_index - 1]
    end
    self.update status: new_status unless new_status.nil?
  end

  def vote(amount:)
    self.update updown: (self.updown + amount)
    promote_or_demote_if_necessary!
    reset_updown_if_necessary!
  end

end
