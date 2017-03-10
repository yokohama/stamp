class AddColumnDelegaterToSubmit < ActiveRecord::Migration[5.0]
  def change
    add_column :submits, :delegater, :string
  end
end
