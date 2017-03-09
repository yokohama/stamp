class Proposal < ApplicationRecord
  belongs_to :voting
  has_many :decisions

  validates :title, :body, presence: true
end
