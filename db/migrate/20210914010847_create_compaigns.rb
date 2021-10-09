class CreateCompaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :compaigns do |t|
      t.string :recipient
      t.string :artistName
      t.string :bigGoal
      t.string :bigProblem
      t.string :paragraphText
      t.float :moneyGoal

      t.timestamps
    end
  end
end
