class CreateGoogs < ActiveRecord::Migration[5.1]
  def change
    create_table :googs do |t|

      t.timestamps
    end
  end
end
