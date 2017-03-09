class CreateProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals do |t|
      t.string :title
      t.text :body
      t.integer :voting_id

      t.timestamps
    end
  end
end
