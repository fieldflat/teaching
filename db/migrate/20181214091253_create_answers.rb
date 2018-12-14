class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.text :content
      t.string :image_name

      t.timestamps
    end
  end
end
