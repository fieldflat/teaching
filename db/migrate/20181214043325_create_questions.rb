class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.string :image_name
      t.string :subject
      t.string :tag

      t.timestamps
    end
  end
end
