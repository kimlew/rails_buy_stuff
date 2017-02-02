class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :year, :materials, :img_sml_loc, presence: true
  
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  
  validates :title, uniqueness: true
  
  validates :img_sml_loc, allow_blank: false, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must end in .gif, .jpg or .png'
  }

  def self.latest 
    Product.order(:updated_at).last 
  end
  
  private
    
  # Checks no line items referencing this product before deleting
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
  
end
