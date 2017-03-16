class Voting < ApplicationRecord
  has_many :proposals, dependent: :destroy
  accepts_nested_attributes_for :proposals, allow_destroy: true, reject_if: :valid_empty

  has_many :submits, dependent: :destroy
  accepts_nested_attributes_for :submits, allow_destroy: true

  validates :title, :description, presence: true

  def valid_empty(attributes)
    if (attributes[:title].blank? && attributes[:body].blank?)
      attributes[:_destroy] = 1
    end
  end
end
