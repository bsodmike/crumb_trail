class SetUpTestTables < ActiveRecord::Migration
  def change
    create_table :logs, :force => true do |t|
      t.references :item, :polymorphic => true
      t.string :event, :null => false
      t.text :object
      t.text :object_changes

      # Metadata
      t.string :message

      t.timestamps
    end
    add_index :logs, [:item_id, :item_type]

    create_table :books, :force => true do |t|
      t.string :title

      t.timestamps
    end
  end
end
