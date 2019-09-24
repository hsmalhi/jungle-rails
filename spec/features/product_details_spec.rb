require "rails_helper"

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset("apparel1.jpg"),
        quantity: 10,
        price: 64.99,
      )
    end
  end

  scenario "They see the product details for one product" do
    # ACT
    visit root_path

    click_link("Details", :match => :first)
    expect(page).to have_css "article.product-detail", count: 1
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Quantity")
    expect(page).to have_content("Price")
  end
end
