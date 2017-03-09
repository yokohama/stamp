class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :submits
  #has_many :user_proposal
  #has_many :proposals, through: :user_proposal, dependent: :destroy

  #accepts_nested_attributes_for :user_proposal
end
