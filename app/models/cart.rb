class Cart < ActiveRecord::Base

  has_many :line_items, dependent: :destroy
  
  def add_product(product_id)
    # Check whether list of items already includes the product we’re adding.
    # If list of items already has the product, increase the quantity.
    # If list of items does NOT already have the product, build a new LineItem.
    current_item = line_items.find_by(product_id: product_id)
  
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    
    current_item
  end # End of: def add_product(product_id)
  
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

end
