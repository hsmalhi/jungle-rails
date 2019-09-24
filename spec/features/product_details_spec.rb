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
    page.has_content?("Name")
    page.has_content?("Description")
    page.has_content?("Quantity")
    page.has_content?("Price")
  end
end
