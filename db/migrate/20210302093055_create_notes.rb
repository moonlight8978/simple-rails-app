class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.belongs_to :user

      t.string :title, index: true
      t.text :content
      t.boolean :important, default: false

      t.timestamps
    end
  end
end
