class SetUpTestTables < ActiveRecord::Migration
  def up
    create_table :books, :force => true do |t|
      t.string :title
    end
  end

  def down
    drop_table :books
  end
end
