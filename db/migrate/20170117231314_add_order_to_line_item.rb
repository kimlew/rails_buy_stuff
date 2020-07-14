class AddOrderToLineItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :line_items, :order, index: true, foreign_key: true
  end
end
