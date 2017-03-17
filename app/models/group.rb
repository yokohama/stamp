class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  accepts_nested_attributes_for :user_groups, allow_destroy: true

  validates :name, presence: true
end
