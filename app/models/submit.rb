class Submit < ApplicationRecord
  belongs_to :user
  belongs_to :voting

  has_many :decisions
  accepts_nested_attributes_for :decisions
end
