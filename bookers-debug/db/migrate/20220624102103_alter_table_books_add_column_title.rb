class AlterTableBooksAddColumnTitle < ActiveRecord::Migration[6.1]
  def change
    change_table :books do |t|
      t.text :title
    end
  end
end
