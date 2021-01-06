class CreateMyThreads < ActiveRecord::Migration[6.1]
  def change
    create_table :my_threads do |t|
      t.string :title, null: false, default: ''
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
