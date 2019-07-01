class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.text  :title, null: false
      t.text  :sentence,  null: false

      t.timestamps null: false
    end
  end
end
