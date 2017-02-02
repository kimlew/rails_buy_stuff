require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  
  # Test for required fields
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
  
    assert product.errors[:title].any?
    assert product.errors[:year].any?
    assert product.errors[:materials].any?

    assert product.errors[:price].any?
    assert product.errors[:img_sml_loc].any?
  end
  
  # Test for unique title
  test "product only valid with unique title" do
    # Include passed parameter of default_title:'Tea' to create error
    # since Tea already in database, initially-populated by db/seeds.rb.
    product = create_new_product(default_title:'Tea')

    assert product.invalid?
    # Customized hard-coded error message to user
    assert_equal ["has already been taken"], product.errors[:title]
    
    # Built-in error message table message to user
    #assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  # Test for price - must be a positive number
  # Create new product, then set price to -1, 0, and +1, validating product 
  # each time.
  test "product price must be positive" do
    product = create_new_product()
      
    product.price = -1 # Price that overwrites initial price
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
    
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
    
    product.price = 1
    assert product.valid?
  end
  
   test "product price is negative" do
    product = create_new_product()
      
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
  end
  
  test "product price is zero" do
    product = create_new_product()
    
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
  end
   
  test "product price is positive" do
    product = create_new_product()

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
    product.errors[:price]
  end
  
  test "valid image path and extension" do
    ok = %w{ /assets/fred.gif /assets/fred.jpg /assets/fred.png FRED.JPG FRED.Jpg
      http://a.b.c/x/y/z/fred.gif }
  
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
  
    # Expect to pass validation 
    ok.each do |img_path_ext|
      assert create_new_product(default_img_loc:img_path_ext).valid?, 
        "#{img_path_ext} should be valid"
    end
  
    # Expect to fail validation
    bad.each do |img_path_ext|
      assert create_new_product(default_img_loc:img_path_ext).invalid?, 
        "#{img_path_ext} shouldn't be valid"
    end
  end

  # create_new_product() - helper method
  # optional parameters - can be included or not
  def create_new_product(default_img_loc:'/assets/another_title.jpg', 
    default_title: 'Another Title')
    # Removed:(input='/assets/another_title.jpg')
    product = Product.new(title: default_title,
      year: 2000,
      materials: 'pen on paper',
      width: 6.00,
      height: 9.00,
      price: 1.50, # Initial price - overwritten in individual tests
      img_sml_loc: default_img_loc)
      #'/assets/another_title.jpg')
  end

end
