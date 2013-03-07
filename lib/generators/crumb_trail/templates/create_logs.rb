class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :item, :polymorphic => true
      t.string :event, :null => false
      t.text :object
      t.text :object_changes

      # Metadata
      t.string :message

      t.timestamps
    end
    add_index :logs, [:item_id, :item_type]
  end
end
