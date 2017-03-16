class Proposal < ApplicationRecord
  belongs_to :voting
  has_many :decisions, dependent: :destroy

  validates :title, :body, presence: true
end
