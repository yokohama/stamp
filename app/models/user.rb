class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :set_tmp_password

  has_many :submits

  # 仮パスワードの削除
  def delete_temp_password
    self.update(temp_password: nil)
  end

  private

  def set_tmp_password
    self.temp_password = password
  end
end
