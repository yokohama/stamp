class CreateSubmits < ActiveRecord::Migration[5.0]
  def change
    create_table :submits do |t|
      t.integer :user_id
      t.integer :voting_id

      t.timestamps
    end
  end
end
