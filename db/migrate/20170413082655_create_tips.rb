class CreateTips < ActiveRecord::Migration[5.0]
  def change
    create_table :tips do |t|
      t.string :content
      t.string :category
      t.integer :votes
      t.string :user_id
      t.string :city_id
    end
  end
end
