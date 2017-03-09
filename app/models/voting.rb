class Voting < ApplicationRecord
  attr_accessor :submited_at

  has_many :proposals
  accepts_nested_attributes_for :proposals, allow_destroy: true, reject_if: :valid_empty

  has_many :submits

  def valid_empty(attributes)
    if (attributes[:title].blank? && attributes[:body].blank?)
      attributes[:_destroy] = 1
    end
  end

  def unsubmit_users
    (User.all.map(&:id) - self.submits.map(&:user_id)).collect do |u_id|
      User.find u_id
    end
  end
end
