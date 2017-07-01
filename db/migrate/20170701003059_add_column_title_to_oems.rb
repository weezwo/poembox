class AddColumnTitleToOems < ActiveRecord::Migration[5.1]
  def change
    add_column(:poems, :title, :string)
  end
end
