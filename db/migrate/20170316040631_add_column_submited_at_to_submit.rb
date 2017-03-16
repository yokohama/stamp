class AddColumnSubmitedAtToSubmit < ActiveRecord::Migration[5.0]
  def change
    add_column :submits, :submited_at, :datetime
  end
end
