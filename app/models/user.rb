class User < ApplicationRecord
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerize :status, in: %i(inviting registrated)

  before_save :set_tmp_password

  has_many :submits, dependent: :destroy

  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups

  validates :name, presence: true

  # 仮パスワードの削除
  def delete_temp_password
    self.update(temp_password: nil)
  end

  # 仮パスワードを一旦本番パスワードに入れる
  def build_password
    self.password = self.temp_password
    self.password_confirmation = self.temp_password
  end

  private

  def set_tmp_password
    self.temp_password = password
  end
end
