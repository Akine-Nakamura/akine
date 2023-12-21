class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :name
      t.string :genre
      t.string :year
      t.text :about
      t.text :comment
      t.string :link

      t.timestamps
    end
  end
end
