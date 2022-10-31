class AddOrderToLineItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :line_items, :order, index: true, foreign_key: true
  end
end
