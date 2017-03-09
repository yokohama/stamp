class CreateDecisions < ActiveRecord::Migration[5.0]
  def change
    create_table :decisions do |t|
      t.integer :submit_id
      t.integer :proposal_id
      t.string :decision

      t.timestamps
    end
  end
end
