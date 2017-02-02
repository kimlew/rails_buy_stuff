# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# - - - - - 
# title:string description:text width:decimal height:decimal 
# price:decimal img_loc:string  img_sml_loc:string

Product.delete_all

Product.create!(title: 'Tea',
  year: 2017,
  materials: 'black ink drawing of tea cup',
  width: 6.00,
  height: 4.00, 
  price: 36.00,
  img_loc: '/assets/tea.jpg', 
  img_sml_loc: '/assets/tea_sml.jpg')
# . . .
Product.create!(title: 'Rhino',
  year: 2016,
  materials: 'black ink drawing of rhino',
  width: 5.00,
  height: 3.00, 
  price: 29.00,
  img_loc: '/assets/rhino.jpg', 
  img_sml_loc: '/assets/rhino_sml.jpg')
# . . .
Product.create!(title: 'Tree',
  year: 2015,
  materials: 'black ink drawing of tree',
  width: 7.00,
  height: 3.50, 
  price: 40.00,
  img_loc: '/assets/tree.jpg', 
  img_sml_loc: '/assets/tree_sml.jpg')
# . . .


