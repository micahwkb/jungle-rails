require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
     @category = Category.create! name: 'Apparel'

     10.times do |n|
       @category.products.create!(
         name:  Faker::Hipster.sentence(3),
         description: Faker::Hipster.paragraph(4),
         image: open_asset('apparel1.jpg'),
         quantity: 10,
         price: 64.99
       )
     end
   end

   scenario "They see a product's details when clicked" do
     visit root_path
     click_link('Details', :href => product_path(id: 8))

     # VERIFY
     expect(page).to have_css 'section.products-show'
     expect(page).to have_current_path(product_path(id: 8))
     # save_screenshot
   end

   scenario "They are redirected to root when visiting an invalid product link" do
    # invalid product
    visit product_path(id: 11)
    expect(page).to have_current_path(root_path)
   end
end
