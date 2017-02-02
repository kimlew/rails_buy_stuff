json.extract! product, :id, :title, :year, :materials, :width, :height, :price, :img_loc, :img_sml_loc, :created_at, :updated_at
json.url product_url(product, format: :json)