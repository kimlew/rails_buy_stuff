<%# Atom feed - for small number of same clients repeatedly requesting same page %>
<%# helper makes building an Atom feed easy %>
<%# format the order - as prep for feed reader %>

atom_feed do |feed|
  feed.title "Who bought #{@product.title}" 
  feed.updated @latest_order.try(:updated_at) 
  
  @product.orders.each do |order|
      
    feed.entry(order) do |entry|
    
      entry.title "Order #{order.id}"
      
      entry.summary type: 'xhtml' do |xhtml|
        xhtml.p "Shipped to #{order.address}" 
        
        xhtml.table do     
          xhtml.tr do
            xhtml.th 'Product'
            xhtml.th 'Quantity'
            xhtml.th 'Total Price'
          end
          
          order.line_items.each do |item|
            xhtml.tr do
              xhtml.td item.product.title
              xhtml.td item.quantity
              xhtml.td number_to_currency item.total_price
            end
          end
          
          xhtml.tr do
            xhtml.th 'total', colspan: 2
            xhtml.th number_to_currency \ order.line_items.map(&:total_price).sum
          end  
        end <%# End of: xhtml.table do%>
        
        xhtml.p "Paid by #{order.pay_type}"
      end <%# End of: entry.summary type: 'xhtml' do |xhtml| %>
        
      entry.author do |author|
        author.name order.name
        author.email order.email 
      end
      
    end <%# End of: feed.entry(order) do |entry| %>
    
  end <%# End of: @product.orders.each do |order| %>
  
end <%# End of: atom_feed do |feed| %>




