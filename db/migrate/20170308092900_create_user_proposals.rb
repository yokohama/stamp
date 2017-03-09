class CreateUserProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :user_proposals do |t|
      t.integer :user_id
      t.integer :proposal_id
      t.string :decision

      t.timestamps
    end
  end
end
