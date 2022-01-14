json.extract! epa_product, :id, :name, :price, :product_dimensions, :package_dimensions, :need_assembly, :created_at, :updated_at
json.url epa_product_url(epa_product, format: :json)
