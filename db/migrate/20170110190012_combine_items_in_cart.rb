class CombineItemsInCart < ActiveRecord::Migration[7.0]
  def up
    # Replace multiple items for a single product in a cart with a single item

    Cart.all.each do |cart|
      # Get the quantity of each of the line items associated with this cart
      # grouped by product_id, i.e., get quantities of product per line item.
      # sums = list of ordered pairs of product_ids and quantity

      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        # Get product_id and quantity from each sum in list.
        if quantity > 1
          # Delete all individual line items associated with this cart and
          # this product.
          cart.line_items.where(product_id: product_id).delete_all

          # Replace deleted line items with single line item with correct
          # quantity.
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end # End of: if quantity > 1
      end # End of: sums.each do |product_id, quantity|

    end # End of: Cart.all.each do |cart|
  end # End of: def up

  def down
    # Find, then split, items with quantity > 1 into multiple items.
    LineItem.where("quantity > 1").each do |line_item|

      # Add individual items as new line items for this cart and product,
      # each with a quantity of 1
      line_item.quantity.times do
        LineItem.create cart_id: line_item.cart_id,
          product_id: line_item.product_id, quantity: 1
      end # End of: line_item.quantity.times do

      # Delete the line item, i.e., the original item.
      line_item.destroy
    end # End of: LineItem.where("quantity>1").each do |line_item|

  end # End of: def down

end # End of class
