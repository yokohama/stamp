class Submit < ApplicationRecord
  belongs_to :user
  belongs_to :voting

  has_many :decisions
  accepts_nested_attributes_for :decisions

      
  def send_invite_submittion_mail
    UserMailer.invite_submittion(self).deliver
  end
end
